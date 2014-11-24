Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 0/2] shared/gatt: Bug fixes.
Date: Mon, 24 Nov 2014 15:03:50 -0800
Message-Id: <1416870232-16692-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

*v1: Call io_shutdown instead of close(att->fd).

Arman Uguray (2):
  shared/att: Call io_shutdown on ATT violations.
  shared/gatt-client: Call ready_handler only in init.

 src/shared/att.c         | 21 +++++++++++++--------
 src/shared/gatt-client.c |  3 ++-
 2 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5

