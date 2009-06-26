Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add support for registration of a PBAP service using
 sdptool
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: Nick Pelly <npelly@google.com>, linux-bluetooth@vger.kernel.org,
	Jiafa Liu <pbx376@motorola.com>
In-Reply-To: <1246005794.4017.26.camel@snoogens.fab.redhat.com>
References: <1245976084-8936-1-git-send-email-npelly@google.com>
	 <1245999714.12994.103.camel@localhost.localdomain>
	 <1246005794.4017.26.camel@snoogens.fab.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 26 Jun 2009 11:42:04 +0200
Message-Id: <1246009324.12994.107.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > > From: Jiafa Liu <pbx376@motorola.com>
> > > 
> > > ---
> > >  tools/sdptool.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > >  1 files changed, 80 insertions(+), 1 deletions(-)
> > 
> > argh :(
> > 
> > gcc -DHAVE_CONFIG_H -I. -I.. -I../common   -I../include   -Wall -O2 -D_FORTIFY_SOURCE=2 -Werror -Wextra -Wno-unused-parameter -Wno-missing-field-initializers -Wdeclaration-after-statement -Wmissing-declarations -Wredundant-decls -Wcast-align -D_FORTIFY_SOURCE=2 -fPIC -g -O0 -MT sdptool.o -MD -MP -MF .deps/sdptool.Tpo -c -o sdptool.o sdptool.c
> > cc1: warnings being treated as errors
> > sdptool.c: In function ‘add_pbap’:
> > sdptool.c:1873: error: comparison between signed and unsigned integer expressions
> > 
> > Can we at least try to compile it with ./bootstrap-configure and all our
> > warnings enabled.
> > 
> > I fixed it now, but come on that is not too much to ask.
> 
> You'd be right if it wasn't bogus, and GCC being anal...

you might look at it that way, but it is important from a security point
of view. For a lot of cases it sounds stupid, but this warning is good
for finding potential integer overflows because of different sign.

Regards

Marcel


