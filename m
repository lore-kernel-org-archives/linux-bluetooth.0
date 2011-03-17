Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Mar 2011 15:29:16 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: Fix missing hci_dev_lock_bh in
 user_confirm_reply
Message-ID: <20110317182916.GE2214@joana>
References: <1300278577-23068-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300278577-23068-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-03-16 14:29:34 +0200]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> The code was correctly calling _unlock at the end of the function but
> there was no actual _lock call anywhere.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
>  net/bluetooth/mgmt.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
