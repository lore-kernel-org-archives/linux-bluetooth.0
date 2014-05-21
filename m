Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 00/12] android/gatt: Add support for write signature command
Date: Wed, 21 May 2014 14:44:50 +0200
Message-Id: <1400676302-13626-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set add support for write signature command for android part.
* handling CSRK and signCounter in android/bluetooth - storage
* exchanging CSRK and signCounter between android/bluetooth and gatt
* handling incoming and outgoing write signature command.

Some common part has been updated (attrib, crypto)

In next patches error handling will be added.

Note: If you run on Nexus devices there is need to update kernel which
needs to support CRYPTO_CSRK, CRYPTO_USER_API, CRYPTO_USER_API_HASH,
CRYPTO_USER_API_SKCIPHER. All the information available on
https://code.google.com/p/aosp-bluez/


Lukasz Rymanowski (12):
  shared/crypto: Extend bt_crypto_sign_att with sign counter
  attrib: Add helpers to enc and dec signed write command
  attrib/gatt: Add wrapper to send signed write command
  android/bluetooth: Expose API to get CSRK for device
  android/bluetooth: Expose API to update sign counter
  android/bluetooth: Add support to read CSRK from the kernel
  android/bluetooth: Store CSRK
  android/bluetooth: Read CSRK from the storage on startup
  android/bluetooth: Store sign counter needed for aes-cmac sign
  android/gatt: Add crypto needed for sign write
  android/gatt: Add support for signed write command
  android/gatt: Add handling signed write from remote device

 android/Android.mk  |   1 +
 android/Makefile.am |   1 +
 android/bluetooth.c | 182 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/bluetooth.h |   5 ++
 android/gatt.c      |  88 ++++++++++++++++++++++++-
 attrib/att.c        |  55 ++++++++++++++++
 attrib/att.h        |  11 ++++
 attrib/gatt.c       |  16 +++++
 attrib/gatt.h       |   5 ++
 src/shared/crypto.c |  23 ++++++-
 src/shared/crypto.h |   1 +
 unit/test-crypto.c  |   2 +-
 12 files changed, 385 insertions(+), 5 deletions(-)

-- 
1.8.4

