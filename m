Content-Type: multipart/alternative;
	boundary="Apple-Mail=_9E34E40F-3528-4D44-B9F3-5486B017C972"
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2] Bluetooth: btusb: Add Realtek 8723/8761 support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <54F70642BAB21D4498E1AA3EFE3D519A45FBED07@rsex2.realsil.com.cn>
Date: Thu, 3 Jul 2014 20:12:27 +0200
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Daniel Drake <drake@endlessm.com>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>
Message-Id: <B6A2794A-32D2-4D66-9D61-A27D7DA247B1@holtmann.org>
References: <1404218878-14218-1-git-send-email-drake@endlessm.com> <16AC594D-6B3C-4CB6-B951-0763F3E4E27A@holtmann.org> <CAD8Lp45HbA03MycDVu6akTfEET_ZzxrwGpH1TbiQrw5Z178aeA@mail.gmail.com> <53B2D160.4010306@lwfinger.net> <F9E90F3A-5FE4-407C-833A-5E852A260984@holtmann.org> <54F70642BAB21D4498E1AA3EFE3D519A45FBED07@rsex2.realsil.com.cn>
To: =?utf-8?B?6ZmI6Imz6JCN?= <champion_chen@realsil.com.cn>
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_9E34E40F-3528-4D44-B9F3-5486B017C972
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=GB2312

Hi Champion,

> 1.  RTL vs RTK , it is ok to use "rtl " to comply with wifi drivers

lets be consistent and keep using rtl.
=20
> 2. firmware table, when module is powered on the default LMP versions =
are different. After download firmware ,the LMP version will change to =
firmware version.
> <image003.jpg>=20
> module
> LMP Subversion
> HCI Revision
> RTL8723A
> 0X1200
> 0X000B
> RTL8723B
> 0X8723
> 0X000B
> RTL8761A
> 0X8761
> 0X000A
> RTL8821A
> 0X8821
> 0X000A
> =20
> 8723A/8723B/8821A are combo modules both with wifi and Bluetooth;
> 8761A is Bluetooth only chip, but can be used to with wifi 8812/8192, =
and will use different bluetooth firmware for each combination.
> This can only be distinguished by pids.
> I think it is OK to only support 8723A &8723B and leave others for =
next time driver update.

Can you share the Realtek HCI Vendor Command specification with me =
privately. The command above is Bluetooth standard, but we are also =
having at least the baud rate change for UART based controllers and the =
ROM version command. We most likely also need a vendor command to set =
the BD_ADDR in case it is not configured or an OEM wants to change it.

I also like to know what is the right procedure for loading the ROM =
patches and/or settings. Getting this nicely documented would be of =
great benefit. We have the Intel and Broadcom procedures nicely =
documented inside the code.
=20
> 2.     I read the codes in kernel 3.13 , some companies such as Intel =
add setup function for their modules in general btusb driver ;  while =
some provide another driver and set BTUSB_IGNORE in btusb_probe, how can =
it work for their private driver only download firmware and do not call =
any functions of bluez hci layer ?

There are two ways current silicon vendors have done. Either have a =
special USB VID/PID or descriptors, attach the firmware loading driver =
and load the firmware. The device disconnects from USB and re-connects =
with its new identity. And then btusb driver takes over.

The second method is doing the setup stage all in the driver. So the =
Bluetooth core is actually providing a running transport that is driven =
by the transport driver (in this case btusb), but before it takes =
control it allows the driver to issue certain HCI commands. This is =
mostly used for firmware loading. You can see that for Intel and =
Broadcom.

If your firmware loading, setup, patching or whatever is done with HCI =
commands, you should go the setup callback broke since that way you do =
not have to deal with transport details. It will just work. If you speak =
a non-HCI protocol, then the method with a separate firmware loading =
driver is beneficial.

For Realtek it seems the setup stage like what we do with Intel and =
Broadcom silicon is exactly what you want.

Can you provide a list of USB/PID that match to modules which require =
the firmware loading or optionally support the firmware loading. That =
would make it easier to populate the matching table. The decision on the =
module can be easily done by reading the HCI Local Version Information =
first.

Regards

Marcel


--Apple-Mail=_9E34E40F-3528-4D44-B9F3-5486B017C972
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=GB2312

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3DGB2312"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><div>Hi Champion,</div><div><br><blockquote =
type=3D"cite"><div lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;"><div class=3D"WordSection1" =
style=3D"page: WordSection1;"><div style=3D"margin: 0cm 0cm 0.0001pt; =
font-size: 10.5pt; font-family: Calibri, sans-serif;"><span =
lang=3D"EN-US">1. &nbsp;RTL vs RTK , it is ok to use "rtl " to comply =
with wifi =
drivers</span></div></div></div></blockquote><div><br></div>lets be =
consistent and keep using rtl.</div><div><span style=3D"font-family: =
Calibri, sans-serif; font-size: 10.5pt;">&nbsp;</span><br><blockquote =
type=3D"cite"><div lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;"><div class=3D"WordSection1" =
style=3D"page: WordSection1;"><div style=3D"margin: 0cm 0cm 0.0001pt; =
font-size: 10.5pt; font-family: Calibri, sans-serif;"><span =
lang=3D"EN-US">2.</span><span lang=3D"EN-US"><span =
class=3D"Apple-converted-space">&nbsp;</span>firmware table, when module =
is powered on the default LMP versions are different. After download =
firmware ,the LMP version will change to firmware =
version.<o:p></o:p></span></div><div style=3D"margin: 0cm 0cm 0.0001pt; =
font-size: 10.5pt; font-family: Calibri, sans-serif;"><span =
lang=3D"EN-US"><span>&lt;image003.jpg&gt;</span>&nbsp;<o:p></o:p></span></=
div><table class=3D"MsoNormalTable" border=3D"1" cellspacing=3D"0" =
cellpadding=3D"0" style=3D"border-collapse: collapse; border: none; =
position: static; z-index: auto;"><tbody><tr><td width=3D"178" =
valign=3D"top" style=3D"width: 106.5pt; border: 1pt solid black; =
background-color: rgb(204, 255, 255); padding: 0cm 5.4pt; =
background-position: initial initial; background-repeat: initial =
initial;"><div style=3D"margin: 0cm 0cm 0.0001pt; text-align: left; =
font-size: 10.5pt; font-family: Calibri, sans-serif;"><b><span =
lang=3D"EN-US">module<o:p></o:p></span></b></div></td><td width=3D"151" =
valign=3D"top" style=3D"width: 90.3pt; border-style: solid solid solid =
none; border-top-color: black; border-right-color: black; =
border-bottom-color: black; border-top-width: 1pt; border-right-width: =
1pt; border-bottom-width: 1pt; background-color: rgb(204, 255, 255); =
padding: 0cm 5.4pt; background-position: initial initial; =
background-repeat: initial initial;"><div style=3D"margin: 0cm 0cm =
0.0001pt; text-align: left; font-size: 10.5pt; font-family: Calibri, =
sans-serif;"><b><span lang=3D"EN-US">LMP =
Subversion<o:p></o:p></span></b></div></td><td width=3D"205" =
valign=3D"top" style=3D"width: 122.75pt; border-style: solid solid solid =
none; border-top-color: black; border-right-color: black; =
border-bottom-color: black; border-top-width: 1pt; border-right-width: =
1pt; border-bottom-width: 1pt; background-color: rgb(204, 255, 255); =
padding: 0cm 5.4pt; background-position: initial initial; =
background-repeat: initial initial;"><div style=3D"margin: 0cm 0cm =
0.0001pt; text-align: left; font-size: 10.5pt; font-family: Calibri, =
sans-serif;"><b><span lang=3D"EN-US">HCI =
Revision<o:p></o:p></span></b></div></td></tr><tr><td width=3D"178" =
valign=3D"top" style=3D"width: 106.5pt; border-style: none solid solid; =
border-right-color: black; border-bottom-color: black; =
border-left-color: black; border-right-width: 1pt; border-bottom-width: =
1pt; border-left-width: 1pt; padding: 0cm 5.4pt;"><div style=3D"margin: =
0cm 0cm 0.0001pt; text-align: left; font-size: 10.5pt; font-family: =
Calibri, sans-serif;"><span =
lang=3D"EN-US">RTL8723A<o:p></o:p></span></div></td><td width=3D"151" =
valign=3D"top" style=3D"width: 90.3pt; border-style: none solid solid =
none; border-bottom-color: black; border-bottom-width: 1pt; =
border-right-color: black; border-right-width: 1pt; padding: 0cm =
5.4pt;"><div style=3D"margin: 0cm 0cm 0.0001pt; text-align: left; =
font-size: 10.5pt; font-family: Calibri, sans-serif;"><span =
lang=3D"EN-US">0X1200<o:p></o:p></span></div></td><td width=3D"205" =
valign=3D"top" style=3D"width: 122.75pt; border-style: none solid solid =
none; border-bottom-color: black; border-bottom-width: 1pt; =
border-right-color: black; border-right-width: 1pt; padding: 0cm =
5.4pt;"><div style=3D"margin: 0cm 0cm 0.0001pt; text-align: left; =
font-size: 10.5pt; font-family: Calibri, sans-serif;"><span =
lang=3D"EN-US">0X000B<o:p></o:p></span></div></td></tr><tr><td =
width=3D"178" valign=3D"top" style=3D"width: 106.5pt; border-style: none =
solid solid; border-right-color: black; border-bottom-color: black; =
border-left-color: black; border-right-width: 1pt; border-bottom-width: =
1pt; border-left-width: 1pt; padding: 0cm 5.4pt;"><div style=3D"margin: =
0cm 0cm 0.0001pt; text-align: left; font-size: 10.5pt; font-family: =
Calibri, sans-serif;"><span =
lang=3D"EN-US">RTL8723B<o:p></o:p></span></div></td><td width=3D"151" =
valign=3D"top" style=3D"width: 90.3pt; border-style: none solid solid =
none; border-bottom-color: black; border-bottom-width: 1pt; =
border-right-color: black; border-right-width: 1pt; padding: 0cm =
5.4pt;"><div style=3D"margin: 0cm 0cm 0.0001pt; text-align: left; =
font-size: 10.5pt; font-family: Calibri, sans-serif;"><span =
lang=3D"EN-US">0X8723<o:p></o:p></span></div></td><td width=3D"205" =
valign=3D"top" style=3D"width: 122.75pt; border-style: none solid solid =
none; border-bottom-color: black; border-bottom-width: 1pt; =
border-right-color: black; border-right-width: 1pt; padding: 0cm =
5.4pt;"><div style=3D"margin: 0cm 0cm 0.0001pt; text-align: left; =
font-size: 10.5pt; font-family: Calibri, sans-serif;"><span =
lang=3D"EN-US">0X000B<o:p></o:p></span></div></td></tr><tr><td =
width=3D"178" valign=3D"top" style=3D"width: 106.5pt; border-style: none =
solid solid; border-right-color: black; border-bottom-color: black; =
border-left-color: black; border-right-width: 1pt; border-bottom-width: =
1pt; border-left-width: 1pt; padding: 0cm 5.4pt;"><div style=3D"margin: =
0cm 0cm 0.0001pt; text-align: left; font-size: 10.5pt; font-family: =
Calibri, sans-serif;"><span =
lang=3D"EN-US">RTL8761A<o:p></o:p></span></div></td><td width=3D"151" =
valign=3D"top" style=3D"width: 90.3pt; border-style: none solid solid =
none; border-bottom-color: black; border-bottom-width: 1pt; =
border-right-color: black; border-right-width: 1pt; padding: 0cm =
5.4pt;"><div style=3D"margin: 0cm 0cm 0.0001pt; text-align: left; =
font-size: 10.5pt; font-family: Calibri, sans-serif;"><span =
lang=3D"EN-US">0X8761<o:p></o:p></span></div></td><td width=3D"205" =
valign=3D"top" style=3D"width: 122.75pt; border-style: none solid solid =
none; border-bottom-color: black; border-bottom-width: 1pt; =
border-right-color: black; border-right-width: 1pt; padding: 0cm =
5.4pt;"><div style=3D"margin: 0cm 0cm 0.0001pt; text-align: left; =
font-size: 10.5pt; font-family: Calibri, sans-serif;"><span =
lang=3D"EN-US">0X000A<o:p></o:p></span></div></td></tr><tr><td =
width=3D"178" valign=3D"top" style=3D"width: 106.5pt; border-style: none =
solid solid; border-right-color: black; border-bottom-color: black; =
border-left-color: black; border-right-width: 1pt; border-bottom-width: =
1pt; border-left-width: 1pt; padding: 0cm 5.4pt;"><div style=3D"margin: =
0cm 0cm 0.0001pt; text-align: left; font-size: 10.5pt; font-family: =
Calibri, sans-serif;"><span =
lang=3D"EN-US">RTL8821A<o:p></o:p></span></div></td><td width=3D"151" =
valign=3D"top" style=3D"width: 90.3pt; border-style: none solid solid =
none; border-bottom-color: black; border-bottom-width: 1pt; =
border-right-color: black; border-right-width: 1pt; padding: 0cm =
5.4pt;"><div style=3D"margin: 0cm 0cm 0.0001pt; text-align: left; =
font-size: 10.5pt; font-family: Calibri, sans-serif;"><span =
lang=3D"EN-US">0X8821<o:p></o:p></span></div></td><td width=3D"205" =
valign=3D"top" style=3D"width: 122.75pt; border-style: none solid solid =
none; border-bottom-color: black; border-bottom-width: 1pt; =
border-right-color: black; border-right-width: 1pt; padding: 0cm =
5.4pt;"><div style=3D"margin: 0cm 0cm 0.0001pt; text-align: left; =
font-size: 10.5pt; font-family: Calibri, sans-serif;"><span =
lang=3D"EN-US">0X000A<o:p></o:p></span></div></td></tr></tbody></table><di=
v style=3D"margin: 0cm 0cm 0.0001pt; text-align: left; font-size: =
10.5pt; font-family: Calibri, sans-serif;"><span lang=3D"EN-US" =
style=3D"font-size: 10pt;">&nbsp;</span></div><div style=3D"margin: 0cm =
0cm 0.0001pt; text-align: left; font-size: 10.5pt; font-family: Calibri, =
sans-serif;"><span lang=3D"EN-US" style=3D"font-size: =
10pt;">8723A/8723B/8821A are combo modules both with wifi and =
Bluetooth;<o:p></o:p></span></div><div style=3D"margin: 0cm 0cm =
0.0001pt; text-align: left; font-size: 10.5pt; font-family: Calibri, =
sans-serif;"><span lang=3D"EN-US" style=3D"font-size: 10pt;">8761A is =
Bluetooth only chip, but can be used to with wifi 8812/8192, and will =
use different bluetooth firmware for each =
combination.<o:p></o:p></span></div><div style=3D"margin: 0cm 0cm =
0.0001pt; text-align: left; font-size: 10.5pt; font-family: Calibri, =
sans-serif;"><span lang=3D"EN-US" style=3D"font-size: 10pt;">This can =
only be distinguished by pids.<o:p></o:p></span></div><div =
style=3D"margin: 0cm 0cm 0.0001pt; text-align: left; font-size: 10.5pt; =
font-family: Calibri, sans-serif;"><span lang=3D"EN-US" =
style=3D"font-size: 10pt;">I think it is OK to only support 8723A =
&amp;8723B and leave others for next time driver =
update.</span></div></div></div></blockquote><div><br></div>Can you =
share the Realtek HCI Vendor Command specification with me privately. =
The command above is Bluetooth standard, but we are also having at least =
the baud rate change for UART based controllers and the ROM version =
command. We most likely also need a vendor command to set the BD_ADDR in =
case it is not configured or an OEM wants to change it.</div><div><span =
style=3D"font-family: Calibri, sans-serif; font-size: =
10pt;"><br></span></div><div>I also like to know what is the right =
procedure for loading the ROM patches and/or settings. Getting this =
nicely documented would be of great benefit. We have the Intel and =
Broadcom procedures nicely documented inside the code.</div><div><span =
style=3D"font-family: Calibri, sans-serif; font-size: =
10pt;">&nbsp;</span></div><div><blockquote type=3D"cite"><div =
lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;"><div class=3D"WordSection1" =
style=3D"page: WordSection1;"><div style=3D"margin: 0cm 0cm 0.0001pt; =
font-size: 10.5pt; font-family: Calibri, sans-serif;"><span =
lang=3D"EN-US">2.&nbsp;&nbsp;&nbsp;&nbsp; I read the codes in kernel =
3.13 , some companies such as Intel add setup function for their modules =
in general btusb driver ; &nbsp;while some provide another driver and =
set BTUSB_IGNORE in btusb_probe, how can it work for their private =
driver only download firmware and do not call any functions of bluez hci =
layer ?</span></div></div></div></blockquote><div><br></div>There are =
two ways current silicon vendors have done. Either have a special USB =
VID/PID or descriptors, attach the firmware loading driver and load the =
firmware. The device disconnects from USB and re-connects with its new =
identity. And then btusb driver takes over.</div><div><br></div><div>The =
second method is doing the setup stage all in the driver. So the =
Bluetooth core is actually providing a running transport that is driven =
by the transport driver (in this case btusb), but before it takes =
control it allows the driver to issue certain HCI commands. This is =
mostly used for firmware loading. You can see that for Intel and =
Broadcom.</div><div><br></div><div>If your firmware loading, setup, =
patching or whatever is done with HCI commands, you should go the setup =
callback broke since that way you do not have to deal with transport =
details. It will just work. If you speak a non-HCI protocol, then the =
method with a separate firmware loading driver is =
beneficial.</div><div><br></div><div>For Realtek it seems the setup =
stage like what we do with Intel and Broadcom silicon is exactly what =
you want.</div><div><br></div><div>Can you provide a list of USB/PID =
that match to modules which require the firmware loading or optionally =
support the firmware loading. That would make it easier to populate the =
matching table. The decision on the module can be easily done by reading =
the HCI Local Version Information =
first.</div><div><br></div><div>Regards</div><div><br></div><div>Marcel</d=
iv><div><br></div></body></html>=

--Apple-Mail=_9E34E40F-3528-4D44-B9F3-5486B017C972--
