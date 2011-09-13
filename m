Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Sep 2011 18:38:35 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Bluetooth: Move SMP crypto functions to a
 workqueue
Message-ID: <20110913213835.GG16856@joana>
References: <1315243891-21875-1-git-send-email-vinicius.gomes@openbossa.org>
 <1315243891-21875-3-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1315243891-21875-3-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-09-05 14:31:31 -0300]:

> The function crypto_blkcipher_setkey() called by smp_e()
> can sleep, so all the crypto work has to be moved to
> hci_dev workqueue.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/smp.h |    9 ++-
>  net/bluetooth/l2cap_core.c  |    2 +-
>  net/bluetooth/smp.c         |  277 +++++++++++++++++++++++++++----------------
>  3 files changed, 185 insertions(+), 103 deletions(-)


These two patches have been applied. Thanks.

btw, my tree is now hosted at https://github.com/padovan/bluetooth-next

	Gustavo
