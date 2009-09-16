Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Sep 2009 19:41:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Florian Philipp <lists@binarywings.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: PIN Helper
Message-ID: <20090916164104.GA11739@jh-x301>
References: <6887eb5d0909142301r52343cd3sbe64c106da2d7434@mail.gmail.com> <20090915061104.GA20323@jh-x301> <4AAFBFA6.70007@binarywings.net> <20090915165854.GA6550@jh-x301> <4AB107DE.5070700@binarywings.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AB107DE.5070700@binarywings.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Sep 16, 2009, Florian Philipp wrote:
> Of course I can't force you to do the programming but removing
> functionality which worked - more or less - out of the box with an older
> release and not providing any working alternative except of a
> do-it-yourself solution ... well ... just sounds wrong.

I think part of the explanation is lack of knowledge about exactly in
which ways people use BlueZ and how popular these use cases are. To be
honest, I'm not sure I still understand exactly what kind of behavior or
feature you're after.

> Okay, so without some significant work, you could only support legacy
> pairing for those old deamons and I suppose that's all those test apps
> can, right?

Exactly which old daemons are you talking about? I don't see how any old
software that isn't aware of the current pairing/agent interface could be
made to work "without some significant work".

> a) Create and maintain the missing parts myself.

If the functionality makes sense and the implementation follows the usual
coding standards that we have I don't see why you would be stuck
maintaining it yourself. Surely it should be possibe to merge the work
with upstream.

Johan
