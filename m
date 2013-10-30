Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/6] Initial HAL support for device discovery
Date: Wed, 30 Oct 2013 11:00:26 +0100
Message-Id: <1383127232-25147-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2 Changes:
	* fixed coding style issues pointed by jhe and niko1
	* extracted property repacking code for reuse

Jakub Tyszkowski (6):
  android/hal: Add support for start/cancel device discovery commands
  android/hal: Add support for handling discovery state change event
  android/hal: Extract bt property repacking code for further reuse
  android/hal: Add device found event handler
  android/hal: Add device state changed event handler
  android: Add missing discovery state definitions to IPC header

 android/hal-bluetooth.c | 92 +++++++++++++++++++++++++++++++++++++++----------
 android/hal-msg.h       |  3 ++
 2 files changed, 76 insertions(+), 19 deletions(-)

--
1.8.4.1

