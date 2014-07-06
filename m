Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix updating background scan for LE connect complete
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404650663-4037-1-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 6 Jul 2014 15:05:30 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C97562AC-025C-4AA4-B399-D2A26BE2D463@holtmann.org>
References: <1404650663-4037-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we get an LE connection complete event we should restart background
> scanning if there are any any devices needing it. So far the code was
> only making the decision based on whether the completed connection had
> any stored parameters or not. This patch ensures that we trigger
> background scanning always when necessary.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

