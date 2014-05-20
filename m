Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 May 2014 14:54:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/3] shared/crypto: Add support for AES-CMAC-128
Message-ID: <20140520115416.GA5966@t440s.P-661HNU-F1>
References: <1400134532-26574-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400134532-26574-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, May 15, 2014, Lukasz Rymanowski wrote:
> This patch extends bt_crypto with AF_ALG socket for cmac(aes) hash.
> Socket is created on bt_crybto initialization.
> ---
> v2: Change name of sign function from patch 2/3
> 
>  src/shared/crypto.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

All three patches have been applied. Thanks.

Johan
