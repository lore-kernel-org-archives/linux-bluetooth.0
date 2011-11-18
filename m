Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Nov 2011 11:33:52 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: making enable_hs independent from L2CAP
Message-ID: <20111118133352.GB2131@joana>
References: <1321616142-19038-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321616142-19038-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-11-18 13:35:42 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Fixes bluetooth compiling when CONFIG_BT_L2CAP is not enabled
> 
> net/built-in.o: In function `hci_dev_open':
> (.text+0xdce9a): undefined reference to `enable_hs'
> 
> Reported-by: Randy Dunlap <rdunlap@xenotime.net>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c   |    5 +++++
>  net/bluetooth/l2cap_core.c |    4 ----
>  2 files changed, 5 insertions(+), 4 deletions(-)

Applied, thanks.

	Gustavo
