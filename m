Return-Path: <pbrobinson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <FCD47ED6-F01F-4921-97A3-BBC1D0263747@holtmann.org>
References: <1502102366-2760-1-git-send-email-loic.poulain@gmail.com>
 <1502102366-2760-2-git-send-email-loic.poulain@gmail.com> <CAL_JsqKxA2pgtjmG-cxy5XPWuRWUiia-weRZDSh4++Vn=QZmqA@mail.gmail.com>
 <8186E2A3-D0AC-498F-8229-78862D363F78@holtmann.org> <392e6d51-33d6-1585-6582-1397a0c64852@gmail.com>
 <161632C7-EBBF-47F5-86DC-453E10395B54@holtmann.org> <e001e055-10a5-facd-a8e1-57c1bdb78172@gmail.com>
 <FCD47ED6-F01F-4921-97A3-BBC1D0263747@holtmann.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 16 Aug 2017 13:37:17 +0100
Message-ID: <CALeDE9MeMHtCD8esCcznHjS+z6o7Ezh9dP1OZq=77DuYNS2=2A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ARM: dts: bcm2837-rpi-3-b: Add bcm43438 as serial slave
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Loic Poulain <loic.poulain@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
	linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

>> I built kernel, modules and dtb from a bluetooth-next tree (4.12 and 4.1=
3-rc3).
>> Using 32-bit multi_v7_defconfig + some additional confs to enable miniua=
rt (BCM2835AUX...) for console.
>> I push this on a raspbian image.
>>
>> my boot/config.txt is very simple (no overlay):
>>
>> kernel=3DzImage
>> device_tree=3Dbcm2837-rpi-3-b.dtb
>> # hack for miniuart serial clock
>> core_freq=3D250
>> dtparam=3Daudio=3Don
>
> so the Fedora 26 kernel that is based on 4.12 is missing uart0 configurat=
ion in DT. Adding it to bcm2837-rpi-3-b.dts will allow for btattach to actu=
ally work.

I'm the Fedora maintainer for the Raspberry Pi (and a lot of ARM on
Fedora in general).

> &uart0 {
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&uart0_gpio32 &gpclk2_gpio43>;
>         status =3D "okay=E2=80=9D;
> };
>
> It kinda works, but not all of it. This command confuses me.

With the upstream kernel, some DT bits headed upstream (ie the Fedora
kernel) plus these patches I get to the "kinda works" too in that it
sees a BT adapter but doesn't give it a mac address.

> < HCI Command: Broadcom Write UART Clock Setting (0x3f|0x0045) plen 1
>         01                                               .
>> HCI Event: Command Complete (0x0e) plen 4
>       Broadcom Write UART Clock Setting (0x3f|0x0045) ncmd 1
>         Status: Unknown HCI Command (0x01)
>
> And I am seeing fun stuff like failed frame assembly.
>
> [  888.687594] Bluetooth: hci0: BCM: chip id 94
> [  888.687821] Bluetooth: hci0: BCM43430A1 (001.002.009) build 0182
> [  892.059023] Bluetooth: hci0: Frame reassembly failed (-84)
> [  892.316936] Bluetooth: hci0: BCM: failed to write clock (-56)
> [  892.429478] Bluetooth: hci0: BCM (001.002.009) build 0182
>
> Actually not providing the firmware makes the controller work. It however=
 is stuck ad AA:AA:.. default address. Providing the firmware turns the add=
ress active. However then it never completes.

I've tried on and off to get the BT working, there seems to lots of
options and bits needed including some patches to the bluez [1] stuff
but between not quite upstream kernel bits and numerous distros all
doing it slightly differently I've never got it to work well.

The yocto [1] bits seem fairly representative of some the patches
flying around "to get it working" although I'm not sure how many of
these are actually required and how many are superfluous with this
patch set. There seems to be a firmware required that's not
distributed with linux-firmware which would also be nice to resolve.

Peter

[1] https://git.yoctoproject.org/cgit/cgit.cgi/meta-raspberrypi/tree/recipe=
s-connectivity/bluez5/bluez5
