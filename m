Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Oct 2014 13:48:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: 6lowpan: Memory leak as the skb is not freed
Message-ID: <20141002104842.GA23012@t440s.lan>
References: <1412152226-22272-1-git-send-email-jukka.rissanen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412152226-22272-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

On Wed, Oct 01, 2014, Jukka Rissanen wrote:
> The earlier multicast commit 36b3dd250dde ("Bluetooth: 6lowpan:
> Ensure header compression does not corrupt IPv6 header") lost one
> skb free which then caused memory leak.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
>  net/bluetooth/6lowpan.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
