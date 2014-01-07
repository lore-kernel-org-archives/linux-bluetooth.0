Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 0/4] Add support for NAP role
Date: Tue,  7 Jan 2014 14:31:16 +0200
Message-Id: <1389097880-14783-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v3: Fixed Johan's comments (removed fopen, fprintf and used open and write).

v2: Fixed Johan's comments.

v1: This patch set add support for NAP role. It register NAP server and create
  bnep bridge and listen for incoming connections from client devices.
  On incoming connection request it accepts connection, creates bnep interface
  and notifies control state and connection state infromation. Removes device
  on disconnect request. Android related changes are required to enable this
  role. Patches sent to respective ML.

Ravi kumar Veeramally (4):
  android/pan: Register Network Access Point
  android/pan: Listen for incoming connections and accept in NAP role
  android/pan: Implement PAN enable HAL api at daemon side
  android/pan: Remove connected PAN devices on profile unregister call

 android/pan.c | 346 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 334 insertions(+), 12 deletions(-)

-- 
1.8.3.2

