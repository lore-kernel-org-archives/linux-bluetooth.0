Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Oct 2013 13:28:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 3/6] android: Add basic mgmt initialization sequence
Message-ID: <20131016102809.GC14764@x220.p-661hnu-f1>
References: <1381913215-17957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381913215-17957-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381913215-17957-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Oct 16, 2013, Andrei Emeltchenko wrote:
> +static void read_index_list_complete(uint8_t status, uint16_t length,
> +					const void *param, void *user_data)
> +{
> +	const struct mgmt_rp_read_index_list *rp = param;
> +	uint16_t num;
> +	int i;
> +
> +	info(__func__);

Seems like this one should just be a DBG("") (or just remove it
completely).

> +	num = btohs(rp->num_controllers);
> +
> +	DBG("%s: Number of controllers: %u", __func__, num);

Again, the __func__ seems redundant since this is a DBG() call.

Johan
