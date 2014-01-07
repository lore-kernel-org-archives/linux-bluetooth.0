Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Jan 2014 11:33:47 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Fix 6loWPAN peer lookup
Message-ID: <20140107133347.GA10662@joana>
References: <1389096468-2917-1-git-send-email-claudio.takahasi@openbossa.org>
 <1389096468-2917-2-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389096468-2917-2-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

2014-01-07 Claudio Takahasi <claudio.takahasi@openbossa.org>:

> This patch fixes peer address lookup for 6loWPAN over Bluetooth Low
> Energy links.
> 
> ADDR_LE_DEV_PUBLIC, and ADDR_LE_DEV_RANDOM are the values allowed for
> "dst_type" field in the hci_conn struct for LE links.
> 
> Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
> ---
>  net/bluetooth/6lowpan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

	Gustavo
