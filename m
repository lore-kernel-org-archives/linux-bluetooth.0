Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 10 Feb 2011 16:11:33 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: linux-kernel@vger.kernel.org, security@kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] bluetooth: l2cap: fix 1 byte infoleak to userspace
Message-ID: <20110210181133.GA2173@joana>
References: <1297360783-21452-1-git-send-email-segoon@openwall.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297360783-21452-1-git-send-email-segoon@openwall.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vasiliy,

* Vasiliy Kulikov <segoon@openwall.com> [2011-02-10 20:59:42 +0300]:

> Structure l2cap_options has one padding byte between max_tx and
> txwin_size fields.  This byte in "opts" is copied to userspace
> uninitialized.
> 
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
> ---
>  Compile tested only.
> 
>  net/bluetooth/l2cap_sock.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Patch has been applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
