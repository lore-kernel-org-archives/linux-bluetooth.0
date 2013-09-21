Return-Path: <cyrus@holtmann.org>
Date: Sat, 21 Sep 2013 13:09:41 -0500
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Frederic Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android: Add skeleton of BlueZ Android daemon
Message-ID: <20130921180941.GA14700@x220.p-661hnu-f1>
References: <1379679871-29623-1-git-send-email-frederic.danis@linux.intel.com>
 <226042C8-264A-469E-8D6A-F41141DC0552@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <226042C8-264A-469E-8D6A-F41141DC0552@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Sep 21, 2013, Marcel Holtmann wrote:
> > Define local mapping to glib path, otherwise this has to be inside central
> > place in the build repository.
> > 
> > Retrieve Bluetooth version from configure.ac.
> > ---
> > .gitignore         |    2 +
> > Android.mk         |    9 ++++
> > Makefile.am        |    1 +
> > Makefile.android   |    7 ++++
> > android/Android.mk |   24 +++++++++++
> > android/main.c     |  119 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > configure.ac       |    5 +++
> > 7 files changed, 167 insertions(+)
> > create mode 100644 Android.mk
> > create mode 100644 Makefile.android
> > create mode 100644 android/Android.mk
> > create mode 100644 android/main.c
> 
> lets split this out a little bit. Code additions should not be
> intermixed with additions to the build system and especially configure
> options.

I agree about keeping separate build system changes such as adding
completely new makefiles or adding configure options. However, what I
think doesn't hurt (and the guidance I've given) is to at least include
the matching build system change to the same commit that adds new c/h
files. This way you don't end up having "dead code" in the tree in
between commits that just lies around there but can't be compiled and
wont be included in any release tarballs.

Johan
