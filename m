Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 0/4] Fix for android-tester: Gatt - Double Listen case
Date: Fri, 22 Aug 2014 14:40:45 +0200
Message-Id: <1408711249-6683-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set fixes the issue with Gatt: Double Listen test case, in which
we were trying to reconnect the emulated remote while the ACL was still
connected.

Jakub Tyszkowski (2):
  android/tester: Wait for ACL disconnection before reconnect
  android/tester: Make Gatt stop listening after ACL disconnects

Marcin Kraglak (2):
  emulator/bthost: Add hci disconnect
  android/tester: Force remotes ACL disconnection

 android/tester-gatt.c | 23 ++++++++++++++++++++---
 android/tester-main.c | 15 ++++++++++++++-
 emulator/bthost.c     | 11 +++++++++++
 emulator/bthost.h     |  3 +++
 4 files changed, 48 insertions(+), 4 deletions(-)

--
1.9.1

