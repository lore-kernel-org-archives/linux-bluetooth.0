Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C69496.2B6D69C9"
Date: Tue, 20 Jun 2006 14:19:11 -0400
Message-ID: <70DCB28C5BB04A4BBB1C8512589BAC65ED7DE4@MAIL006.mail.lan>
In-Reply-To: <1150797013.18381.31.camel@localhost>
From: "Brand, Chris" <chris.brand@qwikker.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bccmd patch
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C69496.2B6D69C9
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20
> I applied the OPT_RANGE changes, but I didn't apply the=20
> usage() change.

I would have thought that it should be in both the manpage and the
usage.

> Please update the manpage to include them there.

Patch attached (against 3.1).

Chris

------_=_NextPart_001_01C69496.2B6D69C9
Content-Type: application/octet-stream;
	name="bccmd_man.patch"
Content-Transfer-Encoding: base64
Content-Description: bccmd_man.patch
Content-Disposition: attachment;
	filename="bccmd_man.patch"

LS0tIGJsdWV6LXV0aWxzLTMuMS90b29scy9iY2NtZC44Lm9yaWcJMjAwNi0wNi0yMCAxMTowNDow
Ny4wMDAwMDAwMDAgLTA3MDAKKysrIGJsdWV6LXV0aWxzLTMuMS90b29scy9iY2NtZC44CTIwMDYt
MDYtMjAgMTE6MTU6NDQuMDAwMDAwMDAwIC0wNzAwCkBAIC0xLDQgKzEsNCBAQAotLlRIIEJDQ01E
IDggIkRlYyA2IDIwMDUiIEJsdWVaICJMaW51eCBTeXN0ZW0gQWRtaW5pc3RyYXRpb24iCisuVEgg
QkNDTUQgOCAiSnVuIDIwIDIwMDYiIEJsdWVaICJMaW51eCBTeXN0ZW0gQWRtaW5pc3RyYXRpb24i
CiAuU0ggTkFNRQogYmNjbWQgXC0gVXRpbGl0eSBmb3IgdGhlIENTUiBCQ0NNRCBpbnRlcmZhY2UK
IC5TSCBTWU5PUFNJUwpAQCAtODcsMzAgKzg3LDM3IEBACiAuQkkgbWVtdHlwZXMKIEdldCBtZW1v
cnkgdHlwZXMKIC5UUAotLkJJIHBzZ2V0XCA8a2V5PgotR2V0IHZhbHVlIGZvciBQUyBrZXkKLS5U
UAotLkJJIHBzc2V0XCA8a2V5PlwgPHZhbHVlPgotU2V0IHZhbHVlIGZvciBQUyBrZXkKLS5UUAot
LkJJIHBzY2xyXCA8a2V5PgotQ2xlYXIgdmFsdWUgZm9yIFBTIGtleQotLlRQCi0uQkkgcHNsaXN0
Ci1MaXN0IGFsbCBQUyBrZXlzCi0uVFAKLS5CSSBwc3JlYWQKLVJlYWQgYWxsIFBTIGtleXMKLS5U
UAotLkJJIHBzbG9hZFwgPGZpbGU+Ci1Mb2FkIGFsbCBQUyBrZXlzIGZyb20gUFNSIGZpbGUKLS5U
UAotLkJJIHBzY2hlY2tcIDxmaWxlPgotQ2hlY2sgc3ludGF4IG9mIFBTUiBmaWxlCisuQkkgcHNn
ZXRcIFstcl1cIFstc1wgPHN0b3JlPl1cIDxrZXk+CitHZXQgdmFsdWUgZm9yIFBTIGtleS4KKy1y
IHNlbmRzIGEgd2FybSByZXNldCBhZnRlcndhcmRzCisuVFAKKy5CSSBwc3NldFwgWy1yXVwgWy1z
XCA8c3RvcmU+XVwgPGtleT5cIDx2YWx1ZT4KK1NldCB2YWx1ZSBmb3IgUFMga2V5LgorLXIgc2Vu
ZHMgYSB3YXJtIHJlc2V0IGFmdGVyd2FyZHMKKy5UUAorLkJJIHBzY2xyXCBbLXJdXCBbLXNcIDxz
dG9yZT5dXCA8a2V5PgorQ2xlYXIgdmFsdWUgZm9yIFBTIGtleS4KKy1yIHNlbmRzIGEgd2FybSBy
ZXNldCBhZnRlcndhcmRzCisuVFAKKy5CSSBwc2xpc3RcIFstcl1cIFstc1wgPHN0b3JlPl0KK0xp
c3QgYWxsIFBTIGtleXMuCistciBzZW5kcyBhIHdhcm0gcmVzZXQgYWZ0ZXJ3YXJkcworLlRQCisu
QkkgcHNyZWFkXCBbLXJdXCBbLXNcIDxzdG9yZT5dCitSZWFkIGFsbCBQUyBrZXlzLgorLXIgc2Vu
ZHMgYSB3YXJtIHJlc2V0IGFmdGVyd2FyZHMKKy5UUAorLkJJIHBzbG9hZFwgWy1yXVwgWy1zXCA8
c3RvcmU+XVwgPGZpbGU+CitMb2FkIGFsbCBQUyBrZXlzIGZyb20gUFNSIGZpbGUuCistciBzZW5k
cyBhIHdhcm0gcmVzZXQgYWZ0ZXJ3YXJkcworLlRQCisuQkkgcHNjaGVja1wgWy1yXVwgWy1zXCA8
c3RvcmU+XVwgPGZpbGU+CitDaGVjayBzeW50YXggb2YgUFNSIGZpbGUuCistciBzZW5kcyBhIHdh
cm0gcmVzZXQgYWZ0ZXJ3YXJkcwogLlNIIEtFWVMKIGJkYWRkciBjb3VudHJ5IGRldmNsYXNzIGtl
eW1pbiBrZXltYXggZmVhdHVyZXMgY29tbWFuZHMgdmVyc2lvbgogcmVtdmVyIGhjaWV4dG4gbWFw
c2NvIGJhdWRyYXRlIGhvc3RpbnRmIGFuYWZyZXEgYW5hZnRyaW0gdXNidmlkCi11c2JwaWQgZGZ1
cGlkIGJvb3Rtb2RlCit1c2JwaWQgZGZ1cGlkIGJvb3Rtb2RlIG9yIGhleCB2YWx1ZQogLlNIIEFV
VEhPUlMKIFdyaXR0ZW4gYnkgTWFyY2VsIEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1hbm4ub3JnPiwK
IG1hbiBwYWdlIGJ5IEFkYW0gTGF1cmllIDxhZGFtQGFsZ3JvdXAuY28udWs+Cg==

------_=_NextPart_001_01C69496.2B6D69C9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C69496.2B6D69C9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------_=_NextPart_001_01C69496.2B6D69C9--
