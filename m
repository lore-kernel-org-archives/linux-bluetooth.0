Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Nov 2011 18:31:54 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Convert power off mechanism to use
 delayed_work
Message-ID: <20111107203153.GE3707@joana>
References: <1320696964-3582-1-git-send-email-johan.hedberg@gmail.com>
 <1320696964-3582-3-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320696964-3582-3-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-11-07 22:16:04 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The power off code doesn't need to use its own custom timer since the
> delayed_work API provides the exact same functionality.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    3 +-
>  net/bluetooth/hci_core.c         |   39 ++++++++++++-------------------------
>  net/bluetooth/mgmt.c             |    8 ++++--
>  3 files changed, 19 insertions(+), 31 deletions(-)

All 3 patches applied, thanks.

	Gustavo
