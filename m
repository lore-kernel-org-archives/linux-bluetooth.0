Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Feb 2012 13:35:18 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix invalid memory access when there's no SMP
 channel
Message-ID: <20120201213518.GA30165@x220.globalsuite.net>
References: <1328131676-29171-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328131676-29171-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, Feb 01, 2012, Vinicius Costa Gomes wrote:
> We only should try to free the SMP channel that was created if there
> is a pending SMP session.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/smp.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
