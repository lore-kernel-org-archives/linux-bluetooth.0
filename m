Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v2] Bluetooth: Prevent buffer overflow for large
 advertisement data
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1524210384-19845-1-git-send-email-chriz.chow@aminocom.com>
Date: Mon, 23 Apr 2018 19:58:43 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        Szymon Janc <szymon.janc@codecoup.pl>,
        Chriz Chow <chriz.chow@aminocom.com>
Message-Id: <6CA9D034-6A25-4D8C-80F1-A147FC94351F@holtmann.org>
References: <1646173.KpzMEjoeCb@ix>
 <1524210384-19845-1-git-send-email-chriz.chow@aminocom.com>
To: Chriz Chow <cmcvista@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chriz,

> There are some controllers sending out advertising data with illegal
> length value which is longer than HCI_MAX_AD_LENGTH, causing the
> buffer last_adv_data overflows. To avoid these controllers from
> overflowing the buffer, we do not process the advertisement data
> if its length is incorrect.
> 
> Signed-off-by: Chriz Chow <chriz.chow@aminocom.com>
> ---
> net/bluetooth/hci_event.c | 12 ++++++++----
> 1 file changed, 8 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

