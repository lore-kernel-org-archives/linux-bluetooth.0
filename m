Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v1 0/1] shared/att: Handle disconnects.
Date: Fri,  8 Aug 2014 18:46:08 -0700
Message-Id: <1407548769-5903-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

*v1: The code now destroys the underlying io structure on timeouts and
     disconnects. In the disconnect case, the io_destroy job is posted on the
     mainloop to prevent the io from being deallocated in the middle of its
     internal event handler.

     In the timeout case, the io_destroy call will clean up the underlying
     connection only if bt_att_set_close_on_unref was called on the bt_att
     structure earlier.

Arman Uguray (1):
  shared/att: Handle disconnects.

 src/shared/att.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++---------
 src/shared/att.h |   5 +++
 2 files changed, 97 insertions(+), 16 deletions(-)

-- 
2.0.0.526.g5318336

