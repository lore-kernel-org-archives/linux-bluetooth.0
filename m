Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jan 2012 23:00:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	marcel@holtmann.org, Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] net: bluetooth: Fix 'enable_hs' type
Message-ID: <20120110210042.GA7954@x220.ger.corp.intel.com>
References: <1326227630-2556-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1326227630-2556-1-git-send-email-festevam@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fabio,

On Tue, Jan 10, 2012, Fabio Estevam wrote:
> Fix the following build warning:
> 
>   CC [M]  net/bluetooth/hci_core.o
> net/bluetooth/hci_core.c: In function ‘__check_enable_hs’:
> net/bluetooth/hci_core.c:2587: warning: return from incompatible pointer type
> 
> module_param in hci_core.c passes 'enable_hs' as bool format, so fix this variable definition type.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  include/net/bluetooth/hci.h |    2 +-
>  net/bluetooth/hci_core.c    |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

The patch has been applied to my bluetooth-next tree. Don't you get the
same warning for enable_mgmt and enable_le as well? Those seem to be
declared in a similar manner.

Johan
