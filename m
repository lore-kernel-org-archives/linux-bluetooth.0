Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 May 2009 18:27:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: alokbarsode@gmail.com
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.com,
	Alok Barsode <alok.barsode@azingo.com>
Subject: Re: [PATCH 2/3] Code cleanup in adapter.c.
Message-ID: <20090504152756.GB28443@jh-x301>
References: <1241449694-17135-1-git-send-email-alok.barsode@azingo.com> <1241449694-17135-2-git-send-email-alok.barsode@azingo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1241449694-17135-2-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

This patch looks ok'ish except for the following unnecessary empty line
that it adds:

On Mon, May 04, 2009, alokbarsode@gmail.com wrote:
>  	if (dev_down == FALSE)
>  		hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE,
>  				1, &scan_mode);
>  
> +
>  	if (adapter->initialized == FALSE) {
>  		load_drivers(adapter);
>  		load_devices(adapter);

Johan
