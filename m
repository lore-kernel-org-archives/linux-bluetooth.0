Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Nov 2011 14:46:51 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix command complete/status for discovery
 commands
Message-ID: <20111101164651.GK2580@joana>
References: <1320160004-2012-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320160004-2012-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-11-01 17:06:44 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch adds the necessary code to send proper command status or
> command complete events to the start/stop discovery management commands.
> Before this patch these events were completely missing.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_event.c        |    2 ++
>  net/bluetooth/mgmt.c             |   27 +++++++++++++++++++++++++++
>  3 files changed, 30 insertions(+), 0 deletions(-)

Patch was applied, thanks.

	Gustavo
