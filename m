Return-Path: <cyrus@holtmann.org>
From: Michael Terry <michael.terry@ubuntu.com>
To: bluez-devel@lists.sourceforge.net
Date: Wed, 21 May 2008 08:57:02 -0400
Message-Id: <1211374622.5826.18.camel@bongo>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Support translations in bluez-utils
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0121516963=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0121516963==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Anua7pjmRkbLRNNagGhz"


--=-Anua7pjmRkbLRNNagGhz
Content-Type: multipart/mixed; boundary="=-uAk1kXpMMgdI+BSBmnlm"


--=-uAk1kXpMMgdI+BSBmnlm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello!

I am attaching a patch and some files that all together allow gettext
translations for bluez-utils.  I'd appreciate a review/commit.

The particular strings motivating this patch were the service names in
hcid/dbus-service.c.  There may be other good candidates for
translation, but I only marked those few strings.

I noted there was an audio/audio.service file which would also be a
candidate for translation, but I didn't see it being used anywhere?  I
can provide a further patch for that if it's used.

Files:
bluez-utils-po.diff
gi18n.h (add as eglib/glib/gi18n.h - this is a simplified copy from
glib; it goes in the redundant glib subdirectory to match glib's include
layout)
Makevars (add as po/Makevars - this is like a config file for gettext)
POTFILES.in (add as po/POTFILES.in - this lists any files to scan for
marked strings)

=EF=BB=BFAlso, you'll need to add a blank LINGUAS file in the po directory =
in
which to add language codes as they come in.

Finally, you should add a blank ChangeLog file in the po directory for
translators (or whoever cvs commits) to note new/updated translations.

Thank you!
-mt

--=-uAk1kXpMMgdI+BSBmnlm
Content-Disposition: attachment; filename=gi18n.h
Content-Type: text/x-chdr; name=gi18n.h; charset=UTF-8
Content-Transfer-Encoding: base64

LyogR0xJQiAtIExpYnJhcnkgb2YgdXNlZnVsIHJvdXRpbmVzIGZvciBDIHByb2dyYW1taW5nDQog
KiBDb3B5cmlnaHQgKEMpIDE5OTUtMTk5NywgMjAwMiAgUGV0ZXIgTWF0dGlzLCBSZWQgSGF0LCBJ
bmMuDQogKg0KICogVGhpcyBsaWJyYXJ5IGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0
cmlidXRlIGl0IGFuZC9vcg0KICogbW9kaWZ5IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05V
IExlc3NlciBHZW5lcmFsIFB1YmxpYw0KICogTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkgdGhlIEZy
ZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyDQogKiB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vu
c2UsIG9yIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uDQogKg0KICogVGhpcyBs
aWJyYXJ5IGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWws
DQogKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3
YXJyYW50eSBvZg0KICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxB
UiBQVVJQT1NFLiAgU2VlIHRoZSBHTlUNCiAqIExlc3NlciBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
IGZvciBtb3JlIGRldGFpbHMuDQogKg0KICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29w
eSBvZiB0aGUgR05VIExlc3NlciBHZW5lcmFsIFB1YmxpYw0KICogTGljZW5zZSBhbG9uZyB3aXRo
IHRoaXMgbGlicmFyeTsgaWYgbm90LCB3cml0ZSB0byB0aGUNCiAqIEZyZWUgU29mdHdhcmUgRm91
bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBsYWNlIC0gU3VpdGUgMzMwLA0KICogQm9zdG9uLCBN
QSAwMjExMS0xMzA3LCBVU0EuDQogKi8NCiNpZm5kZWYgX19HX0kxOE5fSF9fDQojZGVmaW5lIF9f
R19JMThOX0hfXw0KDQovKiNpbmNsdWRlIDxnbGliL2dzdHJmdW5jcy5oPiovDQojaW5jbHVkZSA8
bGliaW50bC5oPg0KDQojZGVmaW5lICBfKFN0cmluZykgZ2V0dGV4dCAoU3RyaW5nKQ0KLyojZGVm
aW5lIFFfKFN0cmluZykgZ19kcGdldHRleHQgKE5VTEwsIFN0cmluZywgMCkqLw0KI2RlZmluZSBO
XyhTdHJpbmcpIChTdHJpbmcpDQovKiNkZWZpbmUgQ18oQ29udGV4dCxTdHJpbmcpIGdfZHBnZXR0
ZXh0IChOVUxMLCBDb250ZXh0ICJcMDA0IiBTdHJpbmcsIHN0cmxlbiAoQ29udGV4dCkgKyAxKSov
DQoNCg0KI2VuZGlmICAvKiBfX0dfSTE4Tl9IX18gKi8NCg0KDQo=


--=-uAk1kXpMMgdI+BSBmnlm
Content-Disposition: attachment; filename=Makevars
Content-Type: text/plain; name=Makevars; charset=UTF-8
Content-Transfer-Encoding: base64

IyBNYWtlZmlsZSB2YXJpYWJsZXMgZm9yIFBPIGRpcmVjdG9yeSBpbiBhbnkgcGFja2FnZSB1c2lu
ZyBHTlUgZ2V0dGV4dC4NCg0KIyBVc3VhbGx5IHRoZSBtZXNzYWdlIGRvbWFpbiBpcyB0aGUgc2Ft
ZSBhcyB0aGUgcGFja2FnZSBuYW1lLg0KRE9NQUlOID0gYmx1ZXotdXRpbHMNCg0KIyBUaGVzZSB0
d28gdmFyaWFibGVzIGRlcGVuZCBvbiB0aGUgbG9jYXRpb24gb2YgdGhpcyBkaXJlY3RvcnkuDQpz
dWJkaXIgPSBwbw0KdG9wX2J1aWxkZGlyID0gLi4NCg0KIyBUaGVzZSBvcHRpb25zIGdldCBwYXNz
ZWQgdG8geGdldHRleHQuDQpYR0VUVEVYVF9PUFRJT05TID0gLS1rZXl3b3JkPV8gLS1rZXl3b3Jk
PU5fDQoNCiMgVGhpcyBpcyB0aGUgY29weXJpZ2h0IGhvbGRlciB0aGF0IGdldHMgaW5zZXJ0ZWQg
aW50byB0aGUgaGVhZGVyIG9mIHRoZQ0KIyAkKERPTUFJTikucG90IGZpbGUuICBTZXQgdGhpcyB0
byB0aGUgY29weXJpZ2h0IGhvbGRlciBvZiB0aGUgc3Vycm91bmRpbmcNCiMgcGFja2FnZS4gIChO
b3RlIHRoYXQgdGhlIG1zZ3N0ciBzdHJpbmdzLCBleHRyYWN0ZWQgZnJvbSB0aGUgcGFja2FnZSdz
DQojIHNvdXJjZXMsIGJlbG9uZyB0byB0aGUgY29weXJpZ2h0IGhvbGRlciBvZiB0aGUgcGFja2Fn
ZS4pICBUcmFuc2xhdG9ycyBhcmUNCiMgZXhwZWN0ZWQgdG8gdHJhbnNmZXIgdGhlIGNvcHlyaWdo
dCBmb3IgdGhlaXIgdHJhbnNsYXRpb25zIHRvIHRoaXMgcGVyc29uDQojIG9yIGVudGl0eSwgb3Ig
dG8gZGlzY2xhaW0gdGhlaXIgY29weXJpZ2h0LiAgVGhlIGVtcHR5IHN0cmluZyBzdGFuZHMgZm9y
DQojIHRoZSBwdWJsaWMgZG9tYWluOyBpbiB0aGlzIGNhc2UgdGhlIHRyYW5zbGF0b3JzIGFyZSBl
eHBlY3RlZCB0byBkaXNjbGFpbQ0KIyB0aGVpciBjb3B5cmlnaHQuDQpDT1BZUklHSFRfSE9MREVS
ID0gTWFyY2VsIEhvbHRtYW5uDQoNCiMgVGhpcyBpcyB0aGUgZW1haWwgYWRkcmVzcyBvciBVUkwg
dG8gd2hpY2ggdGhlIHRyYW5zbGF0b3JzIHNoYWxsIHJlcG9ydA0KIyBidWdzIGluIHRoZSB1bnRy
YW5zbGF0ZWQgc3RyaW5nczoNCiMgLSBTdHJpbmdzIHdoaWNoIGFyZSBub3QgZW50aXJlIHNlbnRl
bmNlcywgc2VlIHRoZSBtYWludGFpbmVyIGd1aWRlbGluZXMNCiMgICBpbiB0aGUgR05VIGdldHRl
eHQgZG9jdW1lbnRhdGlvbiwgc2VjdGlvbiAnUHJlcGFyaW5nIFN0cmluZ3MnLg0KIyAtIFN0cmlu
Z3Mgd2hpY2ggdXNlIHVuY2xlYXIgdGVybXMgb3IgcmVxdWlyZSBhZGRpdGlvbmFsIGNvbnRleHQg
dG8gYmUNCiMgICB1bmRlcnN0b29kLg0KIyAtIFN0cmluZ3Mgd2hpY2ggbWFrZSBpbnZhbGlkIGFz
c3VtcHRpb25zIGFib3V0IG5vdGF0aW9uIG9mIGRhdGUsIHRpbWUgb3INCiMgICBtb25leS4NCiMg
LSBQbHVyYWxpc2F0aW9uIHByb2JsZW1zLg0KIyAtIEluY29ycmVjdCBFbmdsaXNoIHNwZWxsaW5n
Lg0KIyAtIEluY29ycmVjdCBmb3JtYXR0aW5nLg0KIyBJdCBjYW4gYmUgeW91ciBlbWFpbCBhZGRy
ZXNzLCBvciBhIG1haWxpbmcgbGlzdCBhZGRyZXNzIHdoZXJlIHRyYW5zbGF0b3JzDQojIGNhbiB3
cml0ZSB0byB3aXRob3V0IGJlaW5nIHN1YnNjcmliZWQsIG9yIHRoZSBVUkwgb2YgYSB3ZWIgcGFn
ZSB0aHJvdWdoDQojIHdoaWNoIHRoZSB0cmFuc2xhdG9ycyBjYW4gY29udGFjdCB5b3UuDQpNU0dJ
RF9CVUdTX0FERFJFU1MgPSBibHVlei1kZXZlbEBsaXN0cy5zZi5uZXQNCg0KIyBUaGlzIGlzIHRo
ZSBsaXN0IG9mIGxvY2FsZSBjYXRlZ29yaWVzLCBiZXlvbmQgTENfTUVTU0FHRVMsIGZvciB3aGlj
aCB0aGUNCiMgbWVzc2FnZSBjYXRhbG9ncyBzaGFsbCBiZSB1c2VkLiAgSXQgaXMgdXN1YWxseSBl
bXB0eS4NCkVYVFJBX0xPQ0FMRV9DQVRFR09SSUVTID0NCg==


--=-uAk1kXpMMgdI+BSBmnlm
Content-Disposition: attachment; filename=POTFILES.in
Content-Type: text/plain; name=POTFILES.in; charset=UTF-8
Content-Transfer-Encoding: base64

aGNpZC9kYnVzLXNlcnZpY2UuYw0K


--=-uAk1kXpMMgdI+BSBmnlm
Content-Disposition: attachment; filename=bluez-utils-po.diff
Content-Type: text/x-patch; name=bluez-utils-po.diff; charset=utf-8
Content-Transfer-Encoding: base64

SW5kZXg6IE1ha2VmaWxlLmFtDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2c3Jvb3QvYmx1ZXov
dXRpbHMvTWFrZWZpbGUuYW0sdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjQyDQpkaWZmIC1yMS40
MiBNYWtlZmlsZS5hbQ0KNWM1LDkNCjwgCQljdXBzIHRlc3Qgc2NyaXB0cw0KLS0tDQo+IAkJY3Vw
cyB0ZXN0IHNjcmlwdHMgcG8NCj4gDQo+IEFDTE9DQUxfQU1GTEFHUyA9IC1JIG00DQo+IA0KPiBF
WFRSQV9ESVNUID0gY29uZmlnLnJwYXRoDQpJbmRleDogYm9vdHN0cmFwDQo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpS
Q1MgZmlsZTogL2N2c3Jvb3QvYmx1ZXovdXRpbHMvYm9vdHN0cmFwLHYNCnJldHJpZXZpbmcgcmV2
aXNpb24gMS43DQpkaWZmIC1yMS43IGJvb3RzdHJhcA0KM2E0DQo+ICAgICBhdXRvcG9pbnQgLS1m
b3JjZSAmJiBcDQpJbmRleDogY29uZmlndXJlLmluDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2
c3Jvb3QvYmx1ZXovdXRpbHMvY29uZmlndXJlLmluLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS4x
NDINCmRpZmYgLXIxLjE0MiBjb25maWd1cmUuaW4NCjRjNCw1DQo8IEFNX0lOSVRfQVVUT01BS0Uo
Ymx1ZXotdXRpbHMsIDMuMzEpDQotLS0NCj4gUEFDS0FHRT1ibHVlei11dGlscw0KPiBBTV9JTklU
X0FVVE9NQUtFKCRQQUNLQUdFLCAzLjMxKQ0KMzhhNDAsNDUNCj4gR0VUVEVYVF9QQUNLQUdFPSRQ
QUNLQUdFDQo+IEFDX0RFRklORV9VTlFVT1RFRChHRVRURVhUX1BBQ0tBR0UsIFsiJEdFVFRFWFRf
UEFDS0FHRSJdLCBbRGVmaW5lIHRvIHRoZSBHZXR0ZXh0IHBhY2thZ2UgbmFtZV0pDQo+IEFDX1NV
QlNUKEdFVFRFWFRfUEFDS0FHRSkNCj4gQU1fR05VX0dFVFRFWFQoW2V4dGVybmFsXSkNCj4gQU1f
R05VX0dFVFRFWFRfVkVSU0lPTihbMC4xN10pDQo+IA0KNjJhNzANCj4gCXBvL01ha2VmaWxlLmlu
DQpJbmRleDogZWdsaWIvTWFrZWZpbGUuYW0NCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJDUyBmaWxlOiAvY3Zzcm9v
dC9ibHVlei91dGlscy9lZ2xpYi9NYWtlZmlsZS5hbSx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEu
Mw0KZGlmZiAtcjEuMyBNYWtlZmlsZS5hbQ0KMWQwDQo8IA0KNWE1DQo+IEVYVFJBX0RJU1QgPSBn
bGliL2dpMThuLmgNCkluZGV4OiBoY2lkL2RidXMtc2VydmljZS5jDQo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1Mg
ZmlsZTogL2N2c3Jvb3QvYmx1ZXovdXRpbHMvaGNpZC9kYnVzLXNlcnZpY2UuYyx2DQpyZXRyaWV2
aW5nIHJldmlzaW9uIDEuMTU2DQpkaWZmIC1yMS4xNTYgZGJ1cy1zZXJ2aWNlLmMNCjQ0YTQ1DQo+
ICNpbmNsdWRlIDxnbGliL2dpMThuLmg+DQo1ODZjNTg3DQo8IAkJbmFtZSA9ICJJbnB1dCBzZXJ2
aWNlIjsNCi0tLQ0KPiAJCW5hbWUgPSBfKCJJbnB1dCBzZXJ2aWNlIik7DQo1ODhjNTg5DQo8IAkJ
bmFtZSA9ICJBdWRpbyBzZXJ2aWNlIjsNCi0tLQ0KPiAJCW5hbWUgPSBfKCJBdWRpbyBzZXJ2aWNl
Iik7DQo1OTBjNTkxDQo8IAkJbmFtZSA9ICJOZXR3b3JrIHNlcnZpY2UiOw0KLS0tDQo+IAkJbmFt
ZSA9IF8oIk5ldHdvcmsgc2VydmljZSIpOw0KNTkyYzU5Mw0KPCAJCW5hbWUgPSAiU2VyaWFsIHNl
cnZpY2UiOw0KLS0tDQo+IAkJbmFtZSA9IF8oIlNlcmlhbCBzZXJ2aWNlIik7DQo=


--=-uAk1kXpMMgdI+BSBmnlm--

--=-Anua7pjmRkbLRNNagGhz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBINBwe53i2YxNrdi0RAhYUAKCwI+i6cAJHxFyGUkrd+jeMhIkHagCgkJp5
mMB1S7Ne82oVCBd0hsxfixk=
=WAMH
-----END PGP SIGNATURE-----

--=-Anua7pjmRkbLRNNagGhz--



--===============0121516963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0121516963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0121516963==--
