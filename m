Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Sep 2010 10:59:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Simplify logic to calculate the BT/system clock
 latency
Message-ID: <20100922075928.GA17298@jh-x301>
References: <1285139031-1570-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285139031-1570-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Sep 22, 2010, Santiago Carot-Nemesio wrote:
> This is only a cosmetic change. Using a while loop
> we avoid direct manipulation of counter loop variable
> when error happens reading the BT clock.
> ---
>  health/mcap_sync.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)

Thanks. The patch has been pushed upstream.

> +	while ((i < 20) && (retries > 0)) {

The extra parentheses around the comparisons are unnecessary. I fixed
that in a subsequent cleanup commit. Usually we only add these extra
parentheses for binary bitwise operations such as & and | for clarity.

Johan
