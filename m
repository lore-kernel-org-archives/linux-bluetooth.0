Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv1 0/5] Bluetooth: experimental support for pm_limits
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1285937230-547-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1285937230-547-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Oct 2010 09:49:42 +0200
Message-ID: <1286264982.17473.22.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> First version of using power constraints interface to achieve
> maximum bluetooth transfer speed. Otherwise HW goes to idle mode
> and speed decreases 3 times.
> 
> Use empirical power management analyzer (TM) to define amount
> of time device set high power constraints for.
> 
> May include hacks :-)

please send these as [RFC] and not as [PATCH] if they are meant for
review.

Regards

Marcel


