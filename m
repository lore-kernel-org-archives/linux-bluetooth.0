Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Nov 2011 14:17:26 +0100
From: Cedric Sodhi <manday@gmx.net>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Possible Regression: Frequent kernel panic with AR3011
Message-ID: <20111117131707.GA19867@slate>
References: <20111117125345.GC6237@slate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111117125345.GC6237@slate>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is invalid now. It is much more likely caused by wifi, of which I
forgot that it's atheros, too. Sorry for the wrong alert.

On Thu, Nov 17, 2011 at 01:53:45PM +0100, Cedric Sodhi wrote:
> From 3.1.0-gentoo to 3.2.*-* I start getting frequent kernel panics
> which, at least from the dump, appear to be originating at ath_... - and
> since the only atheros in my kernel is bluetooth, I very much assume
> this is related to bluetooth. As soon as I could get a complete dump, I
> will provide it. The device is 0cf3:3005 on USB.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
