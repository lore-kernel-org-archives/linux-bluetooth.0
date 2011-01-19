Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 19 Jan 2011 01:38:31 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Jesper Juhl <jj@chaosbits.net>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] bluetooth: Fix failure to release lock in
 read_index_list() when mem alloc fails.
Message-ID: <20110119033831.GB7762@joana>
References: <alpine.LNX.2.00.1101140000541.11347@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1101140000541.11347@swampdragon.chaosbits.net>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jesper,

* Jesper Juhl <jj@chaosbits.net> [2011-01-14 00:18:49 +0100]:

> If alloc_skb() fails in read_index_list() we'll return -ENOMEM without 
> releasing 'hci_dev_list_lock'.
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
>  mgmt.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Patch has been applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
