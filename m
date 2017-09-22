Return-Path: <loic.poulain@gmail.com>
MIME-Version: 1.0
In-Reply-To: <9C9C1616-C9CA-4542-AC9C-0DBC3107BA61@holtmann.org>
References: <BAA83E9E-B9BF-48AD-9955-20B599AFA52C@holtmann.org>
 <CALeDE9PaZvfEwSBOuELNbJxBjR3DfWj61rEBMhYTAF6DJd+bcA@mail.gmail.com>
 <00A3687E-050A-469F-98B0-C42F872EFE1C@holtmann.org> <CALeDE9Mn9KdvJ7kFK9=86FswmckabFLWryDHkmujsDh9Xow1iQ@mail.gmail.com>
 <115EE599-9710-437B-9AA8-C4CD8360EF3F@holtmann.org> <CALeDE9NW+4xkGCD5kKsN-41ctPJ6PNp63jQ61Q7dUQMALG3Ojg@mail.gmail.com>
 <C09F8308-A607-46BC-B084-2E949947E439@holtmann.org> <CALeDE9NgfjdNRn3zCEyP_vCgJVFy9Eaf8QE90-Zc-Q=yJJUQYA@mail.gmail.com>
 <9C9C1616-C9CA-4542-AC9C-0DBC3107BA61@holtmann.org>
From: Loic Poulain <loic.poulain@gmail.com>
Date: Fri, 22 Sep 2017 11:09:28 +0200
Message-ID: <CAM9fo8O+y85eKZ=YbHFfc1iGtH4KN-fpoA1AoEU7z2uYiNUg+A@mail.gmail.com>
Subject: Re: Fedora 27 kernel and RPi3 Bluetooth oops
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary="001a113cf01a52976c0559c3932c"
List-ID: <linux-bluetooth.vger.kernel.org>

--001a113cf01a52976c0559c3932c
Content-Type: text/plain; charset="UTF-8"

Hi Marcel, Peter,

> Hans added a script to automatically btattch some bcm controllers for
> > atom devices, maybe we need to add more IDs for udev, not sure if
> > there's a means of making that generic and upstreamable. Also some of
> > the other distro patches I've seen had a different BT firmware, not
> > sure if Loic needed that or not.
>
> The whole point behind serdev is that you no longer need btattach. The
> UART can be enumerated by the kernel. So that should not be needed and we
> also want to get rid of it for ACPI based systems as well.
>
>
Since it works with raspbian I had a try with Fedora 26.

To make this 'simpler', I bypassed u-boot and just loaded my kernel + my
dtb:

- added bcm2837-rpi-3-b.dtb and kernel zImage (Linux 4.13 32-bit) (FAT PART)

- modified config.txt (FAT part):
# Raspberry Pi 3
[pi3]
kernel=zImage
device_tree=bcm2837-rpi-3-b.dtb

- added cmdline.txt (FAT part):
dwc_otg.lpm_enable=0 root=/dev/mmcblk0p4 rootfstype=ext4 elevator=deadline
fsck.repair=yes rootwait splash plymouth.ignore-serial-consoles

- added modules (rootfs ext4 part)

That works as expected, my hci device is correctly configured and
operational.
Maybe u-boot adds some unexpected overlay or applies incorrect config.

Regards
Loic

--001a113cf01a52976c0559c3932c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div class=3D"gmail_extra">Hi Marcel, Peter,<br><span=
 class=3D"gmail-"></span><br><span class=3D"gmail-"></span><div class=3D"gm=
ail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D=
"gmail-">
&gt; Hans added a script to automatically btattch some bcm controllers for<=
br>
&gt; atom devices, maybe we need to add more IDs for udev, not sure if<br>
&gt; there&#39;s a means of making that generic and upstreamable. Also some=
 of<br>
&gt; the other distro patches I&#39;ve seen had a different BT firmware, no=
t<br>
&gt; sure if Loic needed that or not.<br>
<br>
</span>The whole point behind serdev is that you no longer need btattach. T=
he UART can be enumerated by the kernel. So that should not be needed and w=
e also want to get rid of it for ACPI based systems as well.<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br></font></span></bl=
ockquote><div><br><div>Since it works with raspbian I had a try with Fedora=
 26.<br><br></div><div>To make this &#39;simpler&#39;, I bypassed u-boot an=
d just loaded my kernel + my dtb:<br><br>- added bcm2837-rpi-3-b.dtb and ke=
rnel zImage (Linux 4.13 32-bit) (FAT PART)<br><br></div><div>- modified con=
fig.txt (FAT part):<br># Raspberry Pi 3<br>[pi3]<br>kernel=3DzImage<br>devi=
ce_tree=3Dbcm2837-rpi-3-b.dtb<br><br></div><div>- added cmdline.txt (FAT pa=
rt):<br>dwc_otg.lpm_enable=3D0
 root=3D/dev/mmcblk0p4 rootfstype=3Dext4 elevator=3Ddeadline fsck.repair=3D=
yes=20
rootwait splash plymouth.ignore-serial-consoles<br><br></div><div>- added m=
odules (rootfs ext4 part)<br></div><div><br></div><div>That works as expect=
ed, my hci device is correctly configured and operational.<br></div><div>Ma=
ybe u-boot adds some unexpected overlay or applies incorrect config.<br></d=
iv>=C2=A0</div></div>Regards<br></div><div class=3D"gmail_extra">Loic<br></=
div></div></div>

--001a113cf01a52976c0559c3932c--
