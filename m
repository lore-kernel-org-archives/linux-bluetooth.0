Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 11 Jun 2015 17:27:50 -0700
Message-ID: <CAGnek1nNmfJUWJVJ+J45_9eCDd=cC-7mhJ8wN3ujtV-LpLfC0w@mail.gmail.com>
Subject: [PATCH] profiles/hog: enable report notifications if ccc handle is valid
From: Austin Foxley <austinf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

profiles/hog: enable report notifications if ccc handle is valid

This fixes an issue where hog report notifications weren't
getting processed after a device disconnected then reconnected
a short while later without being removed.

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 4be9fd2..a61d0e7 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -858,7 +858,7 @@ static void attio_connected_cb(GAttrib *attrib,
gpointer user_data)
        for (l = hogdev->reports; l; l = l->next) {
                struct report *r = l->data;

-               enable_report_notifications(r, false);
+               enable_report_notifications(r, r->ccc_handle != 0);
        }
 }
