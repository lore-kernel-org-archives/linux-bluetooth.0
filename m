Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Aug 2011 16:30:06 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Szymon Janc <szymon@janc.net.pl>
Cc: linux-bluetooth@vger.kernel.org,
	Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] Don't use cmd_timer to timeout HCI reset command
Message-ID: <20110801193006.GC18480@joana>
References: <1311713214-2414-1-git-send-email-szymon@janc.net.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311713214-2414-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon@janc.net.pl> [2011-07-26 22:46:54 +0200]:

> No command should be send before Command Complete event for HCI
> reset is received. This fix regression introduced by commit
> 6bd32326cda(Bluetooth: Use proper timer for hci command timout)
> for chips whose reset command takes longer to complete (e.g. CSR)
> resulting in next command being send before HCI reset completed.
> 
> Signed-off-by: Szymon Janc <szymon@janc.net.pl>
> ---
>  net/bluetooth/hci_core.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

Applied, thanks.

	Gustavo
