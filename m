Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 0/4] android/gatt: GATT client improvements
Date: Fri, 11 Apr 2014 16:37:05 +0200
Message-Id: <1397227029-12779-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch sets adds:
* preparation for client listen handling
* refactor send_client_connect_notify function
* fix scenario when application unregister client without proper cleaning

v2:
* removed listen from this patch set. Will send it later.
* cleaning of other patches

v3:
* added memset in patch 1/5

v4:
* rebase


Lukasz Rymanowski (4):
  android/gatt: Refactor send_client_connect_notify
  android/gatt: Fix handling client unregister
  android/gatt: Move functions up in the file
  android/gatt: Cleanup device lists

 android/gatt.c | 210 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 147 insertions(+), 63 deletions(-)

-- 
1.8.4

