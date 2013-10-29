Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 0/5] initial code for pairing support
Date: Tue, 29 Oct 2013 12:52:37 +0100
Message-ID: <1383047562-4799-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

V3: Fixed cback calling convention pointed by Andrei.

Szymon Janc (5):
  android: Define class of device as four bytes in IPC doc
  android: Update IPC headers to match SSP and PIN requests events
  android/hal: Add support for handling bond state change event
  android/hal: Add support for handling pin request event
  android/hal: Add support for handling SSP request event

 android/hal-bluetooth.c | 41 +++++++++++++++++++++++++++++++++++++++++
 android/hal-ipc-api.txt |  4 ++--
 android/hal-msg.h       |  8 ++++----
 3 files changed, 47 insertions(+), 6 deletions(-)

-- 
1.8.4.1

