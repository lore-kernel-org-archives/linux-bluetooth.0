Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2] [Bluetooth] redo checks in IRQ handler for shared
 IRQ  support
From: Marcel Holtmann <marcel@holtmann.org>
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <8bd0f97a1001190316k6167ad39h20be3343aba3acb8@mail.gmail.com>
References: <1252905504-26666-1-git-send-email-vapier@gentoo.org>
	 <1252950229-9629-1-git-send-email-vapier@gentoo.org>
	 <8bd0f97a1001190316k6167ad39h20be3343aba3acb8@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Jan 2010 10:21:32 -0800
Message-ID: <1263925292.5591.169.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

> > Commit ac019360fe3 changed the irq handler logic to BUG_ON rather than
> > returning IRQ_NONE when the incoming argument is invalid.  While this
> > works in most cases, it doesn't work when the IRQ is shared with other
> > devices (or when DEBUG_SHIRQ is enabled).
> >
> > So revert the previous change and replace the warning message with a
> > comment explaining that we want this behavior.
> 
> was this picked up ?

not it was not, but now it has been applied to my trees. Thanks.

Regards

Marcel


