Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 0/1] shared/att: Handle disconnects.
Date: Mon, 11 Aug 2014 14:18:53 -0700
Message-Id: <1407791934-3778-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* v2:
    - Removed the "invalid" field from struct bt_att and made the related code
      conditional on att->io not being NULL.

    - Made it safe to call io_destroy from within read/write/disconnect
      callbacks for the mainloop version of struct io by calling io_ref and
      io_unref internally. The same unsafety issue doesn't seem to be present in
      io-glib, so left that as is for now.

Arman Uguray (1):
  shared/att: Handle disconnects.

 src/shared/att.c         | 85 +++++++++++++++++++++++++++++++++++-------------
 src/shared/att.h         |  5 +++
 src/shared/io-mainloop.c |  5 +++
 3 files changed, 73 insertions(+), 22 deletions(-)

-- 
2.0.0.526.g5318336

