Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 04/39] pcmcia: use pcmcia_loop_config in bluetooth
	drivers
From: Marcel Holtmann <marcel@holtmann.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pcmcia@lists.infradead.org, linux-bluetooth@vger.kernel.org
In-Reply-To: <1219085610-12289-4-git-send-email-linux@dominikbrodowski.net>
References: <20080818185025.GA11647@comet.dominikbrodowski.net>
	 <1219085610-12289-4-git-send-email-linux@dominikbrodowski.net>
Content-Type: text/plain
Date: Mon, 18 Aug 2008 21:57:11 +0200
Message-Id: <1219089431.7591.66.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dominik,

> Use the config loop helper in bluetooth pcmcia drivers.
> 
> CC: Marcel Holtmann <marcel@holtmann.org>
> CC: linux-bluetooth@vger.kernel.org
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

I know that the Bluetooth PCMCIA drivers are not the best examples for
coding style, but please double check your whitespaces/tabs. We don't
wanna make it worse.

> -	return get_tuple(handle, tuple, parse);
> +        unsigned long try = (unsigned long) priv_data;
> +
> +       if (cf->vpp1.present & (1 << CISTPL_POWER_VNOM))
> +               p_dev->conf.Vpp = cf->vpp1.param[CISTPL_POWER_VNOM] / 10000;

This is an obvious case where something is wrong.

Regards

Marcel


