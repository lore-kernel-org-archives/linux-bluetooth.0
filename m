Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1336391383.4325.24.camel@jlt3.sipsolutions.net>
References: <1336391383.4325.24.camel@jlt3.sipsolutions.net>
Date: Tue, 8 May 2012 15:30:39 +0200
Message-ID: <CANq1E4QW4vSn_r9C=rirShE+-eyPjRX+b5tpC+mx69Hs6aEYqQ@mail.gmail.com>
Subject: Re: batostr() function
From: David Herrmann <dh.herrmann@googlemail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-bluetooth@vger.kernel.org, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johannes

On Mon, May 7, 2012 at 1:49 PM, Johannes Berg <johannes@sipsolutions.net> wrote:
> Really? 2 static buffers that are used alternately based on a static
> variable? How can that possibly be thread-safe? That may work in very
> restricted scenarios, but ...

Looking at "git blame" it seems the whole function is still from
linux-2.4. Looks like no-one ever noticed. I've sent a patchset fixing
it, thanks.

> johannes

Regards
David
