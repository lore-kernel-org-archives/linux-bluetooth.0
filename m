Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Nov 2011 12:26:18 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: Initialize tx_win_max for fixed channel
Message-ID: <20111103142618.GB23913@joana>
References: <1320220630-13551-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320220630-13551-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-11-02 09:57:10 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> tx_win_max is initialized during L2CAP configuration phase. For fixed
> channels (e.g. A2MP) we want to have it initialized when channel is
> created.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_sock.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Applied, thanks.

	Gustavo
