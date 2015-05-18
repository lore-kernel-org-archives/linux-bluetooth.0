Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 May 2015 10:56:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jonas Rydow <jrydow@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] hciattach: Big endian support for various TI chips.
Message-ID: <20150518075633.GB18361@t440s.lan>
References: <CAHwR_AWn-_-=u8RVZpV8pZ-P1JeZx3oKuhZgE8j-na8c-7KXGw@mail.gmail.com>
 <CAHwR_AVsxXhgMSnieXzbj4if0X3gR12PzGzw1iKoeu8F8ToXMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHwR_AVsxXhgMSnieXzbj4if0X3gR12PzGzw1iKoeu8F8ToXMQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jonas,

On Mon, May 18, 2015, Jonas Rydow wrote:
> Did I miss something with this patch? It has not been accepted nor
> rejected or commented.

Well, for one thing the patch is corrupted and doesn't apply:

Applying: hciattach: Big endian support for various TI chips.
fatal: corrupt patch at line 10
Patch failed at 0001 hciattach: Big endian support for various TI chips.

It looks like your mail client may have done incorrect line splitting -
using git send-email is usually the safest approach to avoid such
things.

That's not an excuse for forgetting about the patch, but occasionally it
happens when the submitter doesn't verify that he's sent something
that's actually usable.

Johan
