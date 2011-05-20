Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Add conf file support
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20110520180401.GA23399@dell.amr.corp.intel.com>
References: <1305620264-22304-1-git-send-email-luiz.dentz@gmail.com>
	 <20110520180401.GA23399@dell.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 May 2011 11:37:24 -0700
Message-ID: <1305916644.2681.10.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > This should reduce the amount of options which normally don't change each
> > time obexd is executed.
> > ---
> >  Makefile.am    |    2 +-
> >  plugins/ftp.c  |    8 ++-
> >  src/main.c     |  176 +++++++++++++++++++++++++++++++++++++++-----------------
> >  src/obexd.conf |   19 ++++++
> >  4 files changed, 149 insertions(+), 56 deletions(-)
> >  create mode 100644 src/obexd.conf
> 
> This doesn't compile with gcc 4.6:
> 
> src/main.c: In function ‘main’:
> src/main.c:267:12: error: variable ‘config’ set but not used [-Werror=unused-but-set-variable]
> 
> Please fix and resend.

didn't we agree on not having an obexd configuration file. That stuff
should be part of the D-Bus service autostart file.

Regards

Marcel


