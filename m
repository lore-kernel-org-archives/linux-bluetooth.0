Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 14 Feb 2011 12:35:32 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: linux-kernel@vger.kernel.org, security@kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	"David S. Miller" <davem@davemloft.net>, Tejun Heo <tj@kernel.org>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] bluetooth: bnep: fix buffer overflow
Message-ID: <20110214143532.GA2597@joana>
References: <1297680871-11617-1-git-send-email-segoon@openwall.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297680871-11617-1-git-send-email-segoon@openwall.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vasiliy,

* Vasiliy Kulikov <segoon@openwall.com> [2011-02-14 13:54:31 +0300]:

> Struct ca is copied from userspace.  It is not checked whether the "device"
> field is NULL terminated.  This potentially leads to BUG() inside of
> alloc_netdev_mqs() and/or information leak by creating a device with a name
> made of contents of kernel stack.
> 
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
> ---
>  Compile tested.
> 
>  net/bluetooth/bnep/sock.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
