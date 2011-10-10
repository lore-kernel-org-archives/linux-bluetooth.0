Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Oct 2011 10:32:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 7/9] Read temperature type characteristic
Message-ID: <20111010073224.GH4094@fusion.localdomain>
References: <1317303988-26310-1-git-send-email-sancane@gmail.com>
 <1317303988-26310-2-git-send-email-sancane@gmail.com>
 <1317303988-26310-3-git-send-email-sancane@gmail.com>
 <1317303988-26310-4-git-send-email-sancane@gmail.com>
 <1317303988-26310-5-git-send-email-sancane@gmail.com>
 <1317303988-26310-6-git-send-email-sancane@gmail.com>
 <1317303988-26310-7-git-send-email-sancane@gmail.com>
 <1317303988-26310-8-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317303988-26310-8-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Sep 29, 2011, Santiago Carot-Nemesio wrote:
> @@ -113,7 +120,29 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
>  static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
>  							gpointer user_data)
>  {
> -	/* TODO */
> +	struct characteristic *ch = user_data;
> +	struct thermometer *t = ch->t;
> +	uint8_t value[ATT_MAX_MTU];
> +	int vlen;
> +
> +	if (status != 0) {

This is correct. So why did you have "if (status)" in the previous
patch?

> +	t->type = (uint8_t) value[0];

This looks like an unnecessary explicit type-cast. The array is already
of type uint8_t.

Johan
