Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAP6uk1On=Re6wOo6-HSD=g8iHdWE9bgxJcJ0NF3w9vTRnTfGvA@mail.gmail.com>
References: <CAP6uk1On=Re6wOo6-HSD=g8iHdWE9bgxJcJ0NF3w9vTRnTfGvA@mail.gmail.com>
Date: Thu, 17 May 2012 08:45:03 -0500
Message-ID: <CAB7rCTgao_W6to_=R796Y0aWKJRsHy-Xi-w+4kXWYDT=GPWW4A@mail.gmail.com>
Subject: Re: Auto Generate configure & make files
From: Mike <puffy.taco@gmail.com>
To: santhosh aj <ajsant@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santhosh,

On Wed, May 16, 2012 at 11:13 PM, santhosh aj <ajsant@gmail.com> wrote:
> Hi,
> Can any one please tell me what is the proper order/commands to
> generate configure.in, .configure, Makefile.in, config.h.in. If we
> download a snapshot from git repository
> (http://git.kernel.org/?p=bluetooth/bluez.git;a=summary) these file
> will be missing. I found a link which give some information about this
> (http://www.nondot.org/sabre/Mirrored/autoconf-2.12/autoconf_2.html).
> but if some one can tell the proper steps it will be help a lot for
> all who doesn't know.

Try running "./bootstrap".

Mike
