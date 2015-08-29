Return-Path: <cyrus@holtmann.org>
Date: Sat, 29 Aug 2015 06:20:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] emulator: Fix LE Connection Complete Event data
Message-ID: <20150829032025.GA8367@t440s>
References: <1440690893-30384-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440690893-30384-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Thu, Aug 27, 2015, Mariusz Skamra wrote:
> +static void le_conn_complete(struct btdev *btdev, const void *cmd,
> +								uint8_t status)
>  {
>  	char buf[1 + sizeof(struct bt_hci_evt_le_conn_complete)];
>  	struct bt_hci_evt_le_conn_complete *cc = (void *) &buf[1];
> +	const struct bt_hci_cmd_le_create_conn *lecc = cmd;

Why the void pointer in the function parameters and then casting it to
the actual one? It'd be simpler and safer if you just passed this as the
right type from the start.

Johan
