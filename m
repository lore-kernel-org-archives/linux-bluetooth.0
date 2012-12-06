Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Dec 2012 12:24:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] lib: Fix member type on
 le_read_advertising_channel_tx_power_rp
Message-ID: <20121206102456.GB2342@x220.Elisa>
References: <1354756970-13214-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354756970-13214-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Dec 05, 2012, Anderson Lizardo wrote:
> Transmit power level range is -20 <= N <= 10, thus it should be stored
> as int8_t.
> ---
>  lib/hci.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
