Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0509140500650ec0c0@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] HCID D-Bus (Seg Fault)
In-Reply-To: <1126637659.9456.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2293_22685482.1126699232673"
References: <e1effdeb050908125079935830@mail.gmail.com>
	 <1126258645.5227.16.camel@blade>
	 <20050909132940.GE17543@spring.luon.net>
	 <1126273252.5227.119.camel@blade>
	 <e1effdeb050912140719fc9d3b@mail.gmail.com>
	 <1126561206.24935.1.camel@localhost.localdomain>
	 <e1effdeb050912160979b5ba49@mail.gmail.com>
	 <1126567316.5518.9.camel@localhost.localdomain>
	 <e1effdeb05091306033c7476a@mail.gmail.com>
	 <1126637659.9456.0.camel@localhost.localdomain>
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
Date: Wed, 14 Sep 2005 09:00:32 -0300

------=_Part_2293_22685482.1126699232673
Content-Type: multipart/alternative;
	boundary="----=_Part_2294_29447383.1126699232673"

------=_Part_2294_29447383.1126699232673
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

It's done! The changes was based on the dbus.c revision 1.15.

Regards,
Claudio.

On 9/13/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>=20
> Hi Claudio,
>=20
> > The patch for reply_handler_function is attached.
>=20
> please redo it against the latest CVS, because I already dropped the
> D-Bus 0.23 support.
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

------=_Part_2294_29447383.1126699232673
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
It's done! The changes was based on the dbus.c revision 1.15.<br>
<br>
Regards,<br>
Claudio.<br><br><div><span class=3D"gmail_quote">On 9/13/05, <b class=3D"gm=
ail_sendername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.o=
rg">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quo=
te" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt=
 0.8ex; padding-left: 1ex;">
Hi Claudio,<br><br>&gt; The patch for reply_handler_function is attached.<b=
r><br>please redo it against the latest CVS, because I already dropped the<=
br>D-Bus 0.23 support.<br><br>Regards<br><br>Marcel<br><br><br><br><br>
-------------------------------------------------------<br>SF.Net email is =
sponsored by:<br>Tame your development challenges with Apache's Geronimo Ap=
p Server.<br>Download it for free - -and be entered to win a 42&quot; plasm=
a tv or your very
<br>own Sony(tm)PSP.&nbsp;&nbsp;Click here to play: <a href=3D"http://sourc=
eforge.net/geronimo.php">http://sourceforge.net/geronimo.php</a><br>_______=
________________________________________<br>Bluez-devel mailing list<br><a =
href=3D"mailto:Bluez-devel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/list=
info/bluez-devel</a><br></blockquote></div><br>

------=_Part_2294_29447383.1126699232673--

------=_Part_2293_22685482.1126699232673
Content-Type: text/x-patch; name="hcid_dbus_0004.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="hcid_dbus_0004.patch"

LS0tIGJsdWV6LXV0aWxzLWN2cy5vcmlnL2hjaWQvZGJ1cy5jCTIwMDUtMDktMTQgMDg6NTE6NTgu
NDcwOTM3MDI0IC0wMzAwCisrKyBibHVlei11dGlscy1jdnMvaGNpZC9kYnVzLmMJMjAwNS0wOS0x
NCAwODo0NjowOS44NTM5MzQ4NjQgLTAzMDAKQEAgLTY0LDQzICs2NCw1NCBAQAogCiBzdGF0aWMg
dm9pZCByZXBseV9oYW5kbGVyX2Z1bmN0aW9uKERCdXNQZW5kaW5nQ2FsbCAqY2FsbCwgdm9pZCAq
dXNlcl9kYXRhKQogewotCXN0cnVjdCBwaW5fcmVxdWVzdCAqcmVxID0gKHN0cnVjdCBwaW5fcmVx
dWVzdCAqKSB1c2VyX2RhdGE7Ci0JcGluX2NvZGVfcmVwbHlfY3AgcHI7Ci0JREJ1c01lc3NhZ2Ug
Km1lc3NhZ2U7Ci0JREJ1c01lc3NhZ2VJdGVyIGl0ZXI7Ci0JaW50IHR5cGU7Ci0Jc2l6ZV90IGxl
bjsKLQljaGFyICpwaW47Ci0KLQltZXNzYWdlID0gZGJ1c19wZW5kaW5nX2NhbGxfc3RlYWxfcmVw
bHkoY2FsbCk7Ci0KLQlpZiAoZGJ1c19tZXNzYWdlX2lzX2Vycm9yKG1lc3NhZ2UsIFdST05HX0FS
R1NfRVJST1IpKQotCQlnb3RvIGVycm9yOwotCi0JZGJ1c19tZXNzYWdlX2l0ZXJfaW5pdChtZXNz
YWdlLCAmaXRlcik7Ci0KLQl0eXBlID0gZGJ1c19tZXNzYWdlX2l0ZXJfZ2V0X2FyZ190eXBlKCZp
dGVyKTsKLQlpZiAodHlwZSAhPSBEQlVTX1RZUEVfU1RSSU5HKQotCQlnb3RvIGVycm9yOwotCi0J
ZGJ1c19tZXNzYWdlX2l0ZXJfZ2V0X2Jhc2ljKCZpdGVyLCAmcGluKTsKLQlsZW4gPSBzdHJsZW4o
cGluKTsKLQotCW1lbXNldCgmcHIsIDAsIHNpemVvZihwcikpOwotCWJhY3B5KCZwci5iZGFkZHIs
ICZyZXEtPmJkYSk7Ci0JbWVtY3B5KHByLnBpbl9jb2RlLCBwaW4sIGxlbik7Ci0JcHIucGluX2xl
biA9IGxlbjsKLQloY2lfc2VuZF9jbWQocmVxLT5kZXYsIE9HRl9MSU5LX0NUTCwgT0NGX1BJTl9D
T0RFX1JFUExZLAotCQkJCQkJUElOX0NPREVfUkVQTFlfQ1BfU0laRSwgJnByKTsKLQotCWRidXNf
bWVzc2FnZV91bnJlZihtZXNzYWdlKTsKLQlkYnVzX3BlbmRpbmdfY2FsbF91bnJlZihjYWxsKTsK
LQotCXJldHVybjsKLQotZXJyb3I6Ci0JaGNpX3NlbmRfY21kKHJlcS0+ZGV2LCBPR0ZfTElOS19D
VEwsCi0JCQkJT0NGX1BJTl9DT0RFX05FR19SRVBMWSwgNiwgJnJlcS0+YmRhKTsKKyAgICAgICAg
c3RydWN0IHBpbl9yZXF1ZXN0ICpyZXEgPSAoc3RydWN0IHBpbl9yZXF1ZXN0ICopIHVzZXJfZGF0
YTsKKyAgICAgICAgcGluX2NvZGVfcmVwbHlfY3AgcHI7CisgICAgICAgIERCdXNNZXNzYWdlICpt
ZXNzYWdlOworICAgICAgICBEQnVzTWVzc2FnZUl0ZXIgaXRlcjsKKyAgICAgICAgaW50IGFyZ190
eXBlOworICAgICAgICBpbnQgbXNnX3R5cGU7CisgICAgICAgIHNpemVfdCBsZW47CisgICAgICAg
IGNoYXIgKnBpbjsKKyAgICAgICAgY29uc3QgY2hhciAqZXJyb3JfbXNnOworCisgICAgICAgIG1l
c3NhZ2UgPSBkYnVzX3BlbmRpbmdfY2FsbF9zdGVhbF9yZXBseShjYWxsKTsKKworICAgICAgICBp
ZiAobWVzc2FnZSkgeworICAgICAgICAgICAgICAgIG1zZ190eXBlID0gZGJ1c19tZXNzYWdlX2dl
dF90eXBlKG1lc3NhZ2UpOworICAgICAgICAgICAgICAgIGRidXNfbWVzc2FnZV9pdGVyX2luaXQo
bWVzc2FnZSwgJml0ZXIpOworCisgICAgICAgICAgICAgICAgaWYgKG1zZ190eXBlID09IERCVVNf
TUVTU0FHRV9UWVBFX0VSUk9SKSB7CisgICAgICAgICAgICAgICAgICAgICAgICBkYnVzX21lc3Nh
Z2VfaXRlcl9nZXRfYmFzaWMoJml0ZXIsICZlcnJvcl9tc2cpOworICAgICAgICAgICAgICAgICAg
ICAgICAgLyogaGFuZGxpbmcgV1JPTkdfQVJHU19FUlJPUiwgREJVU19FUlJPUl9OT19SRVBMWSwg
REJVU19FUlJPUl9TRVJWSUNFX1VOS05PV04gKi8KKyAgICAgICAgICAgICAgICAgICAgICAgIHN5
c2xvZyhMT0dfRVJSLCAiJXM6ICVzIiwgZGJ1c19tZXNzYWdlX2dldF9lcnJvcl9uYW1lKG1lc3Nh
Z2UpLCBlcnJvcl9tc2cpOworCisgICAgICAgICAgICAgICAgICAgICAgICBoY2lfc2VuZF9jbWQo
cmVxLT5kZXYsIE9HRl9MSU5LX0NUTCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
T0NGX1BJTl9DT0RFX05FR19SRVBMWSwgNiwgJnJlcS0+YmRhKTsKKyAgICAgICAgICAgICAgICB9
IGVsc2UgeworICAgICAgICAgICAgICAgICAgICAgICAgLyogY2hlY2sgc2lnbmF0dXJlICovCisg
ICAgICAgICAgICAgICAgICAgICAgICBhcmdfdHlwZSA9IGRidXNfbWVzc2FnZV9pdGVyX2dldF9h
cmdfdHlwZSgmaXRlcik7CisgICAgICAgICAgICAgICAgICAgICAgICBpZiAoYXJnX3R5cGUgIT0g
REJVU19UWVBFX1NUUklORykgeworICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzeXNs
b2coTE9HX0VSUiwgIldyb25nIHJlcGx5IHNpZ25hdHVyZTogZXhwZWN0ZWQgUElOIik7CisKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaGNpX3NlbmRfY21kKHJlcS0+ZGV2LCBPR0Zf
TElOS19DVEwsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT0NGX1BJTl9D
T0RFX05FR19SRVBMWSwgNiwgJnJlcS0+YmRhKTsKKyAgICAgICAgICAgICAgICAgICAgICAgIH0g
ZWxzZSB7CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRidXNfbWVzc2FnZV9pdGVy
X2dldF9iYXNpYygmaXRlciwgJnBpbik7CisKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbGVuID0gc3RybGVuKHBpbik7CisKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bWVtc2V0KCZwciwgMCwgc2l6ZW9mKHByKSk7CisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJhY3B5KCZwci5iZGFkZHIsICZyZXEtPmJkYSk7CisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG1lbWNweShwci5waW5fY29kZSwgcGluLCBsZW4pOworICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBwci5waW5fbGVuID0gbGVuOworICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBoY2lfc2VuZF9jbWQocmVxLT5kZXYsIE9HRl9MSU5LX0NUTCwgT0NGX1BJTl9D
T0RFX1JFUExZLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBJTl9D
T0RFX1JFUExZX0NQX1NJWkUsICZwcik7CisgICAgICAgICAgICAgICAgICAgICAgICB9CisKKyAg
ICAgICAgICAgICAgICB9CisgICAgICAgICAgICAgICAgZGJ1c19tZXNzYWdlX3VucmVmKG1lc3Nh
Z2UpOworICAgICAgICB9CisgICAgICAgIGRidXNfcGVuZGluZ19jYWxsX3VucmVmKGNhbGwpOwog
fQogCiBzdGF0aWMgdm9pZCBmcmVlX3Bpbl9yZXEodm9pZCAqcmVxKQo=
------=_Part_2293_22685482.1126699232673--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
