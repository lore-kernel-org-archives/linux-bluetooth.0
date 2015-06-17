Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v3 4/5] Support the BCM4354 Bluetooth UART device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434555767-18234-5-git-send-email-ifaenson@broadcom.com>
Date: Wed, 17 Jun 2015 18:59:11 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Arend van Spriel <arend@broadcom.com>
Message-Id: <80E1797C-1834-405B-A432-D3DD984CC31C@holtmann.org>
References: <1434555767-18234-1-git-send-email-ifaenson@broadcom.com> <1434555767-18234-5-git-send-email-ifaenson@broadcom.com>
To: Ilya Faenson <ifaenson@broadcom.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilya,

> Support the BCM4354 chip and introduce vendor specific command
> parameter definitions.
> 
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---
> drivers/bluetooth/btbcm.c |  2 ++
> drivers/bluetooth/btbcm.h | 31 +++++++++++++++++++++++++++++++
> 2 files changed, 33 insertions(+)

patch has been applied to bluetooth-next tree.

I decide to apply this one since it is self-contained and causes no harm to be applied ahead of time. However I had fix up the subject line. You want to prefix this with Bluetooth: btbcm: or similar in the future. If in doubt look at what the last patches touching some of the files have used as prefix.

Regards

Marcel

