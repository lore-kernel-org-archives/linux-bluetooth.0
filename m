Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Apr 2011 21:26:29 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix segfault when removing device
Message-ID: <20110426202629.GA32737@jh-x301>
References: <1303757290-4147-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1303757290-4147-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Mon, Apr 25, 2011, Bruna Moreira wrote:
> The device_register_services() function uses g_slist_concat(), therefore
> the passed list should not be freed. The primary_cb() function from GATT
> library was freeing the services list using discover_primary_free(). To
> fix this, the device_register_services() function receives a copy of
> services list if called from inside a gatt_discover_primary() callback.
> ---
>  src/device.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
