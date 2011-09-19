Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Sep 2011 16:39:08 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 11/13] Bluetooth: Remove support for other SMP keys
 than the LTK
Message-ID: <20110919193908.GH2643@joana>
References: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
 <1314313359-12652-12-git-send-email-vcgomes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314313359-12652-12-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-08-25 20:02:37 -0300]:

> From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> 
> For now, only the LTK is properly supported. We are able to receive
> and generate the other types of keys, but we are not able to use
> them. So it's better not request them to be distributed.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/smp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied, thanks.

	Gustavo
