Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 0/4] Add GET/SET_REPORT support to HoG
Date: Fri, 21 Nov 2014 15:41:42 +0100
Message-Id: <1416580906-22134-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

With linux-3.18 uhid will gain GET/SET_REPORT support. 3.18 isn't released, yet,
but the uhid features are part of 3.18-rc5 so I think it's fine to rely on it.
We can always revert it if it will not be released (for whatever reason..).

Benjamin wrote these 4 patches about 2 months ago and I promised to fix a few
bugs and send them upstream. I already feel bad for letting them rot for 2
months.. sorry!

Anyway, I fixed the ID tracking, some typos, and fixed handling of devices that
dont send report IDs in GET_REPORT. Patches should be straightforward. The
GET/SET_REPORT feature is important for nearly all non-standard HID device
drivers. It's used to query and modify device behavior. With this in place, we
should be able to use all the kernel hid drivers via uhid/hog.

Benjamin has an example program to modify MS Arc Surface Touch mouse behavior,
which needs these patches to query/modify the device. See:
    https://github.com/bentiss/mstouchmouse/tree/WIP-USB
(If you check it out, make sure to use the WIP-USB branch! You should also apply
 the diff below, to make sure it works even if the report-ID is not prepended.)

Works fine with my devices here!
David


diff --git a/set_touchmode.c b/set_touchmode.c
index 7e5d59a..0e6f412 100644
--- a/set_touchmode.c
+++ b/set_touchmode.c
@@ -48,6 +48,11 @@ static int get_report(int fd, unsigned char id, ...
     } else {
         printf("Report data (%d):\n\t", id);
         pr_buffer(buf, res);
+        /* prepend report-ID if not sent by device */
+        if (res > 0 && buf[0] != id) {
+            memmove(buf + 1, buf, (res >= len) ? (res - 1) : res);
+            buf[0] = id;
+        }
     }
     return res;
 }

Benjamin Tissoires (4):
  hog: import latest uhid.h definition
  hog: break out the report retrieval in its own function
  hog: implement get_report functionality
  hog: implement set_report functionality

 profiles/input/hog.c       | 204 +++++++++++++++++++++++++++++++++++++++++----
 profiles/input/uhid_copy.h | 117 +++++++++++++++++++++++---
 2 files changed, 292 insertions(+), 29 deletions(-)

-- 
2.1.3
