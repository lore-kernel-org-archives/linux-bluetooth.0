Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 May 2011 16:18:48 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove unnecessary use of hci_dev_list_lock
Message-ID: <20110530191848.GD2556@joana>
References: <1305917441-26680-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305917441-26680-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-05-20 11:50:41 -0700]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The get_connections function has no need to use hci_dev_list_lock. The
> code was there probably because of a copy-paste mistake.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)

Patch has been applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
