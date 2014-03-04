Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 0/8] Initial AT handling for handsfree
Date: Tue,  4 Mar 2014 16:32:02 +0100
Message-Id: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This adds initial minimal set of AT commands to establish SLC connection.

Szymon Janc (8):
  android/handsfree: Add support for AT+BRSF command
  android/handsfree: Add support for AT+CIND command
  android/handsfree: Add support for AT+CMER command
  android/handsfree: Distinguish between HSP and HFP connection
  shared/hfp: Add function to check if reach end of command
  shared/hfp: Add hfp_gw_result_get_number_default function
  android/handsfree: Add support for AT+BIA command
  android/handsfree: Make connection state constants name shorter

 android/hal-msg.h   |  10 +-
 android/handsfree.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++++---
 src/shared/hfp.c    |  20 ++++
 src/shared/hfp.h    |   4 +
 4 files changed, 282 insertions(+), 18 deletions(-)

-- 
1.8.3.2

