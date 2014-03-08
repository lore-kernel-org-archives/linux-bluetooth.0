Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 00/20] More Android Handsfree work
Date: Sat,  8 Mar 2014 01:19:44 +0100
Message-Id: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patchset adds support for basic handsfree functionality.

What is done:
 - indicators (without callheld)
 - placing, accepting, cancelling calls etc.
 - vendor (unknown) AT command handling
 - extended error codes
 - DTMF codes
 - query current calls
 - voice recognition on/off
 - disabling echo cancellation
 - subscriber and operator identification

Missing features:
 - proper three way calling support (AT+CHLD is supported but callheld
   and CCWA are missing).
 - WBS and codec negotiation
 - audio

-- 
BR
Szymon Janc

Szymon Janc (20):
  android/handsfree: Add AG and HF features masks
  android/handsfree: Add stubs for all AT commands defines by spec
  android/handsfree: Add support for unknown AT commands
  android/handsfree: Add support for voice recognition function
  android/handsfree: Add support for AT+NREC command
  android/handsfree: Add support for AT+CLCC command
  android/handsfree: Add support for AT+CHLD command
  android/handsfree: Add support for AT+CMEE command
  android/handsfree: Add support for AT+CKPD command
  android/handsfree: Add support fot AT+CNUM command
  android/handsfree: Add support for AT+VTS command
  android/handsfree: Add support for ATA command
  android/handsfree: Fix checking AT+COPS parameters
  android/handsfree: Add support for ATD command
  android/handsfree: Add support for AT+BLDN command
  android/handsfree: Add support for AT+CHUP command
  android/hal-handsfree: Fix handling of dial notification
  android/handsfree: Add support for phone state change command
  android/handsfree: Add support for AT+CLIP command
  android/handsfree: Add comment for AT+VGS/AT+VGM result code

 android/hal-handsfree.c |   7 +-
 android/hal-msg.h       |   5 +-
 android/handsfree.c     | 889 ++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 838 insertions(+), 63 deletions(-)

-- 
1.8.5.3

