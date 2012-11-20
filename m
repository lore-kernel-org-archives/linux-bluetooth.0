Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Nov 2012 14:57:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bart Westgeest <bart@elbrys.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix corrupted SDP response for sequence size > 256
Message-ID: <20121120125739.GA15617@x220.ger.corp.intel.com>
References: <1353351872-10628-1-git-send-email-bart@elbrys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353351872-10628-1-git-send-email-bart@elbrys.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bart,

On Mon, Nov 19, 2012, Bart Westgeest wrote:
> This patchset includes minor refactoring and a bug fix. The bug
> is exposed when a data sequence grows beyond 256 bytes, in this case the
> complete sequence data is written, but the size is truncated to one
> byte, resulting in a corrupted SDP response.
> 
> RE: Feedback on potential fix for issue while advertising Feature List
> 
> Bart Westgeest (3):
>   sdp: Inlined single use of function sdp_set_data_type
>   sdp: Limit side effects of sdp_get_data_type and sdp_get_data_size
>   sdp: Upgrade datatype SEQ8 to SEQ16 when data size is greater than
>     256
> 
>  lib/sdp.c |   56 +++++++++++++++++++++++---------------------------------
>  1 file changed, 23 insertions(+), 33 deletions(-)

I'm happy with these as well as your responses to the feedback you got,
so the patches are now pushed upstream.

Regarding the SDP code needing cleanups/fixing/rewriting in general, we
know :) This is one of the oldest pieces of code in the stack which
could definitely use a rewrite. However, no one has come along with the
time to do it yet.

Johan
