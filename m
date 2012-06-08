Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Jun 2012 01:51:21 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] Bluetooth: Fix SMP pairing method selection
Message-ID: <20120608045121.GB1546@joana>
References: <1338979451-15851-1-git-send-email-johan.hedberg@gmail.com>
 <1338980055-16205-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338980055-16205-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-06-06 18:54:15 +0800]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The tk_request function takes the local IO capability as the second last
> parameter and the remote IO capability as the last parameter. They were
> previously swapped: when we receive a pairing response
> req->io_capability contains the local one and rsp->io_capability the
> remote one.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: s/first/last/ in the commit message.
> 
>  net/bluetooth/smp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch has been applied to bluetooth.git, thanks.

	Gustavo
