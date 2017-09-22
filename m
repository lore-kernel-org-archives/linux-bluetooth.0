Return-Path: <pbrobinson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAM9fo8O+y85eKZ=YbHFfc1iGtH4KN-fpoA1AoEU7z2uYiNUg+A@mail.gmail.com>
References: <BAA83E9E-B9BF-48AD-9955-20B599AFA52C@holtmann.org>
 <CALeDE9PaZvfEwSBOuELNbJxBjR3DfWj61rEBMhYTAF6DJd+bcA@mail.gmail.com>
 <00A3687E-050A-469F-98B0-C42F872EFE1C@holtmann.org> <CALeDE9Mn9KdvJ7kFK9=86FswmckabFLWryDHkmujsDh9Xow1iQ@mail.gmail.com>
 <115EE599-9710-437B-9AA8-C4CD8360EF3F@holtmann.org> <CALeDE9NW+4xkGCD5kKsN-41ctPJ6PNp63jQ61Q7dUQMALG3Ojg@mail.gmail.com>
 <C09F8308-A607-46BC-B084-2E949947E439@holtmann.org> <CALeDE9NgfjdNRn3zCEyP_vCgJVFy9Eaf8QE90-Zc-Q=yJJUQYA@mail.gmail.com>
 <9C9C1616-C9CA-4542-AC9C-0DBC3107BA61@holtmann.org> <CAM9fo8O+y85eKZ=YbHFfc1iGtH4KN-fpoA1AoEU7z2uYiNUg+A@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 22 Sep 2017 12:32:52 +0100
Message-ID: <CALeDE9MtZDi=TkmvrF_WrqHALCEnM4+UK1RAdLT=0io-6yRvaw@mail.gmail.com>
Subject: Re: Fedora 27 kernel and RPi3 Bluetooth oops
To: Loic Poulain <loic.poulain@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Sep 22, 2017 at 10:09 AM, Loic Poulain <loic.poulain@gmail.com> wrote:
> Hi Marcel, Peter,
>
>> > Hans added a script to automatically btattch some bcm controllers for
>> > atom devices, maybe we need to add more IDs for udev, not sure if
>> > there's a means of making that generic and upstreamable. Also some of
>> > the other distro patches I've seen had a different BT firmware, not
>> > sure if Loic needed that or not.
>>
>> The whole point behind serdev is that you no longer need btattach. The
>> UART can be enumerated by the kernel. So that should not be needed and we
>> also want to get rid of it for ACPI based systems as well.
>>
>
> Since it works with raspbian I had a try with Fedora 26.
>
> To make this 'simpler', I bypassed u-boot and just loaded my kernel + my
> dtb:
>
> - added bcm2837-rpi-3-b.dtb and kernel zImage (Linux 4.13 32-bit) (FAT PART)

Where did the kernel come from? Is that the Fedora kernel?

> - modified config.txt (FAT part):
> # Raspberry Pi 3
> [pi3]
> kernel=zImage
> device_tree=bcm2837-rpi-3-b.dtb
>
> - added cmdline.txt (FAT part):
> dwc_otg.lpm_enable=0 root=/dev/mmcblk0p4 rootfstype=ext4 elevator=deadline
> fsck.repair=yes rootwait splash plymouth.ignore-serial-consoles
>
> - added modules (rootfs ext4 part)
>
> That works as expected, my hci device is correctly configured and
> operational.
> Maybe u-boot adds some unexpected overlay or applies incorrect config.

It certainly doesn't add overlays by default, it uses the vanilla
linux kernel DT
