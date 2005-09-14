Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05091409061f00ea01@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] HCID D-Bus (Seg Fault)
In-Reply-To: <1126710977.16166.62.camel@station6.example.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_3669_10508220.1126714001202"
References: <e1effdeb050908125079935830@mail.gmail.com>
	 <1126273252.5227.119.camel@blade>
	 <e1effdeb050912140719fc9d3b@mail.gmail.com>
	 <1126561206.24935.1.camel@localhost.localdomain>
	 <e1effdeb050912160979b5ba49@mail.gmail.com>
	 <1126567316.5518.9.camel@localhost.localdomain>
	 <e1effdeb05091306033c7476a@mail.gmail.com>
	 <1126637659.9456.0.camel@localhost.localdomain>
	 <e1effdeb0509140500650ec0c0@mail.gmail.com>
	 <1126710977.16166.62.camel@station6.example.com>
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
Date: Wed, 14 Sep 2005 13:06:41 -0300

------=_Part_3669_10508220.1126714001202
Content-Type: multipart/alternative;
	boundary="----=_Part_3670_14685884.1126714001202"

------=_Part_3670_14685884.1126714001202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

sorry. It's done!

Regards,
Claudio.


On 9/14/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>=20
> Hi Claudio,
>=20
> > It's done! The changes was based on the dbus.c revision 1.15.
>=20
> you used spaces instead of tabs. Please redo it again.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server.
> Download it for free - -and be entered to win a 42" plasma tv or your ver=
y
> own Sony(tm)PSP. Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_3670_14685884.1126714001202
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

sorry. It's done!<br>
<br>
Regards,<br>
Claudio.<br>
<br><br><div><span class=3D"gmail_quote">On 9/14/05, <b class=3D"gmail_send=
ername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marc=
el@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" styl=
e=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; =
padding-left: 1ex;">
Hi Claudio,<br><br>&gt; It's done! The changes was based on the dbus.c revi=
sion 1.15.<br><br>you used spaces instead of tabs. Please redo it again.<br=
><br>Regards<br><br>Marcel<br><br><br><br><br>-----------------------------=
--------------------------
<br>SF.Net email is sponsored by:<br>Tame your development challenges with =
Apache's Geronimo App Server.<br>Download it for free - -and be entered to =
win a 42&quot; plasma tv or your very<br>own Sony(tm)PSP.&nbsp;&nbsp;Click =
here to play:=20
<a href=3D"http://sourceforge.net/geronimo.php">http://sourceforge.net/gero=
nimo.php</a><br>_______________________________________________<br>Bluez-de=
vel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bl=
uez-devel@lists.sourceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel=
">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockqu=
ote></div><br>

------=_Part_3670_14685884.1126714001202--

------=_Part_3669_10508220.1126714001202
Content-Type: text/x-patch; name="hcid_dbus_0005.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="hcid_dbus_0005.patch"

LS0tIGJsdWV6LXV0aWxzLWN2cy5vcmlnL2hjaWQvZGJ1cy5jCTIwMDUtMDktMTQgMDg6NTE6NTgu
NDcwOTM3MDI0IC0wMzAwCisrKyBibHVlei11dGlscy1jdnMvaGNpZC9kYnVzLmMJMjAwNS0wOS0x
NCAxMzowMjowNi41NTMzNjE2OTYgLTAzMDAKQEAgLTY4LDM5ICs2OCw0NyBAQAogCXBpbl9jb2Rl
X3JlcGx5X2NwIHByOwogCURCdXNNZXNzYWdlICptZXNzYWdlOwogCURCdXNNZXNzYWdlSXRlciBp
dGVyOwotCWludCB0eXBlOworCWludCBhcmdfdHlwZTsKKwlpbnQgbXNnX3R5cGU7CiAJc2l6ZV90
IGxlbjsKIAljaGFyICpwaW47Ci0KKwljb25zdCBjaGFyICplcnJvcl9tc2c7CisgICAgICAgIAog
CW1lc3NhZ2UgPSBkYnVzX3BlbmRpbmdfY2FsbF9zdGVhbF9yZXBseShjYWxsKTsKLQotCWlmIChk
YnVzX21lc3NhZ2VfaXNfZXJyb3IobWVzc2FnZSwgV1JPTkdfQVJHU19FUlJPUikpCi0JCWdvdG8g
ZXJyb3I7Ci0KLQlkYnVzX21lc3NhZ2VfaXRlcl9pbml0KG1lc3NhZ2UsICZpdGVyKTsKLQotCXR5
cGUgPSBkYnVzX21lc3NhZ2VfaXRlcl9nZXRfYXJnX3R5cGUoJml0ZXIpOwotCWlmICh0eXBlICE9
IERCVVNfVFlQRV9TVFJJTkcpCi0JCWdvdG8gZXJyb3I7Ci0KLQlkYnVzX21lc3NhZ2VfaXRlcl9n
ZXRfYmFzaWMoJml0ZXIsICZwaW4pOwotCWxlbiA9IHN0cmxlbihwaW4pOwotCi0JbWVtc2V0KCZw
ciwgMCwgc2l6ZW9mKHByKSk7Ci0JYmFjcHkoJnByLmJkYWRkciwgJnJlcS0+YmRhKTsKLQltZW1j
cHkocHIucGluX2NvZGUsIHBpbiwgbGVuKTsKLQlwci5waW5fbGVuID0gbGVuOwotCWhjaV9zZW5k
X2NtZChyZXEtPmRldiwgT0dGX0xJTktfQ1RMLCBPQ0ZfUElOX0NPREVfUkVQTFksCi0JCQkJCQlQ
SU5fQ09ERV9SRVBMWV9DUF9TSVpFLCAmcHIpOwotCi0JZGJ1c19tZXNzYWdlX3VucmVmKG1lc3Nh
Z2UpOworICAgICAgICAKKwlpZiAobWVzc2FnZSkgeworCQltc2dfdHlwZSA9IGRidXNfbWVzc2Fn
ZV9nZXRfdHlwZShtZXNzYWdlKTsKKwkJZGJ1c19tZXNzYWdlX2l0ZXJfaW5pdChtZXNzYWdlLCAm
aXRlcik7CisJCQorCQlpZiAobXNnX3R5cGUgPT0gREJVU19NRVNTQUdFX1RZUEVfRVJST1IpIHsK
KwkJCWRidXNfbWVzc2FnZV9pdGVyX2dldF9iYXNpYygmaXRlciwgJmVycm9yX21zZyk7CisJCQkv
KiBoYW5kbGluZyBXUk9OR19BUkdTX0VSUk9SLCBEQlVTX0VSUk9SX05PX1JFUExZLCBEQlVTX0VS
Uk9SX1NFUlZJQ0VfVU5LTk9XTiAqLworCQkJc3lzbG9nKExPR19FUlIsICIlczogJXMiLCBkYnVz
X21lc3NhZ2VfZ2V0X2Vycm9yX25hbWUobWVzc2FnZSksIGVycm9yX21zZyk7CisJCQloY2lfc2Vu
ZF9jbWQocmVxLT5kZXYsIE9HRl9MSU5LX0NUTCwKKwkJCQkgICAgIE9DRl9QSU5fQ09ERV9ORUdf
UkVQTFksIDYsICZyZXEtPmJkYSk7CisJCX0gZWxzZSB7CisJCQkvKiBjaGVjayBzaWduYXR1cmUg
Ki8KKwkJCWFyZ190eXBlID0gZGJ1c19tZXNzYWdlX2l0ZXJfZ2V0X2FyZ190eXBlKCZpdGVyKTsK
KwkJCWlmIChhcmdfdHlwZSAhPSBEQlVTX1RZUEVfU1RSSU5HKSB7CisJCQkJc3lzbG9nKExPR19F
UlIsICJXcm9uZyByZXBseSBzaWduYXR1cmU6IGV4cGVjdGVkIFBJTiIpOworCQkJCWhjaV9zZW5k
X2NtZChyZXEtPmRldiwgT0dGX0xJTktfQ1RMLAorCQkJCQkgICAgIE9DRl9QSU5fQ09ERV9ORUdf
UkVQTFksIDYsICZyZXEtPmJkYSk7CisJCQl9IGVsc2UgeworCQkJCWRidXNfbWVzc2FnZV9pdGVy
X2dldF9iYXNpYygmaXRlciwgJnBpbik7CisJCQkJCisJCQkJbGVuID0gc3RybGVuKHBpbik7CisJ
CQkJCisJCQkJbWVtc2V0KCZwciwgMCwgc2l6ZW9mKHByKSk7CisJCQkJYmFjcHkoJnByLmJkYWRk
ciwgJnJlcS0+YmRhKTsKKwkJCQltZW1jcHkocHIucGluX2NvZGUsIHBpbiwgbGVuKTsKKwkJCQlw
ci5waW5fbGVuID0gbGVuOworCQkJCWhjaV9zZW5kX2NtZChyZXEtPmRldiwgT0dGX0xJTktfQ1RM
LCBPQ0ZfUElOX0NPREVfUkVQTFksCisJCQkJCSAgICAgUElOX0NPREVfUkVQTFlfQ1BfU0laRSwg
JnByKTsKKwkJCX0KKyAgICAgICAgICAgICAgICB9CisJCWRidXNfbWVzc2FnZV91bnJlZihtZXNz
YWdlKTsKKwl9CiAJZGJ1c19wZW5kaW5nX2NhbGxfdW5yZWYoY2FsbCk7Ci0KLQlyZXR1cm47Ci0K
LWVycm9yOgotCWhjaV9zZW5kX2NtZChyZXEtPmRldiwgT0dGX0xJTktfQ1RMLAotCQkJCU9DRl9Q
SU5fQ09ERV9ORUdfUkVQTFksIDYsICZyZXEtPmJkYSk7CiB9CiAKIHN0YXRpYyB2b2lkIGZyZWVf
cGluX3JlcSh2b2lkICpyZXEpCg==
------=_Part_3669_10508220.1126714001202--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
