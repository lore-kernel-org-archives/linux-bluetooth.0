Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <445B4849.9070308@service2media.com>
From: Herman Meerlo <herman@service2media.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] D-Bus and two inquiries
References: <4450A0A7.1000504@service2media.com> <e1effdeb0605021103u5641f8f0gcbe172ff78fa7637@mail.gmail.com>
In-Reply-To: <e1effdeb0605021103u5641f8f0gcbe172ff78fa7637@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------020602030101070602060609"
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
Date: Fri, 05 May 2006 14:42:49 +0200

This is a multi-part message in MIME format.
--------------020602030101070602060609
Content-Type: multipart/alternative;
 boundary="------------010402050703020308070308"


--------------010402050703020308070308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Claudio,

thanks for your reply. It does indeed work as expected, the error was in 
some library at my side which caused the DiscoveryCompleted signal to be 
routed to the wrong application.

Regards,
Herman

Claudio Takahasi wrote:
> Hi Herman,
>
> If you have two local Bluetooth adapter, it's possible run two
> inquiries simultaneously.
> You can reproduce sending the inquiry command using dbus-send:
> $dbus-send --system --type=method_call --print-reply --dest=org.bluez
> /org/bluez/hci0 org.bluez.Adapter.DiscoverDevices
> $dbus-send --system --type=method_call --print-reply --dest=org.bluez
> /org/bluez/hci1 org.bluez.Adapter.DiscoverDevices
>
> If you have just one local adapter, the second inquiry request can be
> processed after the DiscoveryCompleted signal only.
>
> Regards,
> Claudio.
>
> On 4/27/06, Herman Meerlo <herman@service2media.com> wrote:
>> Hi all,
>>
>> I noticed that when I try to perform two inquiries on two different
>> devices simultaneously (using DBus), that one of the two will report
>> 'Discover already in progress'. Is this by design and if so why?
>>
>> Regards,
>> Herman Meerlo
>>
>>
>>
>> -------------------------------------------------------
>> Using Tomcat but need to do more? Need to support web services, 
>> security?
>> Get stuff done quickly with pre-integrated technology to make your 
>> job easier
>> Download IBM WebSphere Application Server v.1.0.1 based on Apache 
>> Geronimo
>> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>
>
>
> -- 
> ---------------------------------------------------------
> Claudio Takahasi
> Instituto Nokia de Tecnologia - INdT
>
>
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job 
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache 
> Geronimo
> http://sel.as-us.falkag.net/sel?cmd=k&kid0709&bid&3057&dat1642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-- 
service2media

**Herman Meerlo**
Software Engineer

Service2Media B.V.
Capitool 41 7521 PL Enschede
Postbus 75040 1070 AA Amsterdam
Mob +31 (0) 622 999 457
Tel +31 (0) 534 500 612
Fax +31 (0) 534 500 613
http://www.service2media.com


--------------010402050703020308070308
Content-Type: multipart/related;
 boundary="------------030405090703010106020400"


--------------030405090703010106020400
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Claudio,<br>
<br>
thanks for your reply. It does indeed work as expected, the error was
in some library at my side which caused the DiscoveryCompleted signal
to be routed to the wrong application.<br>
<br>
Regards,<br>
Herman<br>
<br>
Claudio Takahasi wrote:
<blockquote
 cite="mide1effdeb0605021103u5641f8f0gcbe172ff78fa7637@mail.gmail.com"
 type="cite">Hi Herman,
  <br>
  <br>
If you have two local Bluetooth adapter, it's possible run two
  <br>
inquiries simultaneously.
  <br>
You can reproduce sending the inquiry command using dbus-send:
  <br>
$dbus-send --system --type=method_call --print-reply --dest=org.bluez
  <br>
/org/bluez/hci0 org.bluez.Adapter.DiscoverDevices
  <br>
$dbus-send --system --type=method_call --print-reply --dest=org.bluez
  <br>
/org/bluez/hci1 org.bluez.Adapter.DiscoverDevices
  <br>
  <br>
If you have just one local adapter, the second inquiry request can be
  <br>
processed after the DiscoveryCompleted signal only.
  <br>
  <br>
Regards,
  <br>
Claudio.
  <br>
  <br>
On 4/27/06, Herman Meerlo <a class="moz-txt-link-rfc2396E" href="mailto:herman@service2media.com">&lt;herman@service2media.com&gt;</a> wrote:
  <br>
  <blockquote type="cite">Hi all,
    <br>
    <br>
I noticed that when I try to perform two inquiries on two different
    <br>
devices simultaneously (using DBus), that one of the two will report
    <br>
'Discover already in progress'. Is this by design and if so why?
    <br>
    <br>
Regards,
    <br>
Herman Meerlo
    <br>
    <br>
    <br>
    <br>
-------------------------------------------------------
    <br>
Using Tomcat but need to do more? Need to support web services,
security?
    <br>
Get stuff done quickly with pre-integrated technology to make your job
easier
    <br>
Download IBM WebSphere Application Server v.1.0.1 based on Apache
Geronimo
    <br>
<a class="moz-txt-link-freetext" href="http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642</a>
    <br>
_______________________________________________
    <br>
Bluez-devel mailing list
    <br>
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a>
    <br>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a>
    <br>
    <br>
  </blockquote>
  <br>
  <br>
--
  <br>
---------------------------------------------------------
  <br>
Claudio Takahasi
  <br>
Instituto Nokia de Tecnologia - INdT
  <br>
  <br>
  <br>
-------------------------------------------------------
  <br>
Using Tomcat but need to do more? Need to support web services,
security?
  <br>
Get stuff done quickly with pre-integrated technology to make your job
easier
  <br>
Download IBM WebSphere Application Server v.1.0.1 based on Apache
Geronimo
  <br>
<a class="moz-txt-link-freetext" href="http://sel.as-us.falkag.net/sel?cmd=k&kid0709&bid&3057&dat1642">http://sel.as-us.falkag.net/sel?cmd=k&amp;kid0709&amp;bid&amp;3057&amp;dat1642</a>
  <br>
_______________________________________________
  <br>
Bluez-devel mailing list
  <br>
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a>
  <br>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a>
  <br>
</blockquote>
<br>
<div class="moz-signature">-- <br>
<img alt="service2media"
 src="cid:part1.00030902.00070501@service2media.com" height="63"
 width="202"><br>
<p class="MsoNormal" style=""><strong><b><font color="#404040"
 face="Verdana" size="1"><span
 style="font-size: 8pt; color: rgb(64, 64, 64); font-family: Verdana;">Herman
Meerlo</span></font></b></strong><font color="#404040" face="Verdana"
 size="1"><span
 style="font-size: 8pt; color: rgb(64, 64, 64); font-family: Verdana;"><o:p></o:p><br>
Software Engineer </span></font><font color="#404040" face="Verdana"
 size="1"><span
 style="font-size: 8pt; color: rgb(64, 64, 64); font-family: Verdana;"><o:p></o:p></span></font></p>
<p class="MsoNormal" style=""><font color="#404040" face="Verdana"
 size="1"><span
 style="font-size: 8pt; color: rgb(64, 64, 64); font-family: Verdana;"
 lang="NL">Service2Media B.V.<br>
Capitool 41 7521 PL Enschede<o:p></o:p><br>
Postbus 75040 1070 AA Amsterdam <o:p></o:p></span></font><br>
<st1:city><st1:place><font color="#404040" face="Verdana" size="1"><span
 style="font-size: 8pt; color: rgb(64, 64, 64); font-family: Verdana;">Mob
+31 (0) 622 999 457<o:p></o:p></span></font></st1:place></st1:city><br>
<font color="#404040" face="Verdana" size="1"><span
 style="font-size: 8pt; color: rgb(64, 64, 64); font-family: Verdana;">Tel
+31 (0) 534 500 612<o:p></o:p><br>
Fax +31 (0) 534 500 613</span></font><font color="#404040"
 face="Verdana" size="1"><span
 style="font-size: 8pt; color: rgb(64, 64, 64); font-family: Verdana;"><o:p></o:p></span></font><font
 color="#404040" face="Verdana" size="1"><span
 style="font-size: 8pt; color: rgb(64, 64, 64); font-family: Verdana;"><br>
<a href="http://www.service2media.com"><font color="#404040"><span
 style="color: rgb(64, 64, 64);">http://www.service2media.com</span></font></a></span></font></p>
</div>
</body>
</html>

--------------030405090703010106020400
Content-Type: image/gif;
 name="s2m.gif"
Content-Transfer-Encoding: base64
Content-ID: <part1.00030902.00070501@service2media.com>
Content-Disposition: inline;
 filename="s2m.gif"

R0lGODlhygA/AMQAAP+MY//Yy/+yl//i2P9vPP/18v94Sf/Fsf+fff/s5f+CVv+piv/Pvv+V
cP+7pP9lL/9mAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
ACH5BAAAAAAALAAAAADKAD8AAAX/YCSOZGmeaKqubOu+cCzPdG3feK7vfO//wKBwSCwaj8ik
cslsOp/QqHRKrVqvuYIAEAEICtiw+HYwPLiAB+EwbrtXg/Tj3J2fA+/8u7BQCOxodlsIYHqG
Vg4GDhEBgHVzeGWLh5RPAQoLhY1zgZAifAZ4RgECAg6FpamlEQmpDgMipKIkBwIJtQklDK65
IqqlbCIDwIWxAQGwJQPHogXMzwG5ztABxSPMySTLx9kpDwskm3RyD7MRCw9GB3Zquex2jO8A
BQMPBiUJanWzA2bvCiLe0bnEjkA2OwbDsYslcI6AeA0VmHNEogABO/dWYArFkNOjcrEwASSS
70EDBwhA/0J6Fk9iogcI6jAg8edhGlEM5hgQEIDBAjMBJWL7iHEEOwOFElyEB1HgQ3ENg0Wg
OGIdO6kouCQA0CCBuE7lEiAAAIsLkXVmIxzAM8dEI7ONCKg1SeJirpsRLMI0EYxOiTQIBCx9
kExeXgXvOsJ8lkscggAHUtoRRVWEv8on0jIw0MARuQYKpKYVUtNE2xJvhemLYFfEugYi8Dp4
MBKFXxINkuX0NPUdAskLmz5ELWjE7Dmwe9+OsJu2nW4mRg8YDDbhiNFBGiUnsZJby56IY0b4
Ay4CYlF402A1LdS7wjm9GjZUbACAfbLCSVwO6PH6HAIl7ZWCWVoMNs47X8RmRP9r3BkGFW1J
6VNPRvtU6I1hJByXFkYGIsbUg5Pl599pVAUYE3C9ZMbcZXbEhM47BrCBXRB/YOdQKmw0YgAC
F4knQkqRPTBJhXh5sxOOFS01CyDNGRQciJ6IM1xsTFEFHCxSplCfQBw1xiInFBKB2JC9uUXH
dA9M2QhiBBSDV0o+nrBcCZ190yAdfzww05PFEefQCAUER1Gg8q0m5zsEPCSWSbk4YOBpRaB5
UDrEmVUPYSP4Eydem0CXV0AzivAiAczw51dgplKapZ9pCuMhXcqZlWeh6xnFDgK5CIbQFwUA
B2kROSlQyK8MpYVOWlZ1U2RKiSYlGKgnWJVYrKZ9iNH/fQCAAyVChfXnT6Kq2FFbCeLisVlD
BswUB1NCgJhcQ8fcptckFmFXZAS+CipQU9Nippyq8nGxrRozmcqFtHFGUCdIpq3BCjkBw3LA
RUTEga19M11s3wBxlBcLV6gUPMIC+F3TgD/ZJqMxFw2sbNZ9Hl93nzAug2OxxraQAPM590EX
wH1TkpAJHwIBsOU7QwddydJHTAyjjCsiSibTVA9RAMRpFkKgroBYU/XXQARgRlc6k5BAZ+mC
rTYRAsRYdlV+rC231WOhRzOuc+fdLgCEzIOARHoHLkQZBLgt+OFAFHCA14g37vjjkEcu+eSU
V2755ZhnrvnmnHfu+eeghy76QOikl2766ainrvrqrLfu+uuwxy67HhDUbvvtuOeu++689+77
78AHL/zwxBdv/O+zJ6/88sw37/zz0Ecv/fRghwAAOw==
--------------030405090703010106020400--

--------------010402050703020308070308--

--------------020602030101070602060609
Content-Type: text/x-vcard; charset=utf-8;
 name="herman.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="herman.vcf"

begin:vcard
fn:'t Haofke
n:'t Haofke
adr;dom:;;Veldstraat 20;Roermond;;6041GS
tel;work:0475317535
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------020602030101070602060609--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
