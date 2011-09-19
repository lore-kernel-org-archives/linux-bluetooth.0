Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Sep 2011 16:35:16 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 03/13] Revert "Bluetooth: Add support for
 communicating keys with userspace"
Message-ID: <20110919193516.GE2643@joana>
References: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
 <1314313359-12652-4-git-send-email-vcgomes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314313359-12652-4-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-08-25 20:02:29 -0300]:

> From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> 
> This reverts commit 5a0a8b49746771fba79866fb9185ffa051a6a183.
> 
> If we use separate messages and list for SMP specific keys we can
> simplify the code.
> 
> Conflicts:
> 
> 	net/bluetooth/mgmt.c
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |   60 ++++++++++++-------------------------------------
>  1 files changed, 15 insertions(+), 45 deletions(-)

Applied, thanks.

	Gustavo
