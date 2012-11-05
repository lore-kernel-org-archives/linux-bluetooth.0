Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 Nov 2012 15:52:24 +0100
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Kim Schulz <kim@schulz.dk>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 0/3] LE Connection parameter tuning (first step)
Message-ID: <20121105145224.GA18358@echo>
References: <1352121943-18001-1-git-send-email-vinicius.gomes@openbossa.org>
 <2375c7de623938c6e2f1fe8e7687db7d@server1.devteam.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2375c7de623938c6e2f1fe8e7687db7d@server1.devteam.dk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 14:42 Mon 05 Nov, Kim Schulz wrote:
> Den 2012-11-05 14:25, Vinicius Costa Gomes skrev:
> >Hi,
> >
> >Right now, we are using only one set of (hardcoded) connection
> >parameters for LE.  I guess the first step to have different
> >connection parameters classes for different Profiles requirements
> >(think "Low Latency", "Low Power", etc.) is to have a nice set of
> >parameters. For that we need to measure and see which are the sweet
> >spots, This series aims to help the measuring part.
> >
> >This is an idea so we can easily change the connection parameters
> >without need for recompiling the kernel side, so tests can be more
> >practical.
> >
> [snip]
> 
> 
> Good idea to split them out as every single profile defines their
> own. Have you
> concidered what should happen if two LE connections to two different
> profils should
> happen at the same time and the connection parameters are different?
> i.e. should bluez
> maybe have a per-profile set of connection parameters?

The current plan is to have the most restrictive (in terms of latency)
set of parameters to prevail over the others.

> Also make room in the struct for Preferred Connection Paramters (the
> values read
> from the peer DB after connection) as these can differ from the ones
> the profile proposes.

I don't think that this information should be in the kernel side, but thank
you for reminding me of this. About the problem, that could be dealt with
having that as another set of parameters (perhaps with a higher priority). 

> 
> -- 
> Kim Schulz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
