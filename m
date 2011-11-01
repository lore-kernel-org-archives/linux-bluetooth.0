Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Nov 2011 14:10:37 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Initialize tx_win_max for fixed channel
Message-ID: <20111101161037.GD2580@joana>
References: <1319615079-11734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319615079-11734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-10-26 10:44:39 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> tx_win_max is initialized during L2CAP configuration phase. For fixed
> channel (like A2MP) we want to have it initialized during channel setup.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_sock.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

This one doesn't apply anymore, please rebase. Thanks.

	Gustavo
