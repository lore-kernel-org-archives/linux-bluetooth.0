Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 0/7] shared/gatt: Various bug fixes.
Date: Mon, 27 Oct 2014 07:35:35 -0700
Message-Id: <1414420542-15336-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

*v1:
  - Fixed potential invalid access while obtaining end group handle.
  - Fixed some compile warnings.

Arman Uguray (7):
  shared/gatt-client: Fix bug in service changed queue.
  shared/gatt-client: Fix bug in service changed handling.
  tools/btgatt-client: Fix read-long-value offset parsing.
  tools/btgatt-client: Fix off-by-one error.
  tools/btgatt-client: Print prompt on service changed.
  shared/gatt-db: Fix range handling in read by grp type.
  TODO: Add new shared/gatt TODO items.

 TODO                     | 15 +++++++++++++++
 src/shared/gatt-client.c | 14 +++++++++-----
 src/shared/gatt-db.c     | 11 ++++++++++-
 tools/btgatt-client.c    | 11 +++++++----
 4 files changed, 41 insertions(+), 10 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5

