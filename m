Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 0/5] android/tester: GATT tests for various write scenarios
Date: Wed, 14 Jan 2015 10:19:36 +0100
Message-Id: <1421227181-1498-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those are probably corner cases, but PTS can use Service Change ccc descriptor
for its prepare/execute write tests. We should treat this descriptor like any
other and allow multiple write types and report proper errors.

v2 changes:
 * fixed partial ccc value storing in prepare write with offset
 * minor fixes mentioned by sjanc

Jakub Tyszkowski (5):
  android/tester: Add case for GATT prep. and exec. write on ccc descr.
  android/tester: Add GATT Server test for invalid value length for ccc
  android/tester: Add case for error passing in GATT server responses
  android/tester: Add GATT case for Svc. change invalid offset write
  android/gatt: Fix not handling service change ccc write execute

 android/gatt.c        |  55 ++++++++++++--
 android/tester-gatt.c | 196 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c |  10 +++
 android/tester-main.h |   9 +++
 4 files changed, 265 insertions(+), 5 deletions(-)

--
1.9.1

