Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 May 2014 16:19:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH 01/12] shared/crypto: Extend bt_crypto_sign_att with sign
 counter
Message-ID: <20140521131906.GB25779@t440s.P-661HNU-F1>
References: <1400676302-13626-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1400676302-13626-2-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400676302-13626-2-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, May 21, 2014, Lukasz Rymanowski wrote:
>  bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
>  					const uint8_t *m, uint16_t m_len,
> +					const int32_t sign_cnt,

We use const declarations to indicate that the function promises not to
modify memory behind pointers. When passing integers you don't anyway
have access to the original variable so the convention used throughout
the tree is to not use const declarations for such variables.

Johan
