Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Apr 2011 14:53:21 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Ruiyi Zhang <Ruiyi.zhang@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Only keeping SAR bits when retransmitting one
 frame.
Message-ID: <20110418175321.GA2472@joana>
References: <1303095870-8744-1-git-send-email-Ruiyi.zhang@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1303095870-8744-1-git-send-email-Ruiyi.zhang@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ruiyi,

* Ruiyi Zhang <Ruiyi.zhang@atheros.com> [2011-04-18 11:04:30 +0800]:

> When retrasmitting one frame, only SAR bits in control field should
> be kept.
> 
> Signed-off-by: Ruiyi Zhang <Ruiyi.zhang@atheros.com>
> ---
>  net/bluetooth/l2cap_core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Good catch! Applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
