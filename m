Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Mar 2011 19:08:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: Arun Raghavan <arun.raghavan@collabora.co.uk>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Always reset the remote SEP when reconfiguring A2DP
Message-ID: <20110315170818.GB15712@jh-x301>
References: <1300199261-27481-1-git-send-email-arun.raghavan@collabora.co.uk>
 <1300199261-27481-2-git-send-email-arun.raghavan@collabora.co.uk>
 <4D7F9410.5020609@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D7F9410.5020609@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Tue, Mar 15, 2011, Brian Gix wrote:
> This patch violates the AVDTP specification, as indicated in other
> email. SEID may not be changed by RECONFIGURE.

Actually this patch doesn't seem to be about AVDTP_Reconfigure but about
AVDTP_Close + AVDTP_SetConfiguration + AVDTP_Open. So from that
perspective there's no violation of the spec as far as I can see.
However, as I mentioned in my other email this will break interop with
some car kits which expect the new stream to be configured to the same
SBC SEP in the case that the new codec is SBC. So some checks for
matching codec needs to be done and only if the new codec is different
than the old one can we clear setup->rsep.

Johan
