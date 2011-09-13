Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Sep 2011 17:32:03 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 4/7] Bluetooth: parse EFS in l2cap config request
Message-ID: <20110913203203.GF16856@joana>
References: <1314875256-6904-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1314875256-6904-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314875256-6904-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-09-01 14:07:33 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Add parsing extended flowspec option in L2cap config request
> Based upon haijun.liu <haijun.liu@atheros.com> series of patches
> (sent Sun, 22 Aug 2010)
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   70 ++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 68 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 4167cb0..b7f36da 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -338,6 +338,14 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
>  		chan->omtu = L2CAP_DEFAULT_MTU;
>  	}
>  
> +	if (!disable_flowspec) {

We don't need this check, it doesn't hurt set these param wihout flowspec
enabled.

	Gustavo
