Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Move gattrib source files to src directory
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20101105050602.GD25270@jh-x301>
References: <1288901266-32547-1-git-send-email-claudio.takahasi@openbossa.org>
	 <20101105050602.GD25270@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 10 Nov 2010 14:26:35 +0900
Message-ID: <1289366795.9615.232.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > gattrib related functions will be required during the device creation
> > for GATT enabled devices(BR/EDR and LE). Primary service discovery is
> > a pre-condition to probe the GATT device driver.
> > ---
> >  Makefile.am      |    7 +-
> >  attrib/att.c     |  764 ------------------------------------------------------
> >  attrib/att.h     |  206 ---------------
> >  attrib/gatt.c    |  113 --------
> >  attrib/gatt.h    |   43 ---
> >  attrib/gattrib.c |  535 --------------------------------------
> >  attrib/gattrib.h |   72 -----
> >  src/att.c        |  764 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  src/att.h        |  206 +++++++++++++++
> >  src/gatt.c       |  113 ++++++++
> >  src/gatt.h       |   43 +++
> >  src/gattrib.c    |  535 ++++++++++++++++++++++++++++++++++++++
> >  src/gattrib.h    |   72 +++++
> >  13 files changed, 1736 insertions(+), 1737 deletions(-)
> >  delete mode 100644 attrib/att.c
> >  delete mode 100644 attrib/att.h
> >  delete mode 100644 attrib/gatt.c
> >  delete mode 100644 attrib/gatt.h
> >  delete mode 100644 attrib/gattrib.c
> >  delete mode 100644 attrib/gattrib.h
> >  create mode 100644 src/att.c
> >  create mode 100644 src/att.h
> >  create mode 100644 src/gatt.c
> >  create mode 100644 src/gatt.h
> >  create mode 100644 src/gattrib.c
> >  create mode 100644 src/gattrib.h
> 
> I'll wait a little bit with this one. I agree that the gattrib
> funcionality needs to be available within the core daemon, but does that
> necessarily mean that the source files for need to be in src? It'd be
> good to get some comment from Marcel about this too.

I think that this change is actually bad. Since we have non-recursive
build system, we are not bound to have code under the same directory.

So my advise would be to not do this and just link the attrib/* code
into the bluetoothd.

Regards

Marcel


