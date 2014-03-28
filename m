Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v4 3/3] Bluetooth: Keep msec in DISCOV_LE_TIMEOUT
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395950121-12263-3-git-send-email-lukasz.rymanowski@tieto.com>
Date: Fri, 28 Mar 2014 00:12:10 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <71980B98-959E-46CF-9C97-AD361E58A233@holtmann.org>
References: <1395950121-12263-1-git-send-email-lukasz.rymanowski@tieto.com> <1395950121-12263-3-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> To be consistent, lets use msec for this timeout as well.
> 
> Note: This define value is a minimum scan time taken from BT Core spec 4.0,
> Vol 3, Part C, chapter 9.2.6
> 
> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
> ---
> include/net/bluetooth/hci_core.h | 2 +-
> net/bluetooth/mgmt.c             | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

