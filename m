Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Nov 2013 12:14:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/client: Fix uninitialized variable
Message-ID: <20131104101440.GD2752@x220.p-661hnu-f1>
References: <1383558940-18520-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383558940-18520-1-git-send-email-jerzy.kasenberg@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Mon, Nov 04, 2013, Jerzy Kasenberg wrote:
> Pin accept variable was intended to be set to 1
> only when pin was typed by user. If no pin was given
> accept should be set to 0. This patch fixes this.
> ---
>  android/client/if-bt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
