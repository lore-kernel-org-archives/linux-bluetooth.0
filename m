Return-Path: <cyrus@holtmann.org>
From: "Chlad, SebastianX" <sebastianx.chlad@intel.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	Sebastian Chlad <sebastianchlad@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Add PICS, PIXITs and PTS test results for L2CAP
Date: Tue, 17 Dec 2013 09:27:58 +0000
Message-ID: <2115852EF878384FA984E6B76A9F379E164297@IRSMSX104.ger.corp.intel.com>
References: <1387147192-19246-1-git-send-email-sebastianx.chlad@intel.com>,<20131216081736.GA8323@x220.p-661hnu-f1>
In-Reply-To: <20131216081736.GA8323@x220.p-661hnu-f1>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

[ '#' notation ]
True and I can simply change it however there was (is) one thing which prevented me from doing this in the first place: having set any PICS which is not in place however it will be eventually implemented to False and marking it (#), gives clear indication what are the development objectives and at the same time some not relevant PTS tests are simply N/A. That is of benefit to anyone who wishes to test L2CAP in current state. 

[testing tools]
Good point. I was thinking about having in place some more tools besides l2test. I was considering i.e. hcitool or bluetoothctl however it wasn't straight forward to bring these to Android.mk (i.e. readline).
Anyhow having l2test (in Android) was straight forward so I'm planning to do the second round of L2CAP testing. 

In essence my idea was to do testing (L2CAP or anything for the matter) in repetitive way so surely first txt could lack some elements however with next iterations it would improve (i.e. we would have more and more test tools and scripts in place on Android so we could better describe and understand needs for certain set of PTS test). 

To summarize: please let me know what is you stand on [ '#' notation ] - I'll act accordingly and then I'll push L2CAP PTS test results once I finish second round of testing.

Thanks,
Seb

Hi Sebastian,

On Sun, Dec 15, 2013, Sebastian Chlad wrote:
> +* - different than PTS defaults
> +# - not yet implemented/supported
> +
> +M - mandatory
> +O - optional
> +
> +             Roles
> +-------------------------------------------------------------------------------
> +Parameter Name       Selected        Description
> +-------------------------------------------------------------------------------
> +TSPC_L2CAP_1_1       True            Data Channel Initiator (C.1)
> +TSPC_L2CAP_1_2       True            Data Channel Acceptor (C.1)
> +TSPC_L2CAP_1_3       False (#)       LE Master (C.2)
> +TSPC_L2CAP_1_4       False (#)       LE Slave (C.2)

I thought the idea of the '#' notation was that we could mark entries as
True if they eventually will be supported but are not yet implemented.
Wouldn't these last two entries fall under this category. 

> +-------------------------------------------------------------------------------
> +Test Name              Result  Notes
> +-------------------------------------------------------------------------------
> +TC_COS_CED_BV_01_C     INC     IUT should introduce testing tools
> +TC_COS_CED_BV_03_C     INC     IUT should introduce testing tools

What does the note here mean. l2test? If so wouldn't it be more helpful
to list the exact l2test command that's needs to be run?

Johan
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

