Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] bluetooth: hci_ll: remove \n from kernel messages
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1512270118-31737-1-git-send-email-david@lechnology.com>
Date: Sun, 3 Dec 2017 20:24:36 +0100
Cc: linux-bluetooth@vger.kernel.org,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Message-Id: <42B71FF6-0BD1-41F2-A37C-D51F63904C1E@holtmann.org>
References: <1512270118-31737-1-git-send-email-david@lechnology.com>
To: David Lechner <david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> The bt_* printk macros include a \n already, so we don't need extra ones
> here.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> drivers/bluetooth/hci_ll.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
