Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 0/4] Implement missing PAN interface and notifications
Date: Tue, 12 Nov 2013 16:20:38 +0200
Message-Id: <1384266042-6344-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2: Fixed wrong number of opcode values as per Johan's comments.

v1: Patch set implements missing cleanup interface and adds event structs
    to hal-msg.h and implements connection and control state notifications.

Ravi kumar Veeramally (4):
  android/pan: Add PAN related defines and event struct to hsl-msg
    header
  android/pan: Add PAN cleanup interface implementation
  android/pan: Add notify method to PAN notifications
  android/pan: Handle connection and control state notifications

 android/hal-msg.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 android/hal-pan.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
 android/hal.h     |  1 +
 3 files changed, 88 insertions(+), 3 deletions(-)

-- 
1.8.3.2

