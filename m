Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 0/4] android: GATT HAL Implementation
Date: Thu,  6 Mar 2014 12:27:55 +0100
Message-Id: <1394105279-9165-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patchset adds the initial implementation of Android GATT HAL. This will allow
to start the actual GATT Service development inside the Android daemon.

Jakub Tyszkowski (4):
  android/hal-gatt: Add Client Event handlers
  android/hal-gatt: Add Client API calls
  android/hal-gatt: Add Server Event handlers
  android/hal-gatt: Add Server API calls

 android/hal-gatt.c | 689 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 655 insertions(+), 34 deletions(-)

--
1.9.0

