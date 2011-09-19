Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Sep 2011 16:30:19 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 01/13] Bluetooth: Fix sending wrong authentication
 requirements
Message-ID: <20110919193018.GC2643@joana>
References: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
 <1314313359-12652-2-git-send-email-vcgomes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314313359-12652-2-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-08-25 20:02:27 -0300]:

> From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> 
> Until we support any pairing method (Passkey Entry, OOB) that gives
> MITM protection we shouldn't send that we have MITM protection.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/smp.c |   19 ++-----------------
>  1 files changed, 2 insertions(+), 17 deletions(-)

Patch has been applied, thanks.

	Gustavo
