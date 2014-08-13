Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140812124529.GA2842@t440s.lan>
References: <1407791934-3778-1-git-send-email-armansito@chromium.org>
	<1407791934-3778-2-git-send-email-armansito@chromium.org>
	<20140812124529.GA2842@t440s.lan>
Date: Tue, 12 Aug 2014 20:57:14 -0700
Message-ID: <CAHrH25RDpSjK_uYi_Hba1=4=7GFhnSP9DdEdM6HGBy8waB6zVQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] shared/att: Handle disconnects.
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,


> Looking at how shared/io-glib.c does this (which I assume you've
> verified doesn't need fixing) another (and possibly even better)
> approach is to do the ref when adding the fd to the mainloop and the
> unref in the destroy callback. I'll leave it up to you to choose which
> one you want to go with.
>

I tested this approach and it doesn't fix the problem. The issue is
that io_destroy immediately calls mainloop_remove_fd, which calls
io_cleanup right away. This ends up reducing the reference count down
to zero before the disconnect callback returns if io_destroy is called
from within the callback. So we will need to have additional guards
around the body of io_callback, which doesn't make the io-glib
approach particularly useful.

Let me know if that makes sense.

-Arman
