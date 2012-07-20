Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAAbnaHb+Za_13Wvp0v4ea0JhXShbgsimC_FeLSkoHOUXHg+JjQ@mail.gmail.com>
References: <CAAbnaHb+Za_13Wvp0v4ea0JhXShbgsimC_FeLSkoHOUXHg+JjQ@mail.gmail.com>
Date: Fri, 20 Jul 2012 22:42:42 +0200
Message-ID: <CANq1E4TcFz63KAy1brLZVt-pvyNHd6XqHCZ_V3RvPjaCzUbwdQ@mail.gmail.com>
Subject: Re: [RFC generichid 0/5]
From: David Herrmann <dh.herrmann@googlemail.com>
To: Nathaniel Haggard <natester@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Fri, Jul 20, 2012 at 6:29 PM, Nathaniel Haggard <natester@gmail.com> wrote:
> Patch to add generichid so bluez can emulate a bluetooth keyboard.
> Pairs with ubuntu, osx leopard and tiger.  The following commands set
> it up for testing:

Why calling it "generichid"? It took me quite some time to figure out
what you actually implement here. If the profile is called
"generichid" then this is fine, but please use more descriptive
commit-messages. I guess this implements the client-side of the BT-HID
specs?

Furthermore, I think the input modules got moved into profiles/input/
so it would be nice if you could rebuild against the current git
revision.

And as a last point, please use more review-friendly splits. You
currently introduce many functions in the first commit that aren't
really used there. This makes review very hard. And a separate
dbus-API description would be nice so we know what is actually
implemented.

Thanks
David
