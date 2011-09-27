Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:19:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix characteristic property on GATT example plugin
Message-ID: <20110927091954.GT3952@dell>
References: <1316573825-31326-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316573825-31326-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Sep 20, 2011, Anderson Lizardo wrote:
> Any GATT characteristics which have a Client Characteristic
> Configuration must have "Notify" property set.
> ---
>  plugins/gatt-example.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
