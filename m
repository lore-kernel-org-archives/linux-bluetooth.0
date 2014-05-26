Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Subject: Re: [PATCH v3 00/12] android/gatt: Add support for write signature command
Date: Mon, 26 May 2014 10:41:22 +0200
Message-ID: <1665466.68EivQj3QF@uw000953>
In-Reply-To: <1400785586-22710-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400785586-22710-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Thursday 22 of May 2014 21:06:14 Lukasz Rymanowski wrote:
> This patch set add support for write signature command for android part.
> * handling CSRK and signCounter in android/bluetooth - storage
> * exchanging CSRK and signCounter between android/bluetooth and gatt
> * handling incoming and outgoing write signature command.
> 
> Some common part has been updated (attrib, crypto)
> 
> In next patches error handling will be added.
> 
> Note: If you run on Nexus devices there is need to update kernel which
> needs to support CRYPTO_CSRK, CRYPTO_USER_API, CRYPTO_USER_API_HASH,
> CRYPTO_USER_API_SKCIPHER. All the information available on
> https://code.google.com/p/aosp-bluez/
> 
> v2:
> * handled Johan comments
> v3:
> * Changed crypto API as suggested by Johan
> 
> 
> Lukasz Rymanowski (12):
>   shared/crypto: Extend bt_crypto_sign_att with sign counter
>   attrib: Add helpers to enc and dec signed write command
>   attrib/gatt: Add wrapper to send signed write command
>   android/bluetooth: Expose API to get CSRK for device
>   android/bluetooth: Expose API to update sign counter
>   android/bluetooth: Add support to read CSRK from the kernel
>   android/bluetooth: Store CSRK
>   android/bluetooth: Read CSRK from the storage on startup
>   android/bluetooth: Store sign counter needed for aes-cmac sign
>   android/gatt: Add crypto needed for sign write
>   android/gatt: Add support for signed write command
>   android/gatt: Add handling signed write from remote device
> 
>  android/Android.mk  |   1 +
>  android/Makefile.am |   1 +
>  android/bluetooth.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  android/bluetooth.h |  10 +++
>  android/gatt.c      |  89 ++++++++++++++++++++++++-
>  attrib/att.c        |  55 ++++++++++++++++
>  attrib/att.h        |  11 ++++
>  attrib/gatt.c       |  16 +++++
>  attrib/gatt.h       |   5 ++
>  src/shared/crypto.c |  19 +++++-
>  src/shared/crypto.h |   1 +
>  unit/test-crypto.c  |  10 +--
>  12 files changed, 395 insertions(+), 8 deletions(-)
> 

All patches are now applied, thanks a lot.


-- 
Best regards, 
Szymon Janc
