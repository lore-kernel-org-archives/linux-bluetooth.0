Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3E1C911D-7198-4FFB-9E13-1D01662B4C9B@holtmann.org>
References: <20140508225001.2A395100DB2@puck.mtv.corp.google.com>
	<3E1C911D-7198-4FFB-9E13-1D01662B4C9B@holtmann.org>
Date: Thu, 8 May 2014 19:35:45 -0700
Message-ID: <CAGXr9JFh_o1r-u+WVBg-fzrpOOz72YDArFFe=9J-RfG-7RT6_Q@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Add Broadcom patch RAM support
From: Petri Gynther <pgynther@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, May 8, 2014 at 4:17 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Petri,
>
>> After hardware reset, some BCM Bluetooth adapters obtain their initial f=
irmware
>> from OTPROM chip. Once this initial firmware is running, the firmware ca=
n be
>> further upgraded over HCI interface with .hcd files provided by Broadcom=
. This
>> is also known as "patch RAM" support. This change implements that.
>>
>> If the .hcd file is not found in /lib/firmware, BCM Bluetooth adapter co=
ntinues
>> to operate with the initial firmware. Sample kernel log:
>>  hotplug: sys=3Dfirmware act=3Dadd fw=3Dbrcm/BCM20702A0-0a5c-22be.hcd de=
v=3D...
>>  Bluetooth: hci0: BCM: patch brcm/BCM20702A0-0a5c-22be.hcd not found
>>
>> If the .hcd file is found, btusb driver pushes it to the BCM Bluetooth a=
dapter and
>> it starts using the new firmware. Sample kernel log:
>>  hotplug: sys=3Dfirmware act=3Dadd fw=3Dbrcm/BCM20702A0-0a5c-22be.hcd de=
v=3D...
>>  Bluetooth: hci0: BCM: patching hci_ver=3D06 hci_rev=3D1000 lmp_ver=3D06=
 lmp_subver=3D220e
>>  Bluetooth: hci0: BCM: firmware hci_ver=3D06 hci_rev=3D1389 lmp_ver=3D06=
 lmp_subver=3D220e
>>
>> Above, we can see that hci_rev goes from 1000 to 1389 as a result of the=
 upgrade.
>
> so I tested this with an off the shelf USB dongle now and a firmware conv=
erted with the hex2hcd utility (which we most likely should just include in=
 bluez.git).
>
> [193812.000971] Bluetooth: hci0: BCM: patching hci_ver=3D06 hci_rev=3D100=
0 lmp_ver=3D06 lmp_subver=3D220e
> [193812.738603] Bluetooth: hci0: BCM: firmware hci_ver=3D06 hci_rev=3D153=
a lmp_ver=3D06 lmp_subver=3D220e
>
> Of course I have no idea what kind of bugs this new firmware now fixes. I=
 am also almost certain that just based on the lmp_subver and hci_rev we co=
uld pick a firmware to load. And it would be nice if Broadcom starts puttin=
g firmware files in linux-firmware.git like any other company.
>
> Anyhow, one minor thing that bugs me is this:
>
> [193452.790194] Bluetooth: hci0: BCM: patch brcm/BCM20702A0-0a5c-21e8.hcd=
 not found
>
> While I want the firmware loading available for all Broadcom controllers,=
 I do think we might have to mark some of them as firmware absolutely requi=
red since otherwise they will not work. And in that case we should print th=
e error. Otherwise we might just silently not print anything. Thoughts?
>

I understand. So, we really need two cases,
BTUSB_BCM_PATCHRAM_REQUIRED and BTUSB_BCM_PATCHRAM_OPTIONAL.

For BTUSB_BCM_PATCHRAM_REQUIRED, I would go with:
  BT_ERR("%s: BCM: required patch %s not found, adapter setup failed",
hdev->name, fw_name);
  return -ENOENT;

For BTUSB_BCM_PATCHRAM_OPTIONAL, I would still display informational messag=
e:
  BT_INFO("%s: BCM: optional patch %s not found, operating with
default firmware", hdev->name, fw_name);
  return 0;

Can we easily access id->driver_info flags in btusb_setup_bcm_patchram()?

Thanks for applying this patch.

-- Petri

>> Signed-off-by: Petri Gynther <pgynther@google.com>
>> ---
>> drivers/bluetooth/btusb.c | 155 ++++++++++++++++++++++++++++++++++++++++=
+++++-
>> 1 file changed, 154 insertions(+), 1 deletion(-)
>
> Patch has been applied to bluetooth-next tree.
>
> Regards
>
> Marcel
>
