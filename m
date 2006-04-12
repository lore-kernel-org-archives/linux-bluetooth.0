Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <6297d67c0604112144k14e28ee2g2d1f569efce5cc6b@mail.gmail.com>
From: "Mayank Batra" <mayankbatra@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Linux as a HID mouse
In-Reply-To: <000001c65da7$5722fc30$052a650a@virgo.atlantico.net.br>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5466_21443881.1144817077845"
References: <000001c65da7$5722fc30$052a650a@virgo.atlantico.net.br>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 12 Apr 2006 10:14:37 +0530

------=_Part_5466_21443881.1144817077845
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Renan,

For registering HID service start sdpd and then try sdptool add HID

To Connect on L2CAP see:
bluez-utils-2.25\hidd\main.c
function l2cap_connect might help

Mayank


On 4/12/06, Renan <renan@atlantico.com.br> wrote:
>
>  Hello Everyone!
>
>
>
> I want to make a PC Linux to act as a HID mouse. The mouse button's
> pressing and movement will be simulated using the PC keyboard.
>
>
>
> Is there a framework to register the HID service, create L2CAP connection=
s
> (control and interrupt) and deal with host requests (GET_REPORT,
> GET_PROTOCOL etc)?
>
>
>
> As I am a novice BlueZ programmer, I don't know how to write this
> application. Could somebody help me?
>
>
>
>
>
> Thanks in advance,
>
>
>
> Renan Martins
>
>
>
>
>

------=_Part_5466_21443881.1144817077845
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Renan,</div>
<div>&nbsp;</div>
<div>For registering HID service start sdpd&nbsp;and then try&nbsp;sdptool =
add HID</div>
<div>&nbsp;</div>
<div>To Connect on L2CAP see:</div>
<div>bluez-utils-2.25\hidd\main.c </div>
<div>function l2cap_connect might help</div>
<div>&nbsp;</div>
<div>Mayank<br><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 4/12/06, <b class=3D"gmail_sendername">=
Renan</b> &lt;<a href=3D"mailto:renan@atlantico.com.br">renan@atlantico.com=
.br</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div style=3D"DIRECTION: ltr">
<div>
<p><span><font face=3D"Arial" size=3D"2"><span style=3D"FONT-SIZE: 10pt; FO=
NT-FAMILY: Arial">Hello</span></font></span><font face=3D"Arial" size=3D"2"=
><span style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"> <span>Everyone</span>=
!</span>
</font></p>
<p><font face=3D"Arial" size=3D"2"><span style=3D"FONT-SIZE: 10pt; FONT-FAM=
ILY: Arial">&nbsp;</span></font></p>
<p><font face=3D"Arial" size=3D"2"><span lang=3D"EN-US" style=3D"FONT-SIZE:=
 10pt; FONT-FAMILY: Arial">I want to make a PC Linux to act as a HID mouse.=
 The mouse button's pressing and movement will be simulated using the PC ke=
yboard.=20
</span></font></p>
<p><font face=3D"Arial" size=3D"2"><span lang=3D"EN-US" style=3D"FONT-SIZE:=
 10pt; FONT-FAMILY: Arial">&nbsp;</span></font></p>
<p><font face=3D"Arial" size=3D"2"><span lang=3D"EN-US" style=3D"FONT-SIZE:=
 10pt; FONT-FAMILY: Arial">Is there a framework to register the HID service=
, create L2CAP connections (control and interrupt) and deal with host reque=
sts (GET_REPORT, GET_PROTOCOL etc)?=20
</span></font></p>
<p><font face=3D"Arial" size=3D"2"><span lang=3D"EN-US" style=3D"FONT-SIZE:=
 10pt; FONT-FAMILY: Arial">&nbsp;</span></font></p>
<p><font face=3D"Arial" size=3D"2"><span lang=3D"EN-US" style=3D"FONT-SIZE:=
 10pt; FONT-FAMILY: Arial">As I am a novice <span>BlueZ</span> programmer, =
I don't know how to write this application. Could somebody help me?</span><=
/font>
</p>
<p><font face=3D"Arial" size=3D"2"><span lang=3D"EN-US" style=3D"FONT-SIZE:=
 10pt; FONT-FAMILY: Arial">&nbsp;</span></font></p>
<p><font face=3D"Arial" size=3D"2"><span lang=3D"EN-US" style=3D"FONT-SIZE:=
 10pt; FONT-FAMILY: Arial">&nbsp;</span></font></p>
<p><font face=3D"Arial" size=3D"2"><span lang=3D"EN-US" style=3D"FONT-SIZE:=
 10pt; FONT-FAMILY: Arial">Thanks in advance,</span></font></p>
<p><font face=3D"Arial" size=3D"2"><span lang=3D"EN-US" style=3D"FONT-SIZE:=
 10pt; FONT-FAMILY: Arial">&nbsp;</span></font></p>
<p><font face=3D"Arial" size=3D"2"><span lang=3D"EN-US" style=3D"FONT-SIZE:=
 10pt; FONT-FAMILY: Arial">Renan Martins </span></font><span lang=3D"EN-US"=
></span></p>
<p><font face=3D"Times New Roman" size=3D"3"><span lang=3D"EN-US" style=3D"=
FONT-SIZE: 12pt">&nbsp;</span></font></p>
<p><font face=3D"Times New Roman" size=3D"3"><span lang=3D"EN-US" style=3D"=
FONT-SIZE: 12pt">&nbsp;</span></font></p></div></div></blockquote></div><br=
>

------=_Part_5466_21443881.1144817077845--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
