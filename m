Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 1/2] Bluetooth: btmrvl: remove extra newline character
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1416825653-32530-1-git-send-email-akarwar@marvell.com>
Date: Wed, 3 Dec 2014 16:36:55 +0000
Cc: linux-bluetooth@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Message-Id: <1251BE60-5D5B-412D-90C3-2CA26838EE5C@holtmann.org>
References: <1416825653-32530-1-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> BT_INFO/BT_DBG etc. already takes care of adding a newline
> An extra newline character inside message is removed in this
> patch.
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_main.c | 14 +++++++-------
> drivers/bluetooth/btmrvl_sdio.c |  4 ++--
> 2 files changed, 9 insertions(+), 9 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

