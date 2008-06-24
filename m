Return-Path: <cyrus@holtmann.org>
From: Antti =?ISO-8859-1?Q?Kaijanm=E4ki?= <antti@kaijanmaki.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Tue, 24 Jun 2008 15:21:28 +0300
Message-Id: <1214310088.6643.87.camel@peura.elisa-laajakaista.fi>
Mime-Version: 1.0
Subject: [Bluez-devel] Making library out of bluez-gnome
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0008920927=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0008920927==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-1pIUQKiYWb6CxCEBJFcg"


--=-1pIUQKiYWb6CxCEBJFcg
Content-Type: multipart/mixed; boundary="=-dgP0dpUssFmvazj160u/"


--=-dgP0dpUssFmvazj160u/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello list!

I'm developing a project[1] that needs to provide the user a way to
select=EF=BB=BF[2] a Bluetooth device from a list of discovered devices.

I noticed that gnome-bluez applet has a very nice device selector and
that got me browsing though the code. Unfortunately I discovered that
bluez-gnome creates only a static library libcommon.a that contains the
device selector (common/bluetooth-device-selection.c) for private use.

Now there is two options the way I see it. Either I have a private copy
of bluez-gnome package or bluez-gnome is made to be a shared library.

The first solution would be easiest for everyone because no extra work
would be required. But it's just generally A Bad Idea to have multiple
programs using same code privately and so on..

The second solutions would be optimal. If bluez-gnome provides a shared
library 3rd party software could utilize it in sane way. I'm quite sure
there are many applications that would benefit from common bluetooth
widgets; like CUPS for bluetooth printer setup, Evolution for vCard
sending, <your favorite application that communicates with BT devices>..

Here is the lame part: I'm busy with my project, so someone else should
do all the work :P
OK, maybe not all the work, but I can not promise anything.

What do you think about the idea? Is this something not worth the
trouble and I should just STFU or is this viable?

best regards,
Antti Kaijanm=C3=A4ki

=EF=BB=BF[1] http://live.gnome.org/NetworkManager/MobileBroadband
[2] http://www.kaijanmaki.net/kesakoodi/bt_draft.png


P.S.
Here are some wishes from top of my head regarding the device selector:
 1. remove the caption of the list
    - let the developer provide a caption best suited for
      his application
 2. put the filter in GtkExpander
    - Filters are not used for by the most of the users, thus it's
      convenient to have them hidden by default.=20
 3. make the filter completely hidden
   - this combined with the 1. would make the widget appear just
     like GtkTreeView
   - this is already achievable, but there seems to be a bug. If both of
     the filter fields are hidden the caption is still shown.
     See an attached patch.
 4. have alternative filters in right-click pop-up menu
    - very handy for tight places
 5. add property for selected device name. It's always nice to be able
    to show the user a nice name instead of bluetooth address.
    - see an attached patch.

--=-dgP0dpUssFmvazj160u/
Content-Disposition: attachment;
	filename=add_selected_device_name_property.patch
Content-Type: text/x-patch; name=add_selected_device_name_property.patch;
	charset=UTF-8
Content-Transfer-Encoding: base64

SW5kZXg6IGNvbW1vbi9ibHVldG9vdGgtZGV2aWNlLXNlbGVjdGlvbi5jDQo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpS
Q1MgZmlsZTogL2N2c3Jvb3QvYmx1ZXovZ25vbWUvY29tbW9uL2JsdWV0b290aC1kZXZpY2Utc2Vs
ZWN0aW9uLmMsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjIwDQpkaWZmIC11IC1wIC1yMS4yMCBi
bHVldG9vdGgtZGV2aWNlLXNlbGVjdGlvbi5jDQotLS0gY29tbW9uL2JsdWV0b290aC1kZXZpY2Ut
c2VsZWN0aW9uLmMJMTIgTWFyIDIwMDggMjE6MDM6MzggLTAwMDAJMS4yMA0KKysrIGNvbW1vbi9i
bHVldG9vdGgtZGV2aWNlLXNlbGVjdGlvbi5jCTI0IEp1biAyMDA4IDExOjU3OjAxIC0wMDAwDQpA
QCAtMjA3LDYgKzIwNywyMiBAQCBibHVldG9vdGhfZGV2aWNlX3NlbGVjdGlvbl9nZXRfc2VsZWN0
ZWRfDQogCXJldHVybiBhZGRyZXNzOw0KIH0NCiANCitnY2hhciAqDQorYmx1ZXRvb3RoX2Rldmlj
ZV9zZWxlY3Rpb25fZ2V0X3NlbGVjdGVkX2RldmljZV9uYW1lIChCbHVldG9vdGhEZXZpY2VTZWxl
Y3Rpb24gKnNlbGYpDQorew0KKwlCbHVldG9vdGhEZXZpY2VTZWxlY3Rpb25Qcml2YXRlICpwcml2
ID0gQkxVRVRPT1RIX0RFVklDRV9TRUxFQ1RJT05fR0VUX1BSSVZBVEUoc2VsZik7DQorCUd0a1Ry
ZWVJdGVyIGl0ZXI7DQorCWdjaGFyICpuYW1lOw0KKwlnYm9vbGVhbiBzZWxlY3RlZDsNCisNCisJ
c2VsZWN0ZWQgPSBndGtfdHJlZV9zZWxlY3Rpb25fZ2V0X3NlbGVjdGVkIChwcml2LT5zZWxlY3Rp
b24sIE5VTEwsICZpdGVyKTsNCisJaWYgKHNlbGVjdGVkID09IEZBTFNFKQ0KKwkJcmV0dXJuIE5V
TEw7DQorDQorCWd0a190cmVlX21vZGVsX2dldCAocHJpdi0+ZmlsdGVyLCAmaXRlciwgQ09MVU1O
X05BTUUsICZuYW1lLCAtMSk7DQorCXJldHVybiBuYW1lOw0KK30NCisNCiBzdGF0aWMgdm9pZA0K
IHNlYXJjaF9idXR0b25fY2xpY2tlZCAoR3RrQnV0dG9uICpidXR0b24sIGdwb2ludGVyIHVzZXJf
ZGF0YSkNCiB7DQpAQCAtNjE3LDYgKzYzMyw3IEBAIGVudW0gew0KIAlQUk9QXzAsDQogCVBST1Bf
VElUTEUsDQogCVBST1BfREVWSUNFX1NFTEVDVEVELA0KKwlQUk9QX0RFVklDRV9TRUxFQ1RFRF9O
QU1FLA0KIAlQUk9QX1NIT1dfQk9ORElORywNCiAJUFJPUF9TSE9XX1NFQVJDSCwNCiAJUFJPUF9T
SE9XX0RFVklDRV9UWVBFLA0KQEAgLTY4OCw2ICs3MDUsOSBAQCBibHVldG9vdGhfZGV2aWNlX3Nl
bGVjdGlvbl9nZXRfcHJvcGVydHkgDQogCWNhc2UgUFJPUF9ERVZJQ0VfU0VMRUNURUQ6DQogCQln
X3ZhbHVlX3NldF9zdHJpbmcgKHZhbHVlLCBibHVldG9vdGhfZGV2aWNlX3NlbGVjdGlvbl9nZXRf
c2VsZWN0ZWRfZGV2aWNlIChzZWxmKSk7DQogCQlicmVhazsNCisJY2FzZSBQUk9QX0RFVklDRV9T
RUxFQ1RFRF9OQU1FOg0KKwkJZ192YWx1ZV9zZXRfc3RyaW5nICh2YWx1ZSwgYmx1ZXRvb3RoX2Rl
dmljZV9zZWxlY3Rpb25fZ2V0X3NlbGVjdGVkX2RldmljZV9uYW1lIChzZWxmKSk7DQorCQlicmVh
azsNCiAJY2FzZSBQUk9QX1NIT1dfQk9ORElORzoNCiAJCWdfdmFsdWVfc2V0X2Jvb2xlYW4gKHZh
bHVlLCBwcml2LT5zaG93X2JvbmRlZCk7DQogCQlicmVhazsNCkBAIC03MzgsNiArNzU4LDkgQEAg
Ymx1ZXRvb3RoX2RldmljZV9zZWxlY3Rpb25fY2xhc3NfaW5pdCAoQg0KIAkJCQkJIFBST1BfREVW
SUNFX1NFTEVDVEVELCBnX3BhcmFtX3NwZWNfc3RyaW5nICgiZGV2aWNlLXNlbGVjdGVkIiwNCiAJ
CQkJCQkJCQkJICAgIE5VTEwsIE5VTEwsIE5VTEwsIEdfUEFSQU1fUkVBREFCTEUpKTsNCiAJZ19v
YmplY3RfY2xhc3NfaW5zdGFsbF9wcm9wZXJ0eSAoR19PQkpFQ1RfQ0xBU1Moa2xhc3MpLA0KKwkJ
CQkJIFBST1BfREVWSUNFX1NFTEVDVEVEX05BTUUsIGdfcGFyYW1fc3BlY19zdHJpbmcgKCJkZXZp
Y2Utc2VsZWN0ZWQtbmFtZSIsDQorCQkJCQkJCQkJCSAgICBOVUxMLCBOVUxMLCBOVUxMLCBHX1BB
UkFNX1JFQURBQkxFKSk7DQorCWdfb2JqZWN0X2NsYXNzX2luc3RhbGxfcHJvcGVydHkgKEdfT0JK
RUNUX0NMQVNTKGtsYXNzKSwNCiAJCQkJCSBQUk9QX1NIT1dfQk9ORElORywgZ19wYXJhbV9zcGVj
X2Jvb2xlYW4gKCJzaG93LWJvbmRpbmciLA0KIAkJCQkJCQkJCQkgIE5VTEwsIE5VTEwsIEZBTFNF
LCBHX1BBUkFNX1JFQURXUklURSkpOw0KIAlnX29iamVjdF9jbGFzc19pbnN0YWxsX3Byb3BlcnR5
IChHX09CSkVDVF9DTEFTUyhrbGFzcyksDQo=


--=-dgP0dpUssFmvazj160u/
Content-Disposition: attachment;
	filename=hide_filters_box_when_not_needed.patch
Content-Type: text/x-patch; name=hide_filters_box_when_not_needed.patch;
	charset=UTF-8
Content-Transfer-Encoding: base64

SW5kZXg6IGNvbW1vbi9ibHVldG9vdGgtZGV2aWNlLXNlbGVjdGlvbi5jDQo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpS
Q1MgZmlsZTogL2N2c3Jvb3QvYmx1ZXovZ25vbWUvY29tbW9uL2JsdWV0b290aC1kZXZpY2Utc2Vs
ZWN0aW9uLmMsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjIwDQpkaWZmIC11IC1wIC1yMS4yMCBi
bHVldG9vdGgtZGV2aWNlLXNlbGVjdGlvbi5jDQotLS0gY29tbW9uL2JsdWV0b290aC1kZXZpY2Ut
c2VsZWN0aW9uLmMJMTIgTWFyIDIwMDggMjE6MDM6MzggLTAwMDAJMS4yMA0KKysrIGNvbW1vbi9i
bHVldG9vdGgtZGV2aWNlLXNlbGVjdGlvbi5jCTI0IEp1biAyMDA4IDExOjUwOjAxIC0wMDAwDQpA
QCAtNjIsNiArNjIsNyBAQCBzdHJ1Y3QgX0JsdWV0b290aERldmljZVNlbGVjdGlvblByaXZhdGUg
DQogCUd0a1dpZGdldCAqc2VhcmNoX2J1dHRvbjsNCiAJR3RrV2lkZ2V0ICpkZXZpY2VfdHlwZV9s
YWJlbCwgKmRldmljZV90eXBlOw0KIAlHdGtXaWRnZXQgKmRldmljZV9jYXRlZ29yeV9sYWJlbCwg
KmRldmljZV9jYXRlZ29yeTsNCisJR3RrV2lkZ2V0ICpmaWx0ZXJzX3Zib3g7DQogDQogCS8qIEN1
cnJlbnQgZmlsdGVyICovDQogCWludCBkZXZpY2VfdHlwZV9maWx0ZXI7DQpAQCAtNTE3LDcgKzUz
NCw4IEBAIGJsdWV0b290aF9kZXZpY2Vfc2VsZWN0aW9uX2luaXQoQmx1ZXRvb3QNCiAJdmJveCA9
IGd0a192Ym94X25ldyAoRkFMU0UsIDYpOw0KIAlndGtfd2lkZ2V0X3Nob3cgKHZib3gpOw0KIAln
dGtfYm94X3BhY2tfc3RhcnQgKEdUS19CT1ggKHNlbGYpLCB2Ym94LCBGQUxTRSwgVFJVRSwgMCk7
DQotDQorCXByaXYtPmZpbHRlcnNfdmJveCA9IHZib3g7DQorCQ0KIAkvKiBUaGUgZmlsdGVycyAq
Lw0KIAlzdHIgPSBnX3N0cmR1cF9wcmludGYgKCI8Yj4lczwvYj4iLCBfKCJTaG93IE9ubHkgQmx1
ZXRvb3RoIERldmljZXMgV2l0aC4uLiIpKTsNCiAJbGFiZWwgPSBndGtfbGFiZWxfbmV3IChzdHIp
Ow0KQEAgLTU5Niw3ICs2MTQsMTMgQEAgYmx1ZXRvb3RoX2RldmljZV9zZWxlY3Rpb25faW5pdChC
bHVldG9vdA0KIAkJZ3RrX3dpZGdldF9zaG93IChwcml2LT5kZXZpY2VfdHlwZV9sYWJlbCk7DQog
CQlndGtfd2lkZ2V0X3Nob3cgKHByaXYtPmRldmljZV90eXBlKTsNCiAJfQ0KLQ0KKwkNCisJLyog
aWYgZmlsdGVycyBhcmUgbm90IHZpc2libGUgaGlkZSB0aGUgdmJveCAqLw0KKwlpZiAoIXByaXYt
PnNob3dfZGV2aWNlX3R5cGUgJiYgIXByaXYtPnNob3dfZGV2aWNlX2NhdGVnb3J5KQ0KKwl7DQor
CQlndGtfd2lkZ2V0X2hpZGUgKHByaXYtPmZpbHRlcnNfdmJveCk7DQorCX0NCisJDQogCXByaXYt
PmRlZmF1bHRfYWRhcHRlcl9jaGFuZ2VkX2lkID0gZ19zaWduYWxfY29ubmVjdCAocHJpdi0+Y2xp
ZW50LCAibm90aWZ5OjpkZWZhdWx0LWFkYXB0ZXIiLA0KIAkJCQkJCQkgICAgIEdfQ0FMTEJBQ0sg
KGRlZmF1bHRfYWRhcHRlcl9jaGFuZ2VkKSwgc2VsZik7DQogfQ0KQEAgLTY1NywxMSArNjgyLDE5
IEBAIGJsdWV0b290aF9kZXZpY2Vfc2VsZWN0aW9uX3NldF9wcm9wZXJ0eSANCiAJCXByaXYtPnNo
b3dfZGV2aWNlX3R5cGUgPSBnX3ZhbHVlX2dldF9ib29sZWFuICh2YWx1ZSk7DQogCQlnX29iamVj
dF9zZXQgKEdfT0JKRUNUIChwcml2LT5kZXZpY2VfdHlwZV9sYWJlbCksICJ2aXNpYmxlIiwgcHJp
di0+c2hvd19kZXZpY2VfdHlwZSwgTlVMTCk7DQogCQlnX29iamVjdF9zZXQgKEdfT0JKRUNUIChw
cml2LT5kZXZpY2VfdHlwZSksICJ2aXNpYmxlIiwgcHJpdi0+c2hvd19kZXZpY2VfdHlwZSwgTlVM
TCk7DQorCQlpZiAocHJpdi0+c2hvd19kZXZpY2VfdHlwZSB8fCBwcml2LT5zaG93X2RldmljZV9j
YXRlZ29yeSkNCisJCQlnX29iamVjdF9zZXQgKEdfT0JKRUNUIChwcml2LT5maWx0ZXJzX3Zib3gp
LCAidmlzaWJsZSIsIFRSVUUsIE5VTEwpOw0KKwkJZWxzZQ0KKwkJCWdfb2JqZWN0X3NldCAoR19P
QkpFQ1QgKHByaXYtPmZpbHRlcnNfdmJveCksICJ2aXNpYmxlIiwgRkFMU0UsIE5VTEwpOw0KIAkJ
YnJlYWs7DQogCWNhc2UgUFJPUF9TSE9XX0RFVklDRV9DQVRFR09SWToNCiAJCXByaXYtPnNob3df
ZGV2aWNlX2NhdGVnb3J5ID0gZ192YWx1ZV9nZXRfYm9vbGVhbiAodmFsdWUpOw0KIAkJZ19vYmpl
Y3Rfc2V0IChHX09CSkVDVCAocHJpdi0+ZGV2aWNlX2NhdGVnb3J5X2xhYmVsKSwgInZpc2libGUi
LCBwcml2LT5zaG93X2RldmljZV9jYXRlZ29yeSwgTlVMTCk7DQogCQlnX29iamVjdF9zZXQgKEdf
T0JKRUNUIChwcml2LT5kZXZpY2VfY2F0ZWdvcnkpLCAidmlzaWJsZSIsIHByaXYtPnNob3dfZGV2
aWNlX2NhdGVnb3J5LCBOVUxMKTsNCisJCWlmIChwcml2LT5zaG93X2RldmljZV90eXBlIHx8IHBy
aXYtPnNob3dfZGV2aWNlX2NhdGVnb3J5KQ0KKwkJCWdfb2JqZWN0X3NldCAoR19PQkpFQ1QgKHBy
aXYtPmZpbHRlcnNfdmJveCksICJ2aXNpYmxlIiwgVFJVRSwgTlVMTCk7DQorCQllbHNlDQorCQkJ
Z19vYmplY3Rfc2V0IChHX09CSkVDVCAocHJpdi0+ZmlsdGVyc192Ym94KSwgInZpc2libGUiLCBG
QUxTRSwgTlVMTCk7DQogCQlicmVhazsNCiAJY2FzZSBQUk9QX0RFVklDRV9UWVBFX0ZJTFRFUjoN
CiAJCXByaXYtPmRldmljZV90eXBlX2ZpbHRlciA9IGdfdmFsdWVfZ2V0X2ludCAodmFsdWUpOw0K



--=-dgP0dpUssFmvazj160u/--

--=-1pIUQKiYWb6CxCEBJFcg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digitaalisesti allekirjoitettu viestin osa

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIYObHxyyCWWVycu8RAmxBAKCc0UNiZ+jr8aqzWrOOZTyyYDcFvQCfbo4k
0lX4RK3G4RUf6CdrtuGYhYc=
=lBB4
-----END PGP SIGNATURE-----

--=-1pIUQKiYWb6CxCEBJFcg--



--===============0008920927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============0008920927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0008920927==--
