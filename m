Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Oct 2011 10:35:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 8/9] Read measurement interval characteristic
Message-ID: <20111010073511.GI4094@fusion.localdomain>
References: <1317303988-26310-1-git-send-email-sancane@gmail.com>
 <1317303988-26310-2-git-send-email-sancane@gmail.com>
 <1317303988-26310-3-git-send-email-sancane@gmail.com>
 <1317303988-26310-4-git-send-email-sancane@gmail.com>
 <1317303988-26310-5-git-send-email-sancane@gmail.com>
 <1317303988-26310-6-git-send-email-sancane@gmail.com>
 <1317303988-26310-7-git-send-email-sancane@gmail.com>
 <1317303988-26310-8-git-send-email-sancane@gmail.com>
 <1317303988-26310-9-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317303988-26310-9-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Thu, Sep 29, 2011, Santiago Carot-Nemesio wrote:
> @@ -148,7 +192,31 @@ static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
>  static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
>  							gpointer user_data)
>  {
> -	/* TODO */
> +	struct characteristic *ch = user_data;
> +	uint8_t value[ATT_MAX_MTU];
> +	uint16_t *p, interval;
> +	int vlen;
> +
> +	if (status != 0) {
> +		DBG("Measurement Interval value read failed: %s",
> +							att_ecode2str(status));
> +		return;
> +	}
> +
> +	if (!dec_read_resp(pdu, len, value, &vlen)) {
> +		DBG("Protocol error\n");
> +		return;
> +	}
> +
> +	if (vlen < 2) {
> +		DBG("Invalid Interval received");
> +		return;
> +	}
> +
> +	p = (uint16_t *) value;
> +	interval = btohs(*p);

This looks like a potential unaligned access issue. Probably safer to
use bt_get_unaligned here.

Johan
