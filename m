Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Apr 2013 10:34:59 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 1/2] gdbus: Add g_dbus_flush_properties()
Message-ID: <20130419133459.GA7044@echo>
References: <1366307424-19825-1-git-send-email-vinicius.gomes@openbossa.org>
 <CABBYNZJFT18e172brOH1QR2WCrZWEkxUsw3vwp8YDKCsYvRPQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZJFT18e172brOH1QR2WCrZWEkxUsw3vwp8YDKCsYvRPQw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 09:30 Fri 19 Apr, Luiz Augusto von Dentz wrote:
> Hi Vinicius,
> 

[snip]

> 
> What about creating a new flag for properties that need to emit a
> signal immediately when they change?

That would also solve the problem.

The way I see it, we should still not make any guarantees about when
a propery changed signal will be emitted, only when the API behaviour
requires, we use some kind of barrier to keep the ordering in check.

And having a function to call we make it easier to detect when this
is abused, i.e. we know there's something very wrong if there's a flush
after each emit.

> 
> 
> --
> Luiz Augusto von Dentz


Cheers,
-- 
Vinicius
