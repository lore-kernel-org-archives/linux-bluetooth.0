Return-Path: <cyrus@holtmann.org>
Message-ID: <8a8adccc0712161246y3f435aefwdb6c92c464d19f96@mail.gmail.com>
Date: Sun, 16 Dec 2007 21:46:07 +0100
From: "Jaap A. Haitsma" <jaap@haitsma.org>
Sender: jaap.haitsma@gmail.com
To: "Marcel Holtmann" <marcel@holtmann.org>, bluez-devel@lists.sourceforge.net
Subject: [PATCH] Bluez build system
In-Reply-To: <1188768824.24968.9.camel@violet>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_10482_19462417.1197837967254"
References: <8a8adccc0709020615m38389d6axe49041f8fbe18c4b@mail.gmail.com>
	 <1188768824.24968.9.camel@violet>
List-ID: <bluez-devel.lists.sourceforge.net>

------=_Part_10482_19462417.1197837967254
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

With a couple of months delay but here it is.

Attached you find autogen.sh. Just put this file in the gnome
directory of bluez and gnome-bluetooth can be build with jhbuild. NOTE
you need to have the package gnome-common installed. gnome-common
contains common scripts and macros to make developing GNOME apps
easier

The files bootstrap and bootstrap-configure can be removed because
autogen.sh is now doing that job.

Jaap



On Sep 2, 2007 10:33 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jaap,
>
> > I was looking into bluez and noticed that you don't use the standard
> > autogen.sh way to build your the bluez programs. I noticed this when
> > trying to add bluez-gnome to jhbuild [1].
> >
> > I wouldn't mind writing the patch so that at least the gnome part uses
> > the standard way that GNOME builds modules. I'd like to know if you
> > accept such a patch.
>
> post a patch to the bluez-devel mailing list and I take a look at it.
> Never used jhbuild before.
>
> > BTW I noticed that mailing lists contains a lot of SPAM. Is there
> > anything you can do about that? I'd like to contribute to bluez now
> > and then and follow the devel discussions but I don't like the SPAM
>
> Take this up with the Sourceforge.net admins. It is totally their fault.
> For me my spam filters catch most of it.
>
> Regards
>
> Marcel
>
>
>

------=_Part_10482_19462417.1197837967254
Content-Type: application/x-sh; name=autogen.sh
Content-Transfer-Encoding: base64
X-Attachment-Id: f_faa1rxfj0
Content-Disposition: attachment; filename=autogen.sh

IyEvYmluL3NoCiMgUnVuIHRoaXMgdG8gZ2VuZXJhdGUgYWxsIHRoZSBpbml0aWFsIG1ha2VmaWxl
cywgZXRjLgoKc3JjZGlyPWBkaXJuYW1lICQwYAp0ZXN0IC16ICIkc3JjZGlyIiAmJiBzcmNkaXI9
LgoKUEtHX05BTUU9Imdub21lLWJsdWV0b290aCIKCih0ZXN0IC1mICRzcmNkaXIvYXBwbGV0L21h
aW4uYykgfHwgewogICAgZWNobyAtbiAiKipFcnJvcioqOiBEaXJlY3RvcnkgIlxgJHNyY2Rpclwn
IiBkb2VzIG5vdCBsb29rIGxpa2UgdGhlIgogICAgZWNobyAiIHRvcC1sZXZlbCAkUEtHX05BTUUg
ZGlyZWN0b3J5IgogICAgZXhpdCAxCn0KCndoaWNoIGdub21lLWF1dG9nZW4uc2ggfHwgewogICAg
ZWNobyAiWW91IG5lZWQgdG8gaW5zdGFsbCBnbm9tZS1jb21tb24gZnJvbSB0aGUgR05PTUUgU1ZO
IgogICAgZXhpdCAxCn0KClJFUVVJUkVEX0FVVE9DT05GX1ZFUlNJT049Mi41NwpSRVFVSVJFRF9B
VVRPTUFLRV9WRVJTSU9OPTEuNwpSRVFVSVJFRF9JTlRMVE9PTF9WRVJTSU9OPTAuMzUuMApSRVFV
SVJFRF9QS0dfQ09ORklHX1ZFUlNJT049MC4xNi4wClVTRV9HTk9NRTJfTUFDUk9TPTEgVVNFX0NP
TU1PTl9ET0NfQlVJTEQ9eWVzIC4gZ25vbWUtYXV0b2dlbi5zaAo=
------=_Part_10482_19462417.1197837967254--
