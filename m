Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Dec 2012 15:40:14 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Chan-yeol Park <chanyeol.park@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Fix possible deadlock in SCO code
Message-ID: <20121203174014.GA2930@joana>
References: <1339738863-6407-1-git-send-email-gustavo@padovan.org>
 <50B62135.7080507@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50B62135.7080507@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

* Chan-yeol Park <chanyeol.park@gmail.com> [2012-11-28 23:35:33 +0900]:

> Hi Gustavo
> 
> If we use the below patch, we face crash or circular locking
> dependency detected.
> *It's very easily reproduced(about 100%)
> 
> I guess once sco_sock_shutdown() is called,"sk" would be destructed.
> but due to response from remote side,
> sco_disconn_cfm(),sco_conn_del() would be called in order.
> and finally in sco_conn_del() crash or circular locking dependency
> is happened.
> because it access "sk" that is already destructed.
> 
> I think in sco_chan_del(), based on conn info, the relation between
> sk and conn should be cleaned
> like the original code before you commit.
> 
> [  104.889622] Bluetooth: [sco_sock_shutdown] sock e8856000, sk eb695000
> [  104.894666] Bluetooth: [sco_sock_clear_timer] sock eb695000 state 1
> [  104.900869] Bluetooth: [__sco_sock_close] sk eb695000 state 1
> socket e8856000
> [  104.907976] Bluetooth: [sco_sock_set_timer] sock eb695000 state 8
> timeout 400
> [  104.915106] Bluetooth: [sco_sock_release] sock e8856000, sk eb695000
> [  104.921439] Bluetooth: [sco_sock_clear_timer] sock eb695000 state 8
> [  104.927875] Bluetooth: [__sco_sock_close] sk eb695000 state 8
> socket e8856000
> [  104.938762] Bluetooth: [sco_chan_del] sk eb695000, conn ed38da60, err 104
> [  104.956861] Bluetooth: [sco_sock_kill] sk eb695000 state 9
> [  104.962321] Bluetooth: [sco_sock_destruct] sk eb695000
> [  105.071125] Bluetooth: [sco_disconn_cfm] hcon ed376000 reason 22
> [  105.075875] Bluetooth: [sco_conn_del] hcon ed376000 conn
> ed38da60, err 103
> [  105.082848] Bluetooth: [sco_conn_del] before bh_lock_sock () sk eb695000
> 
> Could you give me your opinion?

The patch is now reverted. I pushed it to bluetooth-next.

	Gustavo
