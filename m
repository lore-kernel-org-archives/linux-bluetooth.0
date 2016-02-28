Return-Path: <jerome.debretagne@gmail.com>
MIME-Version: 1.0
In-Reply-To: <56CAD20D.4080609@broadcom.com>
References: <CA+kEDGEHfsODon6aOdLU86E9c0Lfs-4bo=ycEZz3MdEa1qLrKw@mail.gmail.com>
	<56CAD20D.4080609@broadcom.com>
Date: Sun, 28 Feb 2016 18:56:49 +0100
Message-ID: <CA+kEDGGqZXxvAUo=7J2e5moWRxVPSCgsu3UX4cDwDD-nPDEbAA@mail.gmail.com>
Subject: Re: Broadcom BCM4324(1) rev B5 chipset - Bluetooth support in Linux
 Kernel 4.x ?
From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>
To: arend@broadcom.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Ilya Faenson <ilya.faenson@broadcom.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a11422688abdd7a052cd841f1
List-ID: <linux-bluetooth.vger.kernel.org>

--001a11422688abdd7a052cd841f1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I've been able to continue my investigation and I can confirm that I am
getting the same results on both Linux kernel:
- 4.4 - linux-image-4.4.0-1-amd64 from Debian (v4.4.2-3)
- 4.5 rc4 - linux-image-4.5.0-rc4-amd64 from Debian (4.5~rc4-1~exp1)
and in both cases no error message whatsoever related to Bluetooth.

It seems this BCM4324(1) rev B5 chipset is not initialized from a Bluetooth
point of view, while working great for Wi-Fi.

I've seen recent patches adding support for some devices simply by adding
their respective ACPI ID in hci_bcm.c (BCM2E7C for MacBook 2015, BCM2E65
for the Asus T100TAF, BCM2E54 for the HP Omni 10) so I've just taken a look
at the data listed by the ACPI subsystem on this tablet:

   $ ls /sys/bus/acpi/devices/BCM* -d1
   /sys/bus/acpi/devices/BCM2E3C:00
   /sys/bus/acpi/devices/BCM2E55:00

Neither of these 2 IDs (BCM2E3C, BCM2E55) is listed in hci_bcm.c. It's just
a guess at this stage but could one of these be the missing element
required in hci_bcm.c to initialize Bluetooth on the Lenovo ThinkPad 8
Tablet maybe? I don't know if the following commands might give a hint to
filter between the two IDs:

   $ cat /sys/bus/acpi/devices/BCM2E3C\:00/status
   0
   $ cat /sys/bus/acpi/devices/BCM2E55\:00/status
   15

If I can provide more information that would be useful for you, feel free
to ask as I would be glad to help.

J=C3=A9r=C3=B4me

P.S. I don't know if I should provide a binary firmware somehow to trigger
its initialization (as I've done for the Wi-Fi part) but I would expect to
see an error message complaining not to find the required binary file if
that was the case.


2016-02-22 10:17 GMT+01:00 Arend Van Spriel <arend.vanspriel@broadcom.com>:

> + Ilya
> + bt list
>
> On 21-2-2016 15:17, J=C3=A9r=C3=B4me de Bretagne wrote:
> > Hi,https://mail.google.com/mail/u/0/#inbox/1530430f49b01795
> >
> > Since a commit from last April, the BCM4324(1) rev B5 chipset is
> > supported in the Linux kernel and WiFi networking has been working
> > like a charm on a Lenovo ThinkPad 8 tablet (running Linux
> > 4.3.0-1-amd64 from Debian). A big "Thanks" for that.
> >
> > On the other hand, the Bluetooth part doesn't show up at all (empty
> > result with hciconfig) and doesn't seem active with that same 4.3
> > kernel. I don't even see any error message in dmesg about Bluetooth.
> >
> > bluetooth/btbcm.c mentions quite a few chipsets (UART/USB) but not the
> > 4324 rev B5 so I'm not sure of the current Bluetooth status for that
> > specific one. Is this chipset enabled for Bluetooth starting with
> > Linux 4.4 or in the coming 4.5 version maybe? I couldn't check 4.4
> > properly yet as this kernel version locks currently on my tablet (for
> > other reasons).
> >
> > If it is not fully supported yet, feel free to ask any info that could
> > help enable Bluetooth for this chipset on the ThinkPad 8 tablet!
> >
> > Thanks,
> >
> > J=C3=A9r=C3=B4me
> >
> >
> > P.S. I guess the following page
> > https://wireless.wiki.kernel.org/en/users/Drivers/brcm80211 could be
> > updated to show that Wireless LAN is properly working.
>
>

--001a11422688abdd7a052cd841f1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br></div>I&#39;ve been able to continue =
my investigation and I can confirm that I am getting the same results on bo=
th Linux kernel:<br>- 4.4 - linux-image-4.4.0-1-amd64 from Debian (v4.4.2-3=
)<br></div>- 4.5 rc4 - linux-image-4.5.0-rc4-amd64 from Debian (4.5~rc4-1~e=
xp1)<br><div><div><div><div class=3D"gmail_extra">and in both cases no erro=
r message whatsoever related to Bluetooth.<br><br>It seems this BCM4324(1) =
rev B5 chipset is not initialized from a Bluetooth point of view, while wor=
king great for Wi-Fi.<br><br>I&#39;ve seen recent patches adding support fo=
r some devices simply by adding their respective ACPI ID in hci_bcm.c (BCM2=
E7C for MacBook 2015, BCM2E65 for the Asus T100TAF, BCM2E54 for the HP Omni=
 10) so I&#39;ve just taken a look at the data listed by the ACPI subsystem=
 on this tablet:<br><br>=C2=A0=C2=A0 $ ls /sys/bus/acpi/devices/BCM* -d1<br=
>=C2=A0=C2=A0 /sys/bus/acpi/devices/BCM2E3C:00<br>=C2=A0=C2=A0 /sys/bus/acp=
i/devices/BCM2E55:00<br><br></div><div class=3D"gmail_extra">Neither of the=
se 2 IDs (BCM2E3C, BCM2E55)  is listed in hci_bcm.c. It&#39;s just a guess =
at this stage but could one of these be the missing element required in hci=
_bcm.c to initialize Bluetooth on the Lenovo ThinkPad 8 Tablet maybe? I don=
&#39;t know if the following commands might give a hint to filter between t=
he two IDs:<br></div><div class=3D"gmail_extra"><br>=C2=A0=C2=A0 $ cat /sys=
/bus/acpi/devices/BCM2E3C\:00/status<br>=C2=A0=C2=A0 0<br>=C2=A0=C2=A0 $ ca=
t /sys/bus/acpi/devices/BCM2E55\:00/status<br>=C2=A0=C2=A0 15<br><br></div>=
<div class=3D"gmail_extra">If I can provide more information that would be =
useful for you, feel free to ask as I would be glad to help.<br></div><div =
class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">J=C3=A9r=C3=B4me=
<br></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">P=
.S. I don&#39;t know if I should provide a binary=20
firmware somehow to trigger its initialization (as I&#39;ve done for the=20
Wi-Fi part) but I would expect to see an error message complaining not=20
to find the required binary file if that was the case.<br><br></div><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote">2016-02-22 10:17 GMT+01:=
00 Arend Van Spriel <span dir=3D"ltr">&lt;<a href=3D"mailto:arend.vanspriel=
@broadcom.com" target=3D"_blank">arend.vanspriel@broadcom.com</a>&gt;</span=
>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">+ Ilya<br>
+ bt list<br>
<div><div><br>
On 21-2-2016 15:17, J=C3=A9r=C3=B4me de Bretagne wrote:<br>
&gt; Hi,<a href=3D"https://mail.google.com/mail/u/0/#inbox/1530430f49b01795=
">https://mail.google.com/mail/u/0/#inbox/1530430f49b01795</a><br>
&gt;<br>
&gt; Since a commit from last April, the BCM4324(1) rev B5 chipset is<br>
&gt; supported in the Linux kernel and WiFi networking has been working<br>
&gt; like a charm on a Lenovo ThinkPad 8 tablet (running Linux<br>
&gt; 4.3.0-1-amd64 from Debian). A big &quot;Thanks&quot; for that.<br>
&gt;<br>
&gt; On the other hand, the Bluetooth part doesn&#39;t show up at all (empt=
y<br>
&gt; result with hciconfig) and doesn&#39;t seem active with that same 4.3<=
br>
&gt; kernel. I don&#39;t even see any error message in dmesg about Bluetoot=
h.<br>
&gt;<br>
&gt; bluetooth/btbcm.c mentions quite a few chipsets (UART/USB) but not the=
<br>
&gt; 4324 rev B5 so I&#39;m not sure of the current Bluetooth status for th=
at<br>
&gt; specific one. Is this chipset enabled for Bluetooth starting with<br>
&gt; Linux 4.4 or in the coming 4.5 version maybe? I couldn&#39;t check 4.4=
<br>
&gt; properly yet as this kernel version locks currently on my tablet (for<=
br>
&gt; other reasons).<br>
&gt;<br>
&gt; If it is not fully supported yet, feel free to ask any info that could=
<br>
&gt; help enable Bluetooth for this chipset on the ThinkPad 8 tablet!<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; J=C3=A9r=C3=B4me<br>
&gt;<br>
&gt;<br>
&gt; P.S. I guess the following page<br>
&gt; <a href=3D"https://wireless.wiki.kernel.org/en/users/Drivers/brcm80211=
" rel=3D"noreferrer" target=3D"_blank">https://wireless.wiki.kernel.org/en/=
users/Drivers/brcm80211</a> could be<br>
&gt; updated to show that Wireless LAN is properly working.<br>
<br>
</div></div></blockquote></div><br></div></div></div></div></div>

--001a11422688abdd7a052cd841f1--
