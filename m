Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Jun 2012 23:51:44 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Andre Guedes <andre.guedes@openbossa.org>
Subject: Re: [RFC] Bluetooth: Fix using uninitialized option in RFCMode
Message-ID: <20120612025144.GB24440@joana>
References: <1339148013-4956-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339148013-4956-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2012-06-08 11:33:33 +0200]:

> If remote device sends bogus RFC option with invalid length,
> undefined options values are used. Fix this by using defaults when
> remote misbehaves.
> 
> This also fixes the following warning reported by gcc 4.7.0:
> 
> net/bluetooth/l2cap_core.c: In function 'l2cap_config_rsp':
> net/bluetooth/l2cap_core.c:3302:13: warning: 'rfc.max_pdu_size' may be used uninitialized in this function [-Wmaybe-uninitialized]
> net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.max_pdu_size' was declared here
> net/bluetooth/l2cap_core.c:3298:25: warning: 'rfc.monitor_timeout' may be used uninitialized in this function [-Wmaybe-uninitialized]
> net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.monitor_timeout' was declared here
> net/bluetooth/l2cap_core.c:3297:25: warning: 'rfc.retrans_timeout' may be used uninitialized in this function [-Wmaybe-uninitialized]
> net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.retrans_timeout' was declared here
> net/bluetooth/l2cap_core.c:3295:2: warning: 'rfc.mode' may be used uninitialized in this function [-Wmaybe-uninitialized]
> net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.mode' was declared here
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/l2cap_core.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Patch has been applied to the bluetooth.git tree. Thanks.

	Gustavo
