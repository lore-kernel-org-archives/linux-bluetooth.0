Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] bluetooth: bcm203x: don't print error when allocating urb fails
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1470949231-23508-2-git-send-email-wsa-dev@sang-engineering.com>
Date: Wed, 24 Aug 2016 10:57:04 -0400
Cc: linux-usb@vger.kernel.org,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <CFC7B2CC-D3B9-427E-9CA6-EF62782F020B@holtmann.org>
References: <1470949231-23508-1-git-send-email-wsa-dev@sang-engineering.com> <1470949231-23508-2-git-send-email-wsa-dev@sang-engineering.com>
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wolfram,

> kmalloc will print enough information in case of failure.
> 
> Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
> ---
> drivers/bluetooth/bcm203x.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

