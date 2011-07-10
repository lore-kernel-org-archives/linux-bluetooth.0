Return-Path: <cyrus@holtmann.org>
Date: Sun, 10 Jul 2011 10:55:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Audio: fix race condition when starting a stream
Message-ID: <20110710075553.GD1808@dell.ger.corp.intel.com>
References: <1310050294.5639.1.camel@THOR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310050294.5639.1.camel@THOR>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Thu, Jul 07, 2011, Peter Hurley wrote:
> The AVDTP spec allows for a race condition between remote and local
> device when issuing an AVDTP_START cmd on a stream in the OPEN state.
> 
> However, the internal state must continue to be consistent. For example,
> suppose that avdtp_start() has been called while in the OPEN state and
> a AVDTP_START cmd is sent.  Now before we have received a response (and
> thus entered the STREAMING state), we *receive* a START cmd. Prior to
> this fix, since the sep is still in the OPEN state, we would accept
> the new START cmd. This will leads us to send both a Start_Ind and
> Start_Cfm - not good.
> 
> Now, we track this transitional state (starting == TRUE).
> 
> NB - 'starting' is only in a valid state while the sep is in the
> OPEN state. 'starting' is reset when we return to the OPEN state.
> ---
>  audio/avdtp.c |   29 +++++++++++++++++++++++++----
>  1 files changed, 25 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan
