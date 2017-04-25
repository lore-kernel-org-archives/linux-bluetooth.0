Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: allocate data for kpp on heap
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1493135987-2618-1-git-send-email-salvatore.benedetto@intel.com>
Date: Tue, 25 Apr 2017 19:28:05 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <FF8E944B-3ADA-4961-A5CB-F204835B936B@holtmann.org>
References: <1493135987-2618-1-git-send-email-salvatore.benedetto@intel.com>
To: Salvatore Benedetto <salvatore.benedetto@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Salvatore,

> Bluetooth would crash when computing ECDH keys with kpp
> if VMAP_STACK is enabled. Fix by allocating data passed
> to kpp on heap.
> 
> Fixes: 58771c1c ("Bluetooth: convert smp and selftest to crypto kpp
> API")
> Signed-off-by: Salvatore Benedetto <salvatore.benedetto@intel.com>
> ---
> net/bluetooth/ecdh_helper.c |  6 ++++--
> net/bluetooth/selftest.c    | 16 +++++++++++-----
> 2 files changed, 15 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

