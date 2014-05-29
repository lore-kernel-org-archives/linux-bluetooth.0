Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 00/10] Fixes to sign write
Date: Thu, 29 May 2014 15:49:34 +0200
Message-Id: <1401371384-10427-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set brings couple of bug fixes founded during tests against PTS.
Biggest change is that I had to move signing procedure down to att.c as
not only payload need to be signed but also opcode and handle.
Therefore it makes sense to generate signature in place where pdu is encoded

With those patches PTS TC_GAW_CL_BV_02_C and TC_GAW_SR_BV_02_C are passing

v2:
* Rebase
* Added one more cleanup patch to the series (remove not needed mempcy)

Lukasz Rymanowski (10):
  android/gatt: Verify signature counter from remote
  android/gatt: Fix handling signed write command from remote
  android/gatt: Fix signed write command encoding
  shared/crypto: Fix concatenate of sign counter into the msg
  shared/crypto: Fix byte order of sign counter added to signature
  shared/crypto: Change swap128 to swap_buf
  shared/crypto: Fix byte order of message
  unit/crypto: Update unit test vectors after changes in singing process
  android/pts: Update GATT PTS test results
  shared/crypto: Remove not needed memcpy

 Makefile.am          |  3 ++-
 Makefile.tools       |  4 +++-
 android/gatt.c       | 25 ++++++++++++-------------
 android/pts-gatt.txt | 20 ++++++++++++++++++--
 attrib/att.c         | 11 +++++++----
 attrib/att.h         |  6 +++++-
 attrib/gatt.c        | 11 ++++++++---
 attrib/gatt.h        |  4 +++-
 src/shared/crypto.c  | 27 +++++++++++++++------------
 unit/test-crypto.c   |  6 +++---
 10 files changed, 76 insertions(+), 41 deletions(-)

-- 
1.8.4

