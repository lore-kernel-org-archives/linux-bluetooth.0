Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C89736.27DD7C6C"
Date: Sat, 5 Apr 2008 10:58:34 -0500
Message-ID: <E6FF208A16840D4EBAA31D261B15A506F29F16@ausx3mpc121.aus.amer.dell.com>
References: <1207335282.19116.5.camel@mlimonciello><1207341998.32219.1.camel@mlimonciello>
	<1207351025.13201.328.camel@cookie.hadess.net>
From: <Mario_Limonciello@Dell.com>
To: <bluez-devel@lists.sourceforge.net>,
	<bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Add HID->HCI switching support
	fornewer	Dell BT cards
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C89736.27DD7C6C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Bastien,

I'll be glad to update the coding style to match the rest of the source. =
 Please see the updated attachment.  Both of these adapters are just =
bluetooth cards that ship on the laptop, not the dongles that come with =
a keyboard or mouse.

This is the way the cards function in Windows, and the way that they =
were intended to function.  When paired with a HID keyboard and/or =
mouse, they have the ability to store that pairing in the firmware.  =
That's why they have the two modes.

In reading your question, do you have a problem with a particular mouse =
&/or keyboard combo that the dongle isn't working 'out of the box'?

Regards,

Mario Limonciello=20
Dell | Linux Engineering=20
Desk : (512) 723-0582=20
Mario_Limonciello@Dell.com=20



-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net on behalf of Bastien =
Nocera
Sent: Fri 4/4/2008 6:17 PM
To: BlueZ development
Subject: Re: [Bluez-devel] [PATCH] Add HID->HCI switching support =
fornewer	Dell BT cards
=20

On Fri, 2008-04-04 at 15:46 -0500, Mario_Limonciello@Dell.com wrote:
> Hi,
>=20
> As it turns out, this also works for the Dell 410 series cards.
> Attached is an updated patch to include them.

Only problems I could see with the patch is the coding style (C++-style
comments, braces on different lines for a condition, alignment of
arguments to a function when on multiple lines).

The rest of the code looks fine to me.

Are those adapters usually shipped with keyboards and mice, so that they
would need to stay in HID mode on startup?

If they do, do you have any code available that would make sure this
keyboard and mouse are registered in BlueZ so they work "out of the
box"?


-------------------------------------------------------------------------=

This SF.net email is sponsored by the 2008 JavaOne(SM) Conference=20
Register now and save $200. Hurry, offer ends at 11:59 p.m.,=20
Monday, April 7! Use priority code J8TLD2.=20
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/ja=
vaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel



------_=_NextPart_001_01C89736.27DD7C6C
Content-Type: application/octet-stream;
	name="patch"
Content-Transfer-Encoding: base64
Content-Description: patch
Content-Disposition: attachment;
	filename="patch"

LS0tIGJsdWV6LXV0aWxzLTMuMjYvdG9vbHMvaGlkMmhjaS5jCTIwMDgtMDItMDEgMTc6MTY6MzQu
MDAwMDAwMDAwIC0wNjAwCisrKyBoaWQyaGNpLmMJMjAwOC0wNC0wNSAxMDo1NzoxNy4wMDAwMDAw
MDAgLTA1MDAKQEAgLTIxMSw2ICsyMTEsNDEgQEAKIAlyZXR1cm4gZXJyOwogfQogCitzdGF0aWMg
aW50IHN3aXRjaF9kZWxsKHN0cnVjdCBkZXZpY2VfaW5mbyAqZGV2aW5mbykKK3sKKwljaGFyIHJl
cG9ydFtdID0geyAweDdGLCAweDEzLCAweDAwLCAweDAwfTsKKworCXN0cnVjdCB1c2JfZGV2X2hh
bmRsZSAqaGFuZGxlOworCWludCBlcnI7CisKKwkvKiByZWxlYXNlIGFueSBsb2NrcyB0aGF0IHRo
ZSBrZXJuZWwgbWF5IGhhdmUgb24gdGhpcyBkZXZpY2UgKi8KKwloYW5kbGUgPSB1c2Jfb3Blbihk
ZXZpbmZvLT5kZXYpOworCWlmIChoYW5kbGUpIHsKKwkJdXNiX2NsYWltX2ludGVyZmFjZShoYW5k
bGUsIDApOworCQl1c2JfZGV0YWNoX2tlcm5lbF9kcml2ZXJfbnAoaGFuZGxlLDApOworCX0KKwor
CS8qIHN3aXRjaCBkZXZpY2UgbW9kZXMgKi8KKwllcnIgPSB1c2JfY29udHJvbF9tc2coaGFuZGxl
LAorCQkJCVVTQl9FTkRQT0lOVF9PVVQgKyBVU0JfVFlQRV9DTEFTUyArIFVTQl9SRUNJUF9JTlRF
UkZBQ0UsCisJCQkJMHgwOSwKKwkJCQkweDdmICsgKDB4MDMgPDwgOCksCisJCQkJMCwKKwkJCQko
Y2hhciopcmVwb3J0LCA0LCAxMDAwMCk7CisKKwlpZiAoZXJyID09IDApIHsKKwkJZXJyID0gLTE7
CisJCWVycm5vID0gRUFMUkVBRFk7CisJfSBlbHNlIHsKKwkJaWYgKGVycm5vID09IEVUSU1FRE9V
VCkKKwkJCWVyciA9IDA7CisJfQorCisJdXNiX2Nsb3NlKGhhbmRsZSk7CisKKwlyZXR1cm4gZXJy
OworfQorCiBzdGF0aWMgc3RydWN0IGRldmljZV9pZCBkZXZpY2VfbGlzdFtdID0gewogCXsgSENJ
LCAweDBhMTIsIDB4MTAwMCwgc3dpdGNoX2hpZHByb3h5IH0sCiAJeyBISUQsIDB4MGExMiwgMHgw
MDAxLCBzd2l0Y2hfaGlkcHJveHkgfSwKQEAgLTIyOSw2ICsyNjQsOCBAQAogCXsgSENJLCAweDA0
NmQsIDB4YzcwZSwgc3dpdGNoX2xvZ2l0ZWNoIH0sCS8qIExvZ2l0ZWNoIGRpTm92byBrZXlib2Fy
ZCAqLwogCXsgSENJLCAweDA0NmQsIDB4YzcxMywgc3dpdGNoX2xvZ2l0ZWNoIH0sCS8qIExvZ2l0
ZWNoIGRpTm92byBFZGdlICovCiAJeyBIQ0ksIDB4MDQ2ZCwgMHhjNzE0LCBzd2l0Y2hfbG9naXRl
Y2ggfSwJLyogTG9naXRlY2ggZGlOb3ZvIEVkZ2UgKi8KKwl7IEhDSSwgMHg0MTNjLCAweDgxNTgs
IHN3aXRjaF9kZWxsIH0sCQkvKiBEZWxsIFdpcmVsZXNzIDM3MCAqLworCXsgSENJLCAweDQxM2Ms
IDB4ODE1NCwgc3dpdGNoX2RlbGwgfSwJCS8qIERlbGwgV2lyZWxlc3MgNDEwICovCiAJeyAtMSB9
CiB9OwogCg==

------_=_NextPart_001_01C89736.27DD7C6C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
------_=_NextPart_001_01C89736.27DD7C6C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C89736.27DD7C6C--
