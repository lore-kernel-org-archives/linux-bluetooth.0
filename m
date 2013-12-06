Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Dec 2013 07:55:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Bluetooth: Use min_t for calculating chan->imtu
Message-ID: <20131206055539.GA4622@x220.p-661hnu-f1>
References: <1386306533-32239-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386306533-32239-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Dec 06, 2013, johan.hedberg@gmail.com wrote:
> Since there's a nice convenient helper for calculating the minimum of
> two values, let's use that one.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/l2cap_core.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Too early in the morning for me - sending a v3 with a proper subject
(with mps instead of imtu in it).

Johan
