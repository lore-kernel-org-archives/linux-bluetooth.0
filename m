Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Oct 2010 15:34:11 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Haijun Liu <haijun.liu@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] Bluetooth: Fix system crash bug of no send
 queue protect
Message-ID: <20101022173411.GB980@vigoh>
References: <1287714419-13545-1-git-send-email-haijun.liu@atheros.com>
 <1287714419-13545-2-git-send-email-haijun.liu@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287714419-13545-2-git-send-email-haijun.liu@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Haijun Liu <haijun.liu@atheros.com> [2010-10-22 10:26:59 +0800]:

> During test session with another vendor's bt stack, found that
> without lock protect for TX_QUEUE(sk) will cause system crash while
> data transfer over AMP controller. So I just add lock protect for
> TX_QUEUE(sk).

We already use the default socket lock protection. Is it not working for
you? Why? Could you show a crash case that requires your patch to fix
it?

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
