Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2 1/3] Bluetooth: Fix using global connectable settings for adv
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427571540-29166-1-git-send-email-armansito@chromium.org>
Date: Sat, 28 Mar 2015 13:33:53 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <45F90B23-1B76-44E4-99CE-5AD7B6B21D4B@holtmann.org>
References: <1427571540-29166-1-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch fixes a bug where ADV_NONCONN_IND was being used for
> advertising instances >0 while the global connectable setting was
> set to "on".
> 
> Signed-off-by: Arman Uguray <armansito@chromium.org>
> ---
> net/bluetooth/mgmt.c | 14 ++++++++++----
> 1 file changed, 10 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

