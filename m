Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Dec 2011 13:54:20 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] hdp_util: Fix coding style issues
Message-ID: <20111202115418.GB12339@aemeltch-MOBL1>
References: <1322823396-5941-1-git-send-email-sancane@gmail.com>
 <1322823396-5941-2-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322823396-5941-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

He All,

On Fri, Dec 02, 2011 at 11:56:32AM +0100, Santiago Carot-Nemesio wrote:
> ---
>  health/hdp_util.c |  171 +++++++++++++++++++++++++++--------------------------
>  1 files changed, 86 insertions(+), 85 deletions(-)
> 
> diff --git a/health/hdp_util.c b/health/hdp_util.c
> index e62ed46..7a234c1 100644
> --- a/health/hdp_util.c
> +++ b/health/hdp_util.c
> @@ -362,24 +362,24 @@ static gboolean register_service_protocols(struct hdp_adapter *adapter,
>  	/* set l2cap information */
>  	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
>  	l2cap_list = sdp_list_append(NULL, &l2cap_uuid);
> -	if (!l2cap_list) {
> +	if (l2cap_list == NULL) {

Is this a really better way?

Best regards 
Andrei Emeltchenko 
