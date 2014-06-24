Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jun 2014 11:43:43 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] queue: Add queue_foreach_if
Message-ID: <20140624084305.GC22942@aemeltch-MOBL1>
References: <1403598452-4391-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <FDFF8D9B-E5C8-44C2-9C14-189C02E54672@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FDFF8D9B-E5C8-44C2-9C14-189C02E54672@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jun 24, 2014 at 10:35:38AM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Function allows to search for a second level queue inside first level
> > queue. In the current implementation since head is hidden this is not
> > possible.
> 
> this is not something we want in a generic helper. This is a specific case and better model that on top of queue and not within it. Queues of queues are not a thing.
> 

So what is the best way to search for queue inside queue?

Best regards 
Andrei Emeltchenko 

