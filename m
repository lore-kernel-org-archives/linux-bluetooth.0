Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jul 2012 18:13:42 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 08/20] Bluetooth: AMP: Remote AMP ctrl definitions
Message-ID: <20120724211342.GF20029@joana>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343136121-22476-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-07-24 16:21:49 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Create remote AMP controllers structure. It is used to keep information
> about discovered remote AMP controllers by A2MP protocol.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/a2mp.h |    3 ++
>  include/net/bluetooth/pal.h  |   14 ++++++++
>  net/bluetooth/a2mp.c         |    5 +++
>  net/bluetooth/pal.c          |   81 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 103 insertions(+)
> 
> diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
> index 012f573..8ba236c 100644
> --- a/include/net/bluetooth/a2mp.h
> +++ b/include/net/bluetooth/a2mp.h
> @@ -29,6 +29,9 @@ struct amp_mgr {
>  
>  	struct list_head	phy_links;
>  	struct mutex		phy_links_lock;
> +
> +	struct list_head	amp_ctrls;
> +	struct mutex		amp_ctrls_lock;

Have you checked for RCU here, are they worthwhile? and why is it better than
spinlocks?  This is for both locks above.

	Gustavo
