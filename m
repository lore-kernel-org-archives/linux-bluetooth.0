Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Jun 2012 20:00:52 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix checking the wrong flag when accepting a
 socket
Message-ID: <20120601230052.GF24769@joana>
References: <1338515619-7448-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338515619-7448-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2012-05-31 22:53:39 -0300]:

> Most probably a typo, the check should have been for BT_SK_DEFER_SETUP
> instead of BT_DEFER_SETUP (which right now only represents a socket
> option).
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/af_bluetooth.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch has been applied to bluetooth-next. thanks.

	Gustavo
