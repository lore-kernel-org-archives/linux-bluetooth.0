Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Aug 2014 10:29:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] shared/att: Handle disconnects.
Message-ID: <20140813072910.GA13494@t440s>
References: <1407791934-3778-1-git-send-email-armansito@chromium.org>
 <1407791934-3778-2-git-send-email-armansito@chromium.org>
 <20140812124529.GA2842@t440s.lan>
 <CAHrH25RDpSjK_uYi_Hba1=4=7GFhnSP9DdEdM6HGBy8waB6zVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHrH25RDpSjK_uYi_Hba1=4=7GFhnSP9DdEdM6HGBy8waB6zVQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, Aug 12, 2014, Arman Uguray wrote:
> > Looking at how shared/io-glib.c does this (which I assume you've
> > verified doesn't need fixing) another (and possibly even better)
> > approach is to do the ref when adding the fd to the mainloop and the
> > unref in the destroy callback. I'll leave it up to you to choose which
> > one you want to go with.
> 
> I tested this approach and it doesn't fix the problem. The issue is
> that io_destroy immediately calls mainloop_remove_fd, which calls
> io_cleanup right away. This ends up reducing the reference count down
> to zero before the disconnect callback returns if io_destroy is called
> from within the callback. So we will need to have additional guards
> around the body of io_callback, which doesn't make the io-glib
> approach particularly useful.
> 
> Let me know if that makes sense.

Yes, makes sense. Seems like the first ref/unref approach is the best
option after all here.

Johan
