Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 May 2012 17:40:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: santhosh aj <ajsant@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Auto Generate configure & make files
Message-ID: <20120517144015.GA20883@x220.P-661HNU-F1>
References: <CAP6uk1On=Re6wOo6-HSD=g8iHdWE9bgxJcJ0NF3w9vTRnTfGvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAP6uk1On=Re6wOo6-HSD=g8iHdWE9bgxJcJ0NF3w9vTRnTfGvA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santosh,

On Thu, May 17, 2012, santhosh aj wrote:
> Can any one please tell me what is the proper order/commands to
> generate configure.in, .configure, Makefile.in, config.h.in. If we
> download a snapshot from git repository
> (http://git.kernel.org/?p=bluetooth/bluez.git;a=summary) these file
> will be missing. I found a link which give some information about this
> (http://www.nondot.org/sabre/Mirrored/autoconf-2.12/autoconf_2.html).
> but if some one can tell the proper steps it will be help a lot for
> all who doesn't know.

The git tree contains a script called bootstrap that will do this for
you. A bootstrap-configure script is also provided which additionally
calls the configure script with options that are appropriate for BlueZ
development (but not necessarily for product use).

Johan
