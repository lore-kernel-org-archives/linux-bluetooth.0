Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 May 2014 16:16:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH 05/12] android/bluetooth: Expose API to update sign
 counter
Message-ID: <20140521131631.GA25779@t440s.P-661HNU-F1>
References: <1400676302-13626-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1400676302-13626-6-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400676302-13626-6-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, May 21, 2014, Lukasz Rymanowski wrote:
> +void bt_update_sign_counter(const bdaddr_t *addr, bool local);

This doesn't make for a good API since you can't know which counter
bt_update_sign_counter(bdaddr, true/false) updates without looking at
the actual implementation. Either create a two-value enum or have two
separate functions to make the calling code more readable.

Johan
