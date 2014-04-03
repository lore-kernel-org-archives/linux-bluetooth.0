Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 0/3] Add removing GATT services
Date: Thu,  3 Apr 2014 16:46:49 -0300
Message-Id: <1396554412-2057-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1396463426-7268-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1396463426-7268-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset implements GattManager1.UnregisterService(), and low-level
functions to remove service declarations (and its attributes) from the
attribute database.

Changes v1-v0:
 * Fix potential invalid memory access
 * Cleanup of external service when registration fails

Claudio Takahasi (3):
  gatt: Add removing service from the database
  gatt: Fix possibly lost block when bluetoothd exits
  doc: Add InvalidArguments to UnregisterService() errors

 doc/gatt-api.txt |  3 ++-
 src/gatt-dbus.c  | 51 +++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 43 insertions(+), 11 deletions(-)

-- 
1.8.3.1

