Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Jan 2011 14:50:27 +0530
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Angela Bartholomaus <angelab@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	marcel@holtmann.org
Subject: Re: [PATCH 1/4] Bluetooth: Send an Invalid PDU Size Error Response
 for Service Search Req
Message-ID: <20110117092027.GA28815@jh-x301>
References: <1282755705-28400-1-git-send-email-angelab@codeaurora.org>
 <1282755705-28400-2-git-send-email-angelab@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282755705-28400-2-git-send-email-angelab@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Angela,

On Wed, Aug 25, 2010, Angela Bartholomaus wrote:
> Send error code 0x04 per CoreSpecv2.1, sec 4.4 for TP/SERVER/SS/BI-01-C
> ---
>  src/sdpd-request.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/sdpd-request.c b/src/sdpd-request.c
> index d56ffc2..cc9fe82 100644
> --- a/src/sdpd-request.c
> +++ b/src/sdpd-request.c
> @@ -367,7 +367,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
>  	mlen = scanned + sizeof(uint16_t) + 1;
>  	// ensure we don't read past buffer
>  	if (plen < mlen || plen != mlen + *(uint8_t *)(pdata+sizeof(uint16_t))) {
> -		status = SDP_INVALID_SYNTAX;
> +		status = SDP_INVALID_PDU_SIZE;
>  		goto done;
>  	}

I'm not sure exactly what test system you tested this with, but it
breaks TP/SERVER/SS/BI-02-C with the BITE tester with test vector
1.0.40.0. Also, this code path doesn't seem to be traversed at all for
TP/SERVER/SS/BI-01-C which the patch claims to fix. In order to get a
clean test report again from the BITE I went ahead and reverted[1] this
patch. Now both SS/BI-01-C and SS/BI-02-C are passing with the BITE.
Your other SDP patches don't seem to have any issues.

Johan

[1] http://git.kernel.org/?p=bluetooth/bluez.git;a=commitdiff;h=24dbc52388f1ef2e759d24d74cd32f93531c8857
