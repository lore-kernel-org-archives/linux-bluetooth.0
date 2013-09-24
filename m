Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 08/12] bluetooth: Remove extern from function prototypes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <e9994a2b839277a9237364b59e655060f1fcb957.1379961014.git.joe@perches.com>
Date: Tue, 24 Sep 2013 06:24:54 +0200
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <D711EDE5-05F9-47F3-9A57-AFCD065D900D@holtmann.org>
References: <445209f8885ccd8234fa787c30d63e63fc7917d7.1379961014.git.joe@perches.com> <e9994a2b839277a9237364b59e655060f1fcb957.1379961014.git.joe@perches.com>
To: Joe Perches <joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joe,

> There are a mix of function prototypes with and without extern
> in the kernel sources.  Standardize on not using extern for
> function prototypes.
> 
> Function prototypes don't need to be written with extern.
> extern is assumed by the compiler.  Its use is as unnecessary as
> using auto to declare automatic/local variables in a block.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> include/net/bluetooth/bluetooth.h | 16 ++++++++--------
> include/net/bluetooth/hci_core.h  | 23 +++++++++++------------
> include/net/bluetooth/rfcomm.h    |  4 ++--
> 3 files changed, 21 insertions(+), 22 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

