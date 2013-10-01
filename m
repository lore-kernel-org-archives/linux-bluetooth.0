Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [RFC 2/3] Bluetooth: Move set_bredr_scan() to a more convenient location
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380640922-18647-3-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 1 Oct 2013 17:53:45 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <83BA41B5-C841-485D-94F2-DFFF66C318D6@holtmann.org>
References: <1380640922-18647-1-git-send-email-johan.hedberg@gmail.com> <1380640922-18647-3-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The static set_bredr_scan function will soon be reused by a new
> set_bredr method. This trivial patch moves the function to a new
> location within the mgmt.c file where it can be reused without requiring
> forward declarations.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 40 ++++++++++++++++++++--------------------
> 1 file changed, 20 insertions(+), 20 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

