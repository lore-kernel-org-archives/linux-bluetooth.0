Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Nov 2008 17:32:58 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Simple-agent in C
Message-ID: <20081120153258.GA31342@localhost>
References: <37367b3a0811200516y71890f0es7b1aafaac5ef873b@mail.gmail.com> <20081120133426.GA24814@localhost> <37367b3a0811200722r33c50f6fme81c28dc0be0ef39@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37367b3a0811200722r33c50f6fme81c28dc0be0ef39@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Nov 20, 2008, Alan Carvalho de Assis wrote:
> I noticed this agent.c doesn't use any Glib function, is it right?

Yes.

> I am comparing agent.c against simple-agent and verified it is very different.

Yes, as I said you'll need to fill in the proper agent callbacks (right
now there's something called "Request" which does not exist in the API)
as well as make it get the adapter path using e.g. DefaultAdapter().

Johan
