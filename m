Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 0/5] Implement disconenct and reconnect
Date: Mon, 30 Jun 2014 18:31:49 +0300
Message-Id: <1404142314-20795-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patchset supports incoming MCL and MDL disconnection and
reconnection.

Ravi kumar Veeramally (5):
  android/health: Implement mcl_disconnected cb
  android/health: Implement mcl_uncached callback
  android/health: Fix do not set mdl callbacks on mcl_reconneced call
    back
  android/health: Implement MDL reconnection from remote device
  android/health: Update PTS result

 android/health.c    | 122 ++++++++++++++++++++++++++++++++++++++++++++++------
 android/pts-hdp.txt |  24 +++++++++--
 2 files changed, 131 insertions(+), 15 deletions(-)

-- 
1.9.1

