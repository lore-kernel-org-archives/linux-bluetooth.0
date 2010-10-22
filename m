Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Oct 2010 15:18:25 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Haijun Liu <haijun.liu@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] Bluetooth: Fix system crash caused by
 del_timer()
Message-ID: <20101022171825.GA980@vigoh>
References: <1287714419-13545-1-git-send-email-haijun.liu@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287714419-13545-1-git-send-email-haijun.liu@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Haijun Liu <haijun.liu@atheros.com> [2010-10-22 10:26:58 +0800]:

> During test session with another vendor's bt stack, found that in
> l2cap_chan_del() using del_timer() caused l2cap_monitor_timeout()
> be called after the sock was freed, so it raised a system crash.
> So I just replaced del_timer() with del_timer_sync() to solve it.

NAK on this. If you read the del_timer_sync() documentation you can
see that you can't call del_timer_sync() on interrupt context. The
possible solution here is to check in the beginning of
l2cap_monitor_timeout() if your sock is still valid.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
