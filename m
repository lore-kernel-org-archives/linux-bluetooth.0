Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 0/4] Add HDP profile support at HAL side
Date: Fri, 14 Mar 2014 15:30:54 +0200
Message-Id: <1394803858-10052-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v3: Patch set contains 10-13 from v2. Solved Szymon comments (strings
 copying to byte array with null terminated character).

v2: Solved Luiz, Szymon, Andrzej and Grzegorz comments.

v1: Patch set contains HDP profile support at HAL side and initial
 profile registration support at daemon side.

Ravi kumar Veeramally (4):
  android/hal-health: Add HDP .register_application method
  android/hal-health: Add HDP .unregister_application method
  android/hal-health: Add HDP .connect_channel method
  android/hal-health: Add HDP .destroy_channel method

 android/hal-health.c | 175 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 171 insertions(+), 4 deletions(-)

-- 
1.8.3.2

