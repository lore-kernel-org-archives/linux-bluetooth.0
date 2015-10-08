Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH 0/6] Bluetooth: 6lowpan cleanups
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1444125804-15577-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 8 Oct 2015 10:46:04 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F5EA2256-B682-49ED-92A8-F6CBBA6F17D4@holtmann.org>
References: <1444125804-15577-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's a set of initial cleanups for the 6lowpan code which I came up
> with as I started preparing to implement the new mgmt channel.
> 
> Johan Hedberg (6):
>      Bluetooth: 6lowpan: Fix imtu & omtu values
>      Bluetooth: 6lowpan: Remove redundant (and incorrect) MPS assignments
>      Bluetooth: 6lowpan: Remove redundant BT_CONNECTED assignment
>      Bluetooth: 6lowpan: Remove unnecessary chan_open() function
>      Bluetooth: 6lowpan: Rename confusing 'pchan' variables
>      Bluetooth: 6lowpan: Remove unnecessary chan_get() function
> 
> net/bluetooth/6lowpan.c | 72 ++++++++++++++++--------------------------------
> 1 file changed, 24 insertions(+), 48 deletions(-)

all 6 patches have been applied to bluetooth-next tree.

Regards

Marcel

