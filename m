Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 0/3] Bluetooth: Cleanups to syncronous request functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1447237463-29233-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 11 Nov 2015 21:51:49 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E76C6776-4D5F-4DEE-A71F-366729A320E6@holtmann.org>
References: <1447237463-29233-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's a couple of initial cleanups to the new code in hci_request.c.
> The patches are essentially removing the *_complete() functions that
> are now unecessary.
> 
> Johan
> 
> -----------------
> Johan Hedberg (3):
>      Bluetooth: Pass inquiry length to bredr_inquiry()
>      Bluetooth: Simplify le_scan_disable_work()
>      Bluetooth: Remove unnecessary le_scan_restart_work_complete() function
> 
> net/bluetooth/hci_request.c | 204 +++++++++++++++++--------------------------
> 1 file changed, 80 insertions(+), 124 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

