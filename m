Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05091306033c7476a@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] HCID D-Bus (Seg Fault)
In-Reply-To: <1126567316.5518.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_19177_19027541.1126616617028"
References: <e1effdeb050908125079935830@mail.gmail.com>
	 <1126220839.5286.57.camel@blade>
	 <5256d0b050909012577fcb19c@mail.gmail.com>
	 <1126258645.5227.16.camel@blade>
	 <20050909132940.GE17543@spring.luon.net>
	 <1126273252.5227.119.camel@blade>
	 <e1effdeb050912140719fc9d3b@mail.gmail.com>
	 <1126561206.24935.1.camel@localhost.localdomain>
	 <e1effdeb050912160979b5ba49@mail.gmail.com>
	 <1126567316.5518.9.camel@localhost.localdomain>
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
Date: Tue, 13 Sep 2005 10:03:37 -0300

------=_Part_19177_19027541.1126616617028
Content-Type: multipart/alternative;
	boundary="----=_Part_19178_22148715.1126616617028"

------=_Part_19178_22148715.1126616617028
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

The patch for reply_handler_function is attached.

Regards,
Claudio.

On 9/12/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>=20
> Hi Claudio,
>=20
> > Regarding the reply_handler_function, please check if it is relevant.
> > I you want I can send only the changes for handle the error messages.
>=20
> please do so.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle=20
> Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_19178_22148715.1126616617028
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>Hi Marcel,<br>
<br>
The patch for reply_handler_function is attached.<br>
<br>
Regards,<br>
Claudio.<br>
<br>
<div><span class=3D"gmail_quote">On 9/12/05, <b class=3D"gmail_sendername">=
Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@holtm=
ann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"bor=
der-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-=
left: 1ex;">
Hi Claudio,<br><br>&gt; Regarding the reply_handler_function, please check =
if it is relevant.<br>&gt; I you want I can send only the changes for handl=
e the error messages.<br><br>please do so.<br><br>Regards<br><br>Marcel
<br><br><br><br><br>-------------------------------------------------------=
<br>SF.Net email is Sponsored by the Better Software Conference &amp; EXPO<=
br>September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practi=
ces
<br>Agile &amp; Plan-Driven Development * Managing Projects &amp; Teams * T=
esting &amp; QA<br>Security * Process Improvement &amp; Measurement * <a hr=
ef=3D"http://www.sqe.com/bsce5sf">http://www.sqe.com/bsce5sf</a><br>_______=
________________________________________
<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourcef=
orge.net">Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/=
lists/listinfo/bluez-devel
</a><br></blockquote></div><br>

------=_Part_19178_22148715.1126616617028--

------=_Part_19177_19027541.1126616617028
Content-Type: text/x-patch; name="hcid_dbus_0003.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="hcid_dbus_0003.patch"

LS0tIGJsdWV6LXV0aWxzLTIuMjEub3JpZy9oY2lkL2RidXMuYwkyMDA1LTA4LTI3IDEwOjM3OjE0
LjAwMDAwMDAwMCAtMDMwMAorKysgYmx1ZXotaGNpZC0yLjIxL2hjaWQvZGJ1cy5jCTIwMDUtMDkt
MTMgMDk6MDE6MjAuNDA5MDUyNDg4IC0wMzAwCkBAIC02OCwyNyArNjgsNDMgQEAKIAlwaW5fY29k
ZV9yZXBseV9jcCBwcjsKIAlEQnVzTWVzc2FnZSAqbWVzc2FnZTsKIAlEQnVzTWVzc2FnZUl0ZXIg
aXRlcjsKLQlpbnQgdHlwZTsKKwlpbnQgYXJnX3R5cGU7CisJaW50IG1zZ190eXBlOwogCXNpemVf
dCBsZW47CiAJY2hhciAqcGluOworCWNvbnN0IGNoYXIgKmVycm9yX21zZzsKIAogCW1lc3NhZ2Ug
PSBkYnVzX3BlbmRpbmdfY2FsbF9zdGVhbF9yZXBseShjYWxsKTsKIAotCWlmIChkYnVzX21lc3Nh
Z2VfaXNfZXJyb3IobWVzc2FnZSwgV1JPTkdfQVJHU19FUlJPUikpCi0JCWdvdG8gZXJyb3I7Ci0K
KwlpZiAobWVzc2FnZSkgeworCQltc2dfdHlwZSA9IGRidXNfbWVzc2FnZV9nZXRfdHlwZShtZXNz
YWdlKTsKIAlkYnVzX21lc3NhZ2VfaXRlcl9pbml0KG1lc3NhZ2UsICZpdGVyKTsKIAotCXR5cGUg
PSBkYnVzX21lc3NhZ2VfaXRlcl9nZXRfYXJnX3R5cGUoJml0ZXIpOwotCWlmICh0eXBlICE9IERC
VVNfVFlQRV9TVFJJTkcpCi0JCWdvdG8gZXJyb3I7CisJCWlmIChtc2dfdHlwZSA9PSBEQlVTX01F
U1NBR0VfVFlQRV9FUlJPUikgeworI2lmZGVmIEhBVkVfREJVU19NRVNTQUdFX0lURVJfR0VUX0JB
U0lDCisJCSAgICAgICAgZGJ1c19tZXNzYWdlX2l0ZXJfZ2V0X2Jhc2ljKCZpdGVyLCAmZXJyb3Jf
bXNnKTsKKyNlbHNlCisJCSAgICAgICAgZXJyb19tc2cgPSBkYnVzX21lc3NhZ2VfaXRlcl9nZXRf
c3RyaW5nKCZpdGVyKTsKKyNlbmRpZgorCQkJLyogaGFuZGxpbmcgV1JPTkdfQVJHU19FUlJPUiwg
REJVU19FUlJPUl9OT19SRVBMWSwgREJVU19FUlJPUl9TRVJWSUNFX1VOS05PV04gKi8KKwkJCXN5
c2xvZyhMT0dfRVJSLCAiJXM6ICVzIiwgZGJ1c19tZXNzYWdlX2dldF9lcnJvcl9uYW1lKG1lc3Nh
Z2UpLCBlcnJvcl9tc2cpOwogCisJCQloY2lfc2VuZF9jbWQocmVxLT5kZXYsIE9HRl9MSU5LX0NU
TCwKKwkJCQlPQ0ZfUElOX0NPREVfTkVHX1JFUExZLCA2LCAmcmVxLT5iZGEpOworCQl9IGVsc2Ug
eworCQkJLyogY2hlY2sgc2lnbmF0dXJlICovCisJCQlhcmdfdHlwZSA9IGRidXNfbWVzc2FnZV9p
dGVyX2dldF9hcmdfdHlwZSgmaXRlcik7CQorCQkJaWYgKGFyZ190eXBlICE9IERCVVNfVFlQRV9T
VFJJTkcpIHsKKwkJCQlzeXNsb2coTE9HX0VSUiwgIldyb25nIHJlcGx5IHNpZ25hdHVyZTogZXhw
ZWN0ZWQgUElOIik7CisJCQkKKwkJCQloY2lfc2VuZF9jbWQocmVxLT5kZXYsIE9HRl9MSU5LX0NU
TCwKKwkJCQkgICAgIE9DRl9QSU5fQ09ERV9ORUdfUkVQTFksIDYsICZyZXEtPmJkYSk7CisJCQl9
IGVsc2UgewogI2lmZGVmIEhBVkVfREJVU19NRVNTQUdFX0lURVJfR0VUX0JBU0lDCiAJZGJ1c19t
ZXNzYWdlX2l0ZXJfZ2V0X2Jhc2ljKCZpdGVyLCAmcGluKTsKICNlbHNlCiAJcGluID0gZGJ1c19t
ZXNzYWdlX2l0ZXJfZ2V0X3N0cmluZygmaXRlcik7CiAjZW5kaWYKLQogCWxlbiA9IHN0cmxlbihw
aW4pOwogCiAJbWVtc2V0KCZwciwgMCwgc2l6ZW9mKHByKSk7CkBAIC05NywxNSArMTEzLDEyIEBA
CiAJcHIucGluX2xlbiA9IGxlbjsKIAloY2lfc2VuZF9jbWQocmVxLT5kZXYsIE9HRl9MSU5LX0NU
TCwgT0NGX1BJTl9DT0RFX1JFUExZLAogCQkJCQkJUElOX0NPREVfUkVQTFlfQ1BfU0laRSwgJnBy
KTsKKwkJCX0KIAorCQl9CiAJZGJ1c19tZXNzYWdlX3VucmVmKG1lc3NhZ2UpOworCX0KIAlkYnVz
X3BlbmRpbmdfY2FsbF91bnJlZihjYWxsKTsKLQotCXJldHVybjsKLQotZXJyb3I6Ci0JaGNpX3Nl
bmRfY21kKHJlcS0+ZGV2LCBPR0ZfTElOS19DVEwsCi0JCQkJT0NGX1BJTl9DT0RFX05FR19SRVBM
WSwgNiwgJnJlcS0+YmRhKTsKIH0KIAogc3RhdGljIHZvaWQgZnJlZV9waW5fcmVxKHZvaWQgKnJl
cSkK
------=_Part_19177_19027541.1126616617028--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
