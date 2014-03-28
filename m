Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v4 1/3] Bluetooth: Keep msec in DISCOV_INTERLEAVED_TIMEOUT
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395950121-12263-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Fri, 28 Mar 2014 00:12:07 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7104FC6E-350F-4749-BE4A-91C6D863D073@holtmann.org>
References: <1395950121-12263-1-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> Keep msec instead of jiffies in this define. This is needed by following
> patch where we want this timeout to be exposed in debugfs.
> 
> Note: Value of this timeout comes from recommendation in BT Core Spec.4.0,
> Vol 3, Part C, chapter 13.2.1.
> 
> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
> ---
> include/net/bluetooth/hci_core.h |  2 +-
> net/bluetooth/mgmt.c             | 13 +++++++++----
> 2 files changed, 10 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

