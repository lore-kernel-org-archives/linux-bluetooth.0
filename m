Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 0/3] Initial implementation for MCAP data channel
Date: Wed, 18 Jun 2014 18:58:04 +0300
Message-Id: <1403107087-10539-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patchset implements initial MCAP MDL creation and connection. On
successful MDL connection fd will be passed to HAL.

Ravi kumar Veeramally (3):
  android/health: Check if device and channel already exists or not
  android/health: Cache remote mdep id on channel connect request
  android/health: Create and connect MDL

 android/health.c | 317 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 282 insertions(+), 35 deletions(-)

-- 
1.9.1

