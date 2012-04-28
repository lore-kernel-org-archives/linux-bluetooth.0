Return-Path: <cyrus@holtmann.org>
Date: Sat, 28 Apr 2012 12:43:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mike Brudevold <puffy.taco@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Michael Brudevold <michael.brudevold@logicpd.com>
Subject: Re: [PATCH] audio: Fix AVDTP General Reject message
Message-ID: <20120428094310.GA7293@x220.P-661HNU-F1>
References: <1335547341-19459-1-git-send-email-puffy.taco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335547341-19459-1-git-send-email-puffy.taco@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Fri, Apr 27, 2012, Mike Brudevold wrote:
> From: Michael Brudevold <michael.brudevold@logicpd.com>
> 
> As per spec, bits other than Transaction Label and Packet Type are RFA. This
> fixes the RFA bits which were previously set to the invalid signal_id.
> 
> Test case TP/SIG/SMG/BI-28-C.
> ---
>  audio/avdtp.c |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)

See commit 998b0976e28cd33cbfd2f71b6f27a162da6fe668

This is how BlueZ used to behave until ESR04 was released (still
available on bluetooth.org adopted specs page) which clarified the AVDTP
1.0 specification (both profile and test spec) to define general reject
as containing the signal id. For whatever reason it seems like the
content of ESR04 never made it the the 1.2 spec version. I'd like to get
some clarity on this, i.e. was the errata dropped on purpose or by
mistake.

Johan
