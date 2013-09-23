Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Sep 2013 10:59:27 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Frederic Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android: Add skeleton of BlueZ Android daemon
Message-ID: <20130923075920.GD8444@aemeltch-MOBL1>
References: <1379679871-29623-1-git-send-email-frederic.danis@linux.intel.com>
 <226042C8-264A-469E-8D6A-F41141DC0552@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <226042C8-264A-469E-8D6A-F41141DC0552@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Sep 21, 2013 at 12:14:55PM -0500, Marcel Holtmann wrote:
> Hi Fred,
> 
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
> lets split this out a little bit. Code additions should not be intermixed with additions to the build system and especially configure options.
> 
> I rather not have a top-level Android.mk. It should be enough to provide an android/Android.mk.
> 

I believe this way we cannot build our project.

Best regards 
Andrei Emeltchenko 
