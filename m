Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Mar 2012 16:20:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] sdp: Fix sdp_get_profile_descs for Mac Os X Lion
Message-ID: <20120313142024.GA3157@x220.P-661HNU-F1>
References: <1329771478-3935-1-git-send-email-frederic.dalleau@linux.intel.com>
 <1329771478-3935-3-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1329771478-3935-3-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Mon, Feb 20, 2012, Frédéric Dalleau wrote:
> ---
>  lib/sdp.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/sdp.c b/lib/sdp.c
> index 57f630a..97c0a08 100644
> --- a/lib/sdp.c
> +++ b/lib/sdp.c
> @@ -2064,7 +2064,12 @@ int sdp_get_profile_descs(const sdp_record_t *rec, sdp_list_t **profDescSeq)
>  		uint16_t version = 0x100;
>  
>  		if (SDP_IS_UUID(seq->dtd)) {
> +			sdp_data_t *next = seq->next;
>  			uuid = &seq->val.uuid;
> +			if (next && next->dtd == SDP_UINT16) {
> +				version = next->val.uint16;
> +				seq = next;
> +			}
>  		} else if (SDP_IS_SEQ(seq->dtd)) {
>  			sdp_data_t *puuid = seq->val.dataseq;
>  			sdp_data_t *pVnum = seq->val.dataseq->next;

I've applied the first patch since that's quite straight forward but I'm
struggling a bit with this second one. Firstly you should include the
hcidump into the commit message as well as a proper explanation. An
empty commit message (just summary line) is only acceptable for extremely
trivial patches (and this is far from it).

I *think* I get the main part of the patch, but one thing that's unclear
is why do you assign next to seq instead of letting the for-loop do it.
The second branch of the if-statement doesn't do it either so why does
the first need it? Again, you could have avoided these questions from me
if you had included an appropriate code comment. Whenever there's
something counterintuitive in the code it's a good idea to have such a
comment.

Johan
