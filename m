Return-Path: <cyrus@holtmann.org>
Message-ID: <37367b3a0811200722r33c50f6fme81c28dc0be0ef39@mail.gmail.com>
Date: Thu, 20 Nov 2008 15:22:38 +0000
From: "Alan Carvalho de Assis" <acassis@gmail.com>
To: "Johan Hedberg" <johan.hedberg@nokia.com>
Subject: Re: Simple-agent in C
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20081120133426.GA24814@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <37367b3a0811200516y71890f0es7b1aafaac5ef873b@mail.gmail.com>
	 <20081120133426.GA24814@localhost>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Nov 20, 2008 at 1:34 PM, Johan Hedberg <johan.hedberg@nokia.com> wrote:
>
> There's test/agent.c in the source tree. However, now that I took a
> quick look at it it's not up-to-date with the latest 4.x API (it e.g.
> hardcodes "/org/bluez/hci0" and doesn't use the correct Agent method
> names). You'll still be able to use it as a good starting point though.
>

I noticed this agent.c doesn't use any Glib function, is it right?

I am comparing agent.c against simple-agent and verified it is very different.

> Johan

Best Regards,

Alan
