Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] Bluetooth: convert smp and selftest to crypto kpp API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1493036000-30800-1-git-send-email-salvatore.benedetto@intel.com>
Date: Mon, 24 Apr 2017 18:59:01 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <0E31966D-F53A-40F5-824B-6C6D26FE6426@holtmann.org>
References: <1493036000-30800-1-git-send-email-salvatore.benedetto@intel.com>
To: Salvatore Benedetto <salvatore.benedetto@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Salvatore,

> * Convert both smp and selftest to crypto kpp API
> * Remove module ecc as no more required
> * Add ecdh_helper functions for wrapping kpp async calls
> 
> This patch has been tested *only* with selftest, which is called on
> module loading.
> 
> Signed-off-by: Salvatore Benedetto <salvatore.benedetto@intel.com>
> ---
> 
> Somehow I forgot to send this patch.
> 
> Changes from v2
> - Based on bluetooth-next
> - Update code to latest API: remove crypto_kpp_set_params and use
>   crypto_ecdh_encode_key
> - Removed include guards from internal header as requested by Johan
> - Added CRYPTO_ECDH dependecy to bluetooth Kconfig
> - Rename compute_ecdh_shared_secret and generate_ecdh_key_pair to
>   compute_ecdh_secret and generate_ecdh_keys respectively
> 
> net/bluetooth/Kconfig       |   1 +
> net/bluetooth/Makefile      |   2 +-
> net/bluetooth/ecc.c         | 816 --------------------------------------------
> net/bluetooth/ecc.h         |  54 ---
> net/bluetooth/ecdh_helper.c | 223 ++++++++++++
> net/bluetooth/ecdh_helper.h |  27 ++
> net/bluetooth/selftest.c    |   6 +-
> net/bluetooth/smp.c         |   8 +-
> 8 files changed, 259 insertions(+), 878 deletions(-)
> delete mode 100644 net/bluetooth/ecc.c
> delete mode 100644 net/bluetooth/ecc.h
> create mode 100644 net/bluetooth/ecdh_helper.c
> create mode 100644 net/bluetooth/ecdh_helper.h

patch has been applied to bluetooth-next tree.

Regards

Marcel

