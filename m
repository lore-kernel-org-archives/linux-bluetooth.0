Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Oct 2014 13:48:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: 6lowpan: Avoid memory leak if memory
 allocation fails
Message-ID: <20141002104854.GB23012@t440s.lan>
References: <1412152257-22316-1-git-send-email-jukka.rissanen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412152257-22316-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

On Wed, Oct 01, 2014, Jukka Rissanen wrote:
> If skb_unshare() returns NULL, then we leak the original skb.
> Solution is to use temp variable to hold the new skb.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
>  net/bluetooth/6lowpan.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
