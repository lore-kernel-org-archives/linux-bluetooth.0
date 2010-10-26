Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Bluetooth: Fix system crash caused by del_timer()
From: Marcel Holtmann <marcel@holtmann.org>
To: Haijun Liu <haijun.liu@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1287644956-12602-1-git-send-email-haijun.liu@atheros.com>
References: <1287644956-12602-1-git-send-email-haijun.liu@atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 26 Oct 2010 16:24:53 +0200
Message-ID: <1288103093.3613.21.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Haijun,

> At UPF37, during test session of bt3.0 with Marvel, found that in
> l2cap_chan_del() using del_timer() caused l2cap_monitor_timeout()
> be called after the sock was freed, so it raised a system crash.
> So I just replaced del_timer() with del_timer_sync() to solve it.
> 
> Signed-off-by: Haijun Liu <haijun.liu@atheros.com>

looks good to me and if Gustavo agrees, then

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


