Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Sep 2011 16:38:10 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 09/13] Bluetooth: Fix not setting a pending security
 level
Message-ID: <20110919193810.GG2643@joana>
References: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
 <1314313359-12652-10-git-send-email-vcgomes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314313359-12652-10-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-08-25 20:02:35 -0300]:

> From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> 
> For slave initiated security, we should set a default security level,
> for now BT_SECURITY_MEDIUM.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/smp.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Applied, thanks.

	Gustavo
