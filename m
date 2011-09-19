Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Sep 2011 16:33:28 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 02/13] Bluetooth: Use the LTK after receiving a LE
 Security Request
Message-ID: <20110919193327.GD2643@joana>
References: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
 <1314313359-12652-3-git-send-email-vcgomes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314313359-12652-3-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-08-25 20:02:28 -0300]:

> From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> 
> When receiving a security request from the remote device we should find
> if there is already a LTK associated with the remote device, if found
> we should use it to encrypt the link.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/smp.c |   46 ++++++++++++++++++++++++++++------------------
>  1 files changed, 28 insertions(+), 18 deletions(-)

Applied, thanks.

	Gustavo
