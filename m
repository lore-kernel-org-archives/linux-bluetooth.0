Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] build: Fix make distcheck for input plugin
Date: Tue, 13 Nov 2012 13:57:39 +0100
Message-ID: <6569845.L3ZsFuOrP2@uw000953>
In-Reply-To: <CAJdJm_NsCEmcjhtfSNh8mN5keoLzTtJsdN4+bpmdtJVzPgf4-Q@mail.gmail.com>
References: <1352754221-29672-1-git-send-email-anderson.lizardo@openbossa.org> <CAMOw1v4h9wfcFLL-j5+fmEUNF=ShHZryw93aOC+_8d2NsbMFag@mail.gmail.com> <CAJdJm_NsCEmcjhtfSNh8mN5keoLzTtJsdN4+bpmdtJVzPgf4-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> > Humn... maybe we need to review these CPPFLAGS for plugins. Appending
> > it to AM_CPPFLAGS means that every single source file has
> > "-I$(srcdir)/profiles/input". Even those sources not at all related to
> > HOGPLUGIN.
> >
> > However the only way I can think to fix it is by creating convenience
> > libs since autofoo doesn't support CPPFLAGS per source file.
> 
> I agree it is not the best solution. Actually, I think we can overcome
> the problem completely by getting rid of symlinks for "drivers" (like
> sap-{u8500,dummy}.c, suspend-dummy.c,
> telephony-{dummy,maemo5,maemo6,ofono}.c) and having everything
> built-in and enabled/disabled based on which D-Bus services are
> running on the system (or, if not possible, by using config options).
> This would also help with spotting build breakages, since all BlueZ
> code could be compiled by a single "./bootstrap-configure && make"
> call.

All code is compiled, it is just not linked.

-- 
BR
Szymon Janc
