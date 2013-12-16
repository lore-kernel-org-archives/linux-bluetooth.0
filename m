Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Dec 2013 10:17:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: Re: [PATCH] Add PICS, PIXITs and PTS test results for L2CAP
Message-ID: <20131216081736.GA8323@x220.p-661hnu-f1>
References: <1387147192-19246-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387147192-19246-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Sun, Dec 15, 2013, Sebastian Chlad wrote:
> +* - different than PTS defaults
> +# - not yet implemented/supported
> +
> +M - mandatory
> +O - optional
> +
> +		Roles
> +-------------------------------------------------------------------------------
> +Parameter Name	Selected	Description
> +-------------------------------------------------------------------------------
> +TSPC_L2CAP_1_1	True		Data Channel Initiator (C.1)
> +TSPC_L2CAP_1_2	True		Data Channel Acceptor (C.1)
> +TSPC_L2CAP_1_3	False (#)	LE Master (C.2)
> +TSPC_L2CAP_1_4	False (#)	LE Slave (C.2)

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
