Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 May 2009 21:22:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: alokbarsode@gmail.com
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	Alok Barsode <alok.barsode@azingo.com>
Subject: Re: [PATCH 2/7] Adding set_powered method to hciops plugin.
Message-ID: <20090515182256.GA18375@jh-x301>
References: <1242131216-4081-1-git-send-email-alok.barsode@azingo.com> <1242131216-4081-2-git-send-email-alok.barsode@azingo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1242131216-4081-2-git-send-email-alok.barsode@azingo.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

I'm going through your patches now and I found at least one issue:

> +	hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE,
> +					1, SCAN_DISABLED);

This looks wrong. The last parameter should a pointer and not an integer.

Johan
