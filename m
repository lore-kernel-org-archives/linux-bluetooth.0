Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v3 0/3] shared/att: Handle disconnects.
Date: Wed, 13 Aug 2014 19:27:53 -0700
Message-Id: <1407983276-22573-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* v3:
    - Seperated the changes to io-mainloop, bt_att_set_close_on_unref, and
      disconnect handling into separate patches.

Arman Uguray (3):
  shared/io-mainloop: Increment the ref count inside io_callback.
  shared/att: Use io_set_close_on_destroy.
  shared/att: Handle disconnects.

 src/shared/att.c         | 85 +++++++++++++++++++++++++++++++++++-------------
 src/shared/att.h         |  5 +++
 src/shared/io-mainloop.c |  5 +++
 3 files changed, 73 insertions(+), 22 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5

