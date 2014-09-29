Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] shared/uhid: Make use of io_send
Date: Mon, 29 Sep 2014 17:57:44 +0300
Message-Id: <1412002664-28253-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412002664-28253-1-git-send-email-luiz.dentz@gmail.com>
References: <1412002664-28253-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/uhid.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 28c1792..f7ad0cb 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -228,15 +228,16 @@ bool bt_uhid_unregister(struct bt_uhid *uhid, unsigned int id)
 
 int bt_uhid_send(struct bt_uhid *uhid, const struct uhid_event *ev)
 {
-	int fd;
 	ssize_t len;
+	struct iovec iov;
 
 	if (!uhid->io)
 		return -ENOTCONN;
 
-	fd = io_get_fd(uhid->io);
+	iov.iov_base = (void *) ev;
+	iov.iov_len = sizeof(*ev);
 
-	len = write(fd, ev, sizeof(*ev));
+	len = io_send(uhid->io, &iov, 1);
 	if (len < 0)
 		return -errno;
 
-- 
1.9.3

