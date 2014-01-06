Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 0/4] Add support for NAP role
Date: Mon,  6 Jan 2014 23:26:28 +0200
Message-Id: <1389043592-5616-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set add support for NAP role. It register NAP server and create
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

 android/pan.c | 349 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 337 insertions(+), 12 deletions(-)

-- 
1.8.3.2

