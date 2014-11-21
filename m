Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 0/2] shared/gatt: Bug fixes.
Date: Fri, 21 Nov 2014 15:44:58 -0800
Message-Id: <1416613500-13315-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch includes small bug fixes for shared/att and
shared/gatt-client.

Arman Uguray (2):
  shared/att: Directly close fd on ATT violations.
  shared/gatt-client: Call ready_handler only in init.

 src/shared/att.c         | 17 +++++++++++------
 src/shared/gatt-client.c |  3 ++-
 2 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5

