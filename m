Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Message-ID: <trinity-dacbeaab-fe7b-4d3b-b20f-683f2c24da20-1440438366507@3capp-webde-bs14>
From: "Norbert Holze" <norbert.holze@web.de>
To: linux-bluetooth@vger.kernel.org
Cc: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Aw: Re: btusb regression / 0a12:0001 CSR
Content-Type: text/html; charset=UTF-8
Date: Mon, 24 Aug 2015 19:46:06 +0200
In-Reply-To: <55C7947A.6050605@web.de>
References: <55C6F858.5080808@web.de>
 <BC6C2463-83DF-4825-95FC-A55A5B825B0A@holtmann.org>,
 <55C7947A.6050605@web.de>
List-ID: <linux-bluetooth.vger.kernel.org>

<html><head></head><body><div style="font-family: Verdana;font-size: 12.0px;"><div>
<div>Hello!</div>

<div>&nbsp;</div>

<div>Is it possible to add a quirk or something else?</div>

<div>&nbsp;</div>

<div>Regrads,</div>

<div>&nbsp;</div>

<div>Norbert</div>

<div>&nbsp;
<div name="quote" style="margin:10px 5px 5px 10px; padding: 10px 0 10px 10px; border-left:2px solid #C3D9E5; word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">
<div style="margin:0 0 10px 0;"><b>Gesendet:</b>&nbsp;Sonntag, 09. August 2015 um 19:57 Uhr<br/>
<b>Von:</b>&nbsp;&quot;Norbert Holze&quot; &lt;norbert.holze@web.de&gt;<br/>
<b>An:</b>&nbsp;&quot;Marcel Holtmann&quot; &lt;marcel@holtmann.org&gt;<br/>
<b>Cc:</b>&nbsp;linux-bluetooth@vger.kernel.org<br/>
<b>Betreff:</b>&nbsp;Re: btusb regression / 0a12:0001 CSR</div>

<div name="quoted-content">Hello Marcel,<br/>
<br/>
thanks for the fast reply.<br/>
<br/>
Am 09.08.2015 um 19:44 schrieb Marcel Holtmann:<br/>
<br/>
&gt; Please report the section from /sys/kernel/debug/usb/devices that corresponds to your device.<br/>
<br/>
T: Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 3 Spd=12 MxCh= 0<br/>
D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=16 #Cfgs= 1<br/>
P: Vendor=0a12 ProdID=0001 Rev= 1.34<br/>
C:* #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=100mA<br/>
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb<br/>
E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms<br/>
E: Ad=82(I) Atr=02(Bulk) MxPS= 64 Ivl=0ms<br/>
E: Ad=02(O) Atr=02(Bulk) MxPS= 64 Ivl=0ms<br/>
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb<br/>
E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms<br/>
E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms<br/>
I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb<br/>
E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms<br/>
E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms<br/>
I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb<br/>
E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms<br/>
E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms<br/>
<br/>
Regards,<br/>
<br/>
Norbert<br/>
&nbsp;</div>
</div>
</div>
</div></div></body></html>
