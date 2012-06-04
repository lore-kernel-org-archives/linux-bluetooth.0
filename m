Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Gustavo Padovan <gustavo@padovan.org>
Subject: Re: [RFC] Bluetooth: Fix compile warning in l2cap_core.c
Date: Mon, 4 Jun 2012 09:17:55 +0200
CC: Andre Guedes <andre.guedes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1338507556-10920-1-git-send-email-andre.guedes@openbossa.org> <20120601230918.GH24769@joana>
In-Reply-To: <20120601230918.GH24769@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID: <201206040917.56331.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> * Andre Guedes <andre.guedes@openbossa.org> [2012-05-31 20:39:16 -0300]:
> 
> > This patch fixes the following warning reported by gcc 4.7.0:
> > 
> > net/bluetooth/l2cap_core.c: In function 'l2cap_config_rsp':
> > net/bluetooth/l2cap_core.c:3302:13: warning: 'rfc.max_pdu_size' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.max_pdu_size' was declared here
> > net/bluetooth/l2cap_core.c:3298:25: warning: 'rfc.monitor_timeout' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.monitor_timeout' was declared here
> > net/bluetooth/l2cap_core.c:3297:25: warning: 'rfc.retrans_timeout' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.retrans_timeout' was declared here
> > net/bluetooth/l2cap_core.c:3295:2: warning: 'rfc.mode' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.mode' was declared here
> 
> So I think this is a false positive, I've seen this warning here for more than
> a month, since I updated to fedora 17.
> At some people will disable this warning in the kernel compile process if this
> appear in others places in the kernel as false positive too.

What if remote device misbehaves and sends bogus L2CAP_CONF_RFC i.e. with wrong length?


-- 
BR
Szymon
