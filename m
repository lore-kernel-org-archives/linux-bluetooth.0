Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Oct 2011 16:54:15 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 12/16] Bluetooth: EWS: recalculate L2CAP header size
Message-ID: <20111013195414.GC20892@joana>
References: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1318329476-30153-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318329476-30153-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-10-11 13:37:52 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Recalculate length of L2CAP header based on Control field length.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   21 ++++++++++++++++++---
>  1 files changed, 18 insertions(+), 3 deletions(-)

Applied, thanks.

	Gustavo
