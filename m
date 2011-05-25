Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Add conf file support
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <BANLkTikKXPx-FgPB5nR6H9LKVTHGdLaggQ@mail.gmail.com>
References: <1306253521-30725-1-git-send-email-luiz.dentz@gmail.com>
	 <1306283998.2681.17.camel@aeonflux>
	 <BANLkTikKXPx-FgPB5nR6H9LKVTHGdLaggQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 May 2011 12:48:02 -0700
Message-ID: <1306352882.2681.43.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >> This should reduce the amount of options which normally don't change
> >> each time obexd is executed.
> >> ---
> >>  Makefile.am   |    2 +-
> >>  plugins/ftp.c |    8 ++-
> >>  src/main.c    |  173 +++++++++++++++++++++++++++++++++++++++-----------------
> >>  3 files changed, 127 insertions(+), 56 deletions(-)
> >
> > I do not want to have config file support for obexd.
> >
> 
> Alright, then I will just update the documentation of the current
> options to be more detailed and remove the old configuration file that
> still exists on the repository.

I don't know how much Johan mentioned on IRC, but what we should be
doing is by default enable all compiled in plugins and then use -p and
-P command line switches to control what gets enabled and what not. And
that can be done easily in the D-Bus autostart file.

Regards

Marcel


