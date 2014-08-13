Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140812124529.GA2842@t440s.lan>
References: <1407791934-3778-1-git-send-email-armansito@chromium.org>
	<1407791934-3778-2-git-send-email-armansito@chromium.org>
	<20140812124529.GA2842@t440s.lan>
Date: Tue, 12 Aug 2014 19:42:55 -0700
Message-ID: <CAHrH25TtWgoWWHcTRKg2ff2hO6JON32729rNmpA5iEZQ1MjP6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] shared/att: Handle disconnects.
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Sorry to keep pushing for further iterations of this patch, but I think
> it'd be good to split this into two separate changes: first one for the
> io code and a second one for ATT.
>

No worries, will do in the next patch set.

> Looking at how shared/io-glib.c does this (which I assume you've
> verified doesn't need fixing) another (and possibly even better)
> approach is to do the ref when adding the fd to the mainloop and the
> unref in the destroy callback. I'll leave it up to you to choose which
> one you want to go with.

Ah, I see. I think that's a better approach and it's consistent with
io-glib, so I'll go with your suggestion.
