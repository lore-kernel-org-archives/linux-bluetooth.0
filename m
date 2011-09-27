Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 11:21:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Definition for hcidump to decode Ext Window Size
Message-ID: <20110927082101.GA3952@dell>
References: <1314003103-31042-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314003103-31042-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Aug 22, 2011, Emeltchenko Andrei wrote:
> ---
>  lib/l2cap.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/l2cap.h b/lib/l2cap.h
> index 55fe88b..a40cb6c 100644
> --- a/lib/l2cap.h
> +++ b/lib/l2cap.h
> @@ -175,6 +175,7 @@ typedef struct {
>  #define L2CAP_CONF_RFC		0x04
>  #define L2CAP_CONF_FCS		0x05
>  #define L2CAP_CONF_EFS		0x06
> +#define L2CAP_CONF_EWS		0x07
>  
>  #define L2CAP_CONF_MAX_SIZE	22

Applied (with a slightly refined commit message). Thanks.

Johan
