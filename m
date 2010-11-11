Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 15:30:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add a new configuration option to disable Low Energy
 support
Message-ID: <20101111133018.GA15983@jh-x301>
References: <1289426161-10045-1-git-send-email-claudio.takahasi@openbossa.org>
 <1289426161-10045-3-git-send-email-claudio.takahasi@openbossa.org>
 <20101111091857.GA2862@jh-x301>
 <AANLkTinhT+sauN0HXPom_53i6FRQWDjeSLeBaneLwAmb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinhT+sauN0HXPom_53i6FRQWDjeSLeBaneLwAmb@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

> > If the option is called "le" it shouldn't affect GATT over BR/EDR, so I
> > think the check in attrib_server_init should only affect the LE socket
> > (or then rename the option to e.g. main.opts.attrib).
> 
> It is not affecting GATT over BR/EDR. bt_io_listen for BR/EDR is above
> this checking.
> 
> My patch "[PATCH] Fix possible memory leak of the GIOChannel in the
> attribute server" switched the order of the bt_io_listen calls between
> BR/EDR and LE. I forgot to send these patches as patch sequence.

Ok, then it's fine. The patch is now pushed upstram.

Johan
