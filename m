Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 1/6] Bluetooth: Add support for local name in scan rsp
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1474195807-12310-1-git-send-email-szymon.janc@codecoup.pl>
Date: Mon, 19 Sep 2016 08:29:15 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        =?utf-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Message-Id: <19C99E5F-A230-43CD-A37F-5A01F1AA2B2E@holtmann.org>
References: <1474195807-12310-1-git-send-email-szymon.janc@codecoup.pl>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> This patch enables appending local name to scan response data. If
> currently advertised instance has name flag set it is expired
> immediately.
> 
> Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
> Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
> ---
> net/bluetooth/hci_request.c | 28 +++++++++++++++++++--------
> net/bluetooth/mgmt.c        | 46 +++++++++++++++++++++++++++++++++++++++++++--
> 2 files changed, 64 insertions(+), 10 deletions(-)

all 6 patches have been applied to bluetooth-next tree.

Regards

Marcel

