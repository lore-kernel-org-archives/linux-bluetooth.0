Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 0/6] Initial HAL test AVRCP api support
Date: Fri, 28 Feb 2014 20:58:42 +0200
Message-Id: <1393613928-22264-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patchset contains initial AVRCP api support for HAL test.

Ravi kumar Veeramally (6):
  android/client: Add AVRCP get_play_status_rsp support
  android/client: Add AVRCP get_element_attr_rsp support
  android/client: Add AVRCP set_volume support
  android/client: Add AVRCP get_play_status_cb support
  android/client: Add AVRCP get_element_attr_cb support
  android/client: Add AVRCP volume_change_cb support

 android/client/if-rc.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

-- 
1.8.3.2

