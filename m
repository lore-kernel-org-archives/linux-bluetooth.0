Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 0/3] Add READ_BLOB support to attrib-server
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: vinicius.gomes@openbossa.org, claudio.takahasi@openbossa.org,
	johan.hedberg@nokia.com, padovan@profusion.mobi,
	rshaffer@codeaurora.org
In-Reply-To: <1295474453-8495-1-git-send-email-bgix@codeaurora.org>
References: <1295474453-8495-1-git-send-email-bgix@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 19 Jan 2011 14:05:13 -0800
Message-ID: <1295474713.1774.8.camel@ubuntuLab1>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All -- Correction below.


On Wed, 2011-01-19 at 14:00 -0800, Brian Gix wrote:
> The following patches were cretated off of the working bluez tip at git.kernel.org as of:
> 
> commit f0411254277e6c2273d32379e4a2d3742ee05e55
> Author: Johan Hedberg <johan.hedberg@nokia.com>
> Date:   Wed Jan 19 22:20:41 2011 +0530
> 
>     Update NREC callback code to originally intended v2 state
> 
> 
> Patch 1 adds the default MTU for L2CAP based ATT connections (48) and
> modifies the usages for consistency.  This is important when segmenting
> long attribute over multiple transactions, because remote clients will
> typically decide wether to issue subsequent READ_BLOB request based on wether
> the prior read filled the entire MTU.  This explicitely does not address
> situations where a larger MTU than the defaults (23 and 48) are used, but
> in practice, there is no evidence that they exist at this time.
> 
> Patch 2 is some maintanence to fix the attrib-server to correctly indicate
> the end of the service range, if a primary or secondary service contains
> nothing but the service declaration.  This can be seen prior to this patch
> in attrib-server.c in the GATT_PRIM_SVC_UUID definition which sent a service
> range of 0x0010 - 0x0006 instead of 0x0010 - 0x0010.

What I meant was it is the GENERIC_ATTRIB_PROFILE_ID service which is
(prior to this patch) indicating an incorrect and invalid range.

> Patch 3 completes the implementation.  It can be tested on the current example
> server by reading attribute 0x0214, which caontains a 25 octet string.
> 

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

