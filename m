Return-Path: <martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <109FA59C-9875-4EAA-9DA5-EC811BAA77AE@holtmann.org>
References: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
 <20171117223543.32429-6-martin.blumenstingl@googlemail.com> <109FA59C-9875-4EAA-9DA5-EC811BAA77AE@holtmann.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 19 Nov 2017 21:38:43 +0100
Message-ID: <CAFBinCCtHUFMbbSOeKWYSJZKvFbNqhaMOrS-xgzr3E9hbkpnnw@mail.gmail.com>
Subject: Re: [RFC v1 5/8] Bluetooth: btrtl: add support for the RTL8723BS and
 RTL8723DS chips
To: Marcel Holtmann <marcel@holtmann.org>
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	mark.rutland@arm.com, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, gregkh@linuxfoundation.org, jslaby@suse.com,
	johan@kernel.org, linux-sunxi@googlegroups.com,
	linux-amlogic@lists.infradead.org, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Nov 19, 2017 at 9:25 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Martin,
>
>> The Realtek RTL8723BS and RTL8723DS chipsets are SDIO wifi chips. They
>> also contain a Bluetooth module which is connected via UART to the host.
>>
>> Realtek's userspace initialization tool (rtk_hciattach) differentiates
>> these two via the HCI version and revision returned by the
>> HCI_OP_READ_LOCAL_VERSION command.
>> Additionally we apply these checks only the for UART devices. Everything
>> else is assumed to be a "RTL8723B" which was originally supported by the
>> driver (communicating via USB).
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>> drivers/bluetooth/btrtl.c | 32 ++++++++++++++++++++++++++++++--
>> 1 file changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
>> index 45b872f5ad22..d896f9421250 100644
>> --- a/drivers/bluetooth/btrtl.c
>> +++ b/drivers/bluetooth/btrtl.c
>> @@ -418,9 +418,33 @@ struct btrtl_device_info *btrtl_initialize(struct h=
ci_dev *hdev)
>>               has_rom_version =3D false;
>>               break;
>>       case RTL_ROM_LMP_8723B:
>> -             fw_name =3D "rtl_bt/rtl8723b_fw.bin";
>> -             cfg_name =3D "rtl_bt/rtl8723b_config.bin";
>> +             /* all variants support reading the ROM version */
>>               has_rom_version =3D true;
>> +
>> +             /*
>> +              * RTL8723 devices exist in different variants:
>> +              * - RTL8723BS (SDIO chip with UART Bluetooth)
>> +              * - RTL8723DS (SDIO chip with UART Bluetooth)
>> +              * - for backwards-compatibility everything else is assume=
d to
>> +              *   be an RTL8723B communicating over USB
>> +              *
>> +              * Only UART devices really need the config because that
>> +              * contains the UART speed / flow control settings.
>> +              */
>> +             if (hdev->bus =3D=3D HCI_UART && resp->hci_ver =3D=3D 6 &&
>> +                 le16_to_cpu(resp->hci_rev) =3D=3D 0xb) {
>> +                     fw_name =3D "rtl_bt/rtl8723bs_fw.bin";
>> +                     cfg_name =3D "rtl_bt/rtl8723bs_config.bin";
>> +                     cfg_needed =3D true;
>> +             } else if (hdev->bus =3D=3D HCI_UART && resp->hci_ver =3D=
=3D 8 &&
>> +                        le16_to_cpu(resp->hci_rev) =3D=3D 0xd) {
>> +                     fw_name =3D "rtl_bt/rtl8723ds_fw.bin";
>> +                     cfg_name =3D "rtl_bt/rtl872ds_config.bin";
>> +                     cfg_needed =3D true;
>> +             } else {
>> +                     fw_name =3D "rtl_bt/rtl8723b_fw.bin";
>> +                     cfg_name =3D "rtl_bt/rtl8723b_config.bin";
>> +             }
>
> so the main question is why is this a config file in the first place? So =
far all other drivers have expressed UART settings via DT (or even via ACPI=
). If we are just getting the baudrates, then better have this in DT. Since=
 otherwise we end up with board specific filesystems again where different =
config files need to be installed. That is really not useful in the end.
this is an excellent question (and also the reason why it's an "RFC" patch)=
!
I'll try to figure out whether:
a) we can skip the config file completely
b) we can generate the config file in-memory
c) we have to stick with this config file

> What is actually in these config files? Can we have some parsing and frie=
ndly display tool in bluez.git like we have for other manufactures.
to my knowledge this config file contains:
- the baudrate
- whether flow control is enabled or disabled
- (in some cases) the local-bd-address

do you mean a tool that is similar to bluez.git tools/nokfw.c?


Regards
Martin


[0] https://github.com/NextThingCo/rtl8723ds_bt/blob/f56ef37217665070e57425=
3d23a595ee1ca5ca23/rtk_hciattach/hciattach_rtk.c#L1781
