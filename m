Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 11 Apr 2016 15:00:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: kernelnewbies@kernelnewbies.org, linux-bluetooth@vger.kernel.org
Subject: Re: BT over SDIO
Message-ID: <20160411120058.GA15243@t440s.P-661HNU-F1>
References: <CAHhAz+hDBUz-PN5CNce8ujaiPnNA1H4f7sdQUTxWF2rVq6r2cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHhAz+hDBUz-PN5CNce8ujaiPnNA1H4f7sdQUTxWF2rVq6r2cA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sekhar,

On Mon, Apr 11, 2016, Muni Sekhar wrote:
> Does BlueZ supports for Bluetooth devices over SDIO protocol?
>  If so any links to test procedure will be useful.

There's a btsdio driver for that. See drivers/bluetooth/btsdio.c in the
kernel source tree.

Johan
