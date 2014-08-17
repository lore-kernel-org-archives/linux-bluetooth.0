Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/4] Bluetooth: Use zero timeout for immediate scheduling
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1408311704-31747-1-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 17 Aug 2014 17:15:18 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <454B80C9-56AE-4392-A25F-448981EF6721@holtmann.org>
References: <1408311704-31747-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There's no point in passing a "small" timeout to queue_delayed_work() to
> try to get the callback faster scheduled. Passing 0 is perfectly valid
> and will cause a shortcut to a direct queue_work().
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

