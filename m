Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Oct 2010 17:24:43 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Par-Gunnar Hjalmdahl <pghatwork@gmail.com>
Cc: linus.walleij@stericsson.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] mfd: Add UART support for the ST-Ericsson CG2900.
Message-ID: <20101029172443.61f7b067@pyx>
In-Reply-To: <AANLkTinj93zAXJAipB3HjE62Xa1Z=9k9gPBxaT=+MLtg@mail.gmail.com>
References: <AANLkTi=XTUau_GbASJEUBgsZ_FYYmRAX6W43YtRdv2wS@mail.gmail.com>
	<20101022135130.617f0ce8@lxorguk.ukuu.org.uk>
	<AANLkTinj93zAXJAipB3HjE62Xa1Z=9k9gPBxaT=+MLtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> The reason is that the work is generated so often that a work is not
> finished before next work of same type comes. This is especially true
> for transmit and receive. Then I get 0 back when queuing the work and
> there is no real way to solve it from what I can see than to allocate
> new work structures every time.

So if that is the case what bounds your memory usage - can a busy box end
up with thousands of work queue slos used ? It sounds like your model is
perhaps wrong - if there is a continual stream of work maybe you should
simply have a kernel thread to handle it if it cannot be deferred
- remember ldisc code is able to sleep in most paths.

