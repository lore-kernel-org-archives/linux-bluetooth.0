Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Sep 2010 11:00:42 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: "Haijun.Liu" <haijun.liu@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, ville.tervo@nokia.com,
	dan.tian@atheros.com, suraj@atheros.com
Subject: Re: [PATCH 2/2] Bluetooth: Update conf_state with
 L2CAP_CONF_REQ_SENT before send config_req out in l2cap_config_req().
Message-ID: <20100930140042.GB4615@vigoh>
References: <1285836760-3234-1-git-send-email-haijun.liu@atheros.com>
 <1285836760-3234-2-git-send-email-haijun.liu@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285836760-3234-2-git-send-email-haijun.liu@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Haijun,

* Haijun.Liu <haijun.liu@atheros.com> [2010-09-30 16:52:40 +0800]:

> 
> Signed-off-by: Haijun.Liu <haijun.liu@atheros.com>
> ---
>  net/bluetooth/l2cap_core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 279f98a..9e788c2 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c

Patch has been applied to my bluetooth-next-2.6 tree with modifications
to the commit message and subject. Next time pay attention to not
overstep the 72 characters in the commit subject and do not add a "." in
the end of your subject. Thanks.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
