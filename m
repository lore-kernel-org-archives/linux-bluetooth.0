Return-Path: <cyrus@holtmann.org>
Message-ID: <8a8adccc0712181417n6c0b5052i4e37137c24748a6a@mail.gmail.com>
Date: Tue, 18 Dec 2007 23:17:19 +0100
From: "Jaap A. Haitsma" <jaap@haitsma.org>
Sender: jaap.haitsma@gmail.com
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [PATCH] Bluez build system
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1197918404.8050.92.camel@aeonflux>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_23755_2175613.1198016239077"
References: <8a8adccc0709020615m38389d6axe49041f8fbe18c4b@mail.gmail.com>
	 <1188768824.24968.9.camel@violet>
	 <8a8adccc0712161246y3f435aefwdb6c92c464d19f96@mail.gmail.com>
	 <1197841752.8050.42.camel@aeonflux>
	 <8a8adccc0712161449r135b552ct39f2cb9bcdeb543d@mail.gmail.com>
	 <1197853211.8050.55.camel@aeonflux>
	 <8a8adccc0712162252v4cabae88md549ef651cbef5ad@mail.gmail.com>
	 <1197918404.8050.92.camel@aeonflux>
List-ID: <bluez-devel.lists.sourceforge.net>

------=_Part_23755_2175613.1198016239077
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Dec 17, 2007 8:06 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Jaap,
>
> > > > > > With a couple of months delay but here it is.
> > > > > >
> > > > > > Attached you find autogen.sh. Just put this file in the gnome
> > > > > > directory of bluez and gnome-bluetooth can be build with jhbuild. NOTE
> > > > > > you need to have the package gnome-common installed. gnome-common
> > > > > > contains common scripts and macros to make developing GNOME apps
> > > > > > easier
> > > > >
> > > > > that is not gonna happen since even if it is called bluez-gnome, it can
> > > > > be build and used without GNOME. Its only dependency is GTK+. So
> > > > > depending on gnome-common is not an option.
> > > >
> > > > It's a build time dependency only. There is no run time dependency.
> > >
> > > I am making no difference in build or runtime dependency here. Every
> > > extra dependency is bad. Especially if they are useless.
> > >
> > > > > > The files bootstrap and bootstrap-configure can be removed because
> > > > > > autogen.sh is now doing that job.
> > > > >
> > > > > I actually like bootstrap and bootstrap-configure, because they do
> > > > > exactly the right job for the developers.
> > > > >
> > > > I'd like to have autogen.sh because then bluez gnome can get build with jhbuild
> > > > I then see two options
> > > > 1) Add autogen.sh as is and also leave the bootstrap files in CVS
> > > > 2) I'll need to hack up an autogen.sh which doesn't need gnome-common.
> > > > I'm not an autofoo expert but I guess that can be done
> > >
> > > Is it a modified autogen.sh or a standard one? Do it have to be inside
> > > the tarball or is CVS enough?
> > >
> > Just needs to be in CVS. It won't be part of the tarball. I guess it's
> > just a standard one, but as I said I'm not an expert at it. I'll look
> > into other projects which use autogen.sh but don't use gnome-common
>
> if it only will be in the CVS for jhbuild, then you don't have to modify
> anything. Simply make sure it is a really default one and I put it
> there.
>
New autogen.sh with no dependencies on gnome-common attached

Jaap

------=_Part_23755_2175613.1198016239077
Content-Type: application/x-sh; name=autogen.sh
Content-Transfer-Encoding: base64
X-Attachment-Id: f_faczwnvo0
Content-Disposition: attachment; filename=autogen.sh

IyEvYmluL3NoCiMgUnVuIHRoaXMgdG8gZ2VuZXJhdGUgYWxsIHRoZSBpbml0aWFsIG1ha2VmaWxl
cywgZXRjLgoKc3JjZGlyPWBkaXJuYW1lICQwYAp0ZXN0IC16ICIkc3JjZGlyIiAmJiBzcmNkaXI9
LgoKUFJPSkVDVD0iYmx1ZXotZ25vbWUiCgoodGVzdCAtZiAkc3JjZGlyL2NvbmZpZ3VyZS5pbikg
fHwgewogICAgZWNobyAtbiAiKipFcnJvcioqOiBEaXJlY3RvcnkgXCJcJyRzcmNkaXJcJ1wiIGRv
ZXMgbm90IGxvb2sgbGlrZSB0aGUiCiAgICBlY2hvICIgdG9wLWxldmVsIHBhY2thZ2UgZGlyZWN0
b3J5IgogICAgZXhpdCAxCn0KCmlmIHRlc3QgLXogIiRBVVRPR0VOX1NVQkRJUl9NT0RFIjsgdGhl
bgogICAgICAgIGlmIHRlc3QgLXogIiQqIjsgdGhlbgogICAgICAgICAgICAgICAgZWNobyAiSSBh
bSBnb2luZyB0byBydW4gLi9jb25maWd1cmUgd2l0aCBubyBhcmd1bWVudHMgLSBpZiB5b3Ugd2lz
aCAiCiAgICAgICAgICAgICAgICBlY2hvICJ0byBwYXNzIGFueSB0byBpdCwgcGxlYXNlIHNwZWNp
ZnkgdGhlbSBvbiB0aGUgJDAgY29tbWFuZCBsaW5lLiIKICAgICAgICBmaQpmaQoKCmFjbG9jYWwg
fHwgZXhpdCAkPwphdXRvaGVhZGVyIHx8IGV4aXQgJD8KaW50bHRvb2xpemUgLS1hdXRvbWFrZSAt
LWNvcHkgLS1mb3JjZSB8fCBleGl0ICQ/CmF1dG9tYWtlIC0tYWRkLW1pc3NpbmcgLS1jb3B5IHx8
IGV4aXQgJD8KYXV0b2NvbmYgfHwgZXhpdCAkPwoKaWYgdGVzdCAteiAiJEFVVE9HRU5fU1VCRElS
X01PREUiOyB0aGVuCiAgICAgICAgJHNyY2Rpci9jb25maWd1cmUgLS1lbmFibGUtbWFpbnRhaW5l
ci1tb2RlICRBVVRPR0VOX0NPTkZJR1VSRV9BUkdTICIkQCIgfHwgZXhpdCAkPwoKICAgICAgICBl
Y2hvIAogICAgICAgIGVjaG8gIk5vdyB0eXBlICdtYWtlJyB0byBjb21waWxlICRQUk9KRUNULiIK
ZmkKCgo=
------=_Part_23755_2175613.1198016239077--
