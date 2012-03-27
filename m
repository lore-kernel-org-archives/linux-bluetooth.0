Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Mar 2012 14:52:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mike Brudevold <puffy.taco@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Michael Brudevold <michael.brudevold@logicpd.com>
Subject: Re: [PATCH] avdtp: fix audio source init check
Message-ID: <20120327115229.GI14481@x220>
References: <1332515027-31529-1-git-send-email-puffy.taco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332515027-31529-1-git-send-email-puffy.taco@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

On Fri, Mar 23, 2012, Mike Brudevold wrote:
> From: Michael Brudevold <michael.brudevold@logicpd.com>
> 
> ---
>  audio/avdtp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/audio/avdtp.c b/audio/avdtp.c
> index cd66fd4..8b36f0b 100644
> --- a/audio/avdtp.c
> +++ b/audio/avdtp.c
> @@ -1520,7 +1520,7 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
>  	case AVDTP_SEP_TYPE_SINK:
>  		if (!dev->source) {
>  			btd_device_add_uuid(dev->btd_dev, A2DP_SOURCE_UUID);
> -			if (!dev->sink) {
> +			if (!dev->source) {
>  				error("Unable to get a audio source object");
>  				err = AVDTP_BAD_STATE;
>  				goto failed;

Applied. Thanks.

Johan
