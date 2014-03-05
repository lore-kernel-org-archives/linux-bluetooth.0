Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 2/5] monitor: Use miliseconds instead of seconds in the timeout
Date: Wed, 5 Mar 2014 10:22:38 +0100
Message-ID: <1394011361-9469-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1394011361-9469-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394011361-9469-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/mainloop.c | 19 ++++++++++---------
 monitor/mainloop.h |  4 ++--
 tools/3dsp.c       |  2 +-
 tools/btinfo.c     |  2 +-
 tools/ibeacon.c    |  2 +-
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/monitor/mainloop.c b/monitor/mainloop.c
index 7f97e65..8d4b391 100644
--- a/monitor/mainloop.c
+++ b/monitor/mainloop.c
@@ -287,20 +287,21 @@ static void timeout_callback(int fd, uint32_t events, void *user_data)
 		data->callback(data->fd, data->user_data);
 }
 
-static inline int timeout_set(int fd, unsigned int seconds)
+static inline int timeout_set(int fd, unsigned int msec)
 {
 	struct itimerspec itimer;
+	unsigned int sec = msec / 1000;
 
 	memset(&itimer, 0, sizeof(itimer));
 	itimer.it_interval.tv_sec = 0;
 	itimer.it_interval.tv_nsec = 0;
-	itimer.it_value.tv_sec = seconds;
-	itimer.it_value.tv_nsec = 0;
+	itimer.it_value.tv_sec = sec;
+	itimer.it_value.tv_nsec = (msec - (sec * 1000)) * 1000;
 
 	return timerfd_settime(fd, 0, &itimer, NULL);
 }
 
-int mainloop_add_timeout(unsigned int seconds, mainloop_timeout_func callback,
+int mainloop_add_timeout(unsigned int msec, mainloop_timeout_func callback,
 				void *user_data, mainloop_destroy_func destroy)
 {
 	struct timeout_data *data;
@@ -323,8 +324,8 @@ int mainloop_add_timeout(unsigned int seconds, mainloop_timeout_func callback,
 		return -EIO;
 	}
 
-	if (seconds > 0) {
-		if (timeout_set(data->fd, seconds) < 0) {
+	if (msec > 0) {
+		if (timeout_set(data->fd, msec) < 0) {
 			close(data->fd);
 			free(data);
 			return -EIO;
@@ -341,10 +342,10 @@ int mainloop_add_timeout(unsigned int seconds, mainloop_timeout_func callback,
 	return data->fd;
 }
 
-int mainloop_modify_timeout(int id, unsigned int seconds)
+int mainloop_modify_timeout(int id, unsigned int msec)
 {
-	if (seconds > 0) {
-		if (timeout_set(id, seconds) < 0)
+	if (msec > 0) {
+		if (timeout_set(id, msec) < 0)
 			return -EIO;
 	}
 
diff --git a/monitor/mainloop.h b/monitor/mainloop.h
index d36f5aa..dafec8b 100644
--- a/monitor/mainloop.h
+++ b/monitor/mainloop.h
@@ -40,9 +40,9 @@ int mainloop_add_fd(int fd, uint32_t events, mainloop_event_func callback,
 int mainloop_modify_fd(int fd, uint32_t events);
 int mainloop_remove_fd(int fd);
 
-int mainloop_add_timeout(unsigned int seconds, mainloop_timeout_func callback,
+int mainloop_add_timeout(unsigned int msec, mainloop_timeout_func callback,
 				void *user_data, mainloop_destroy_func destroy);
-int mainloop_modify_timeout(int fd, unsigned int seconds);
+int mainloop_modify_timeout(int fd, unsigned int msec);
 int mainloop_remove_timeout(int id);
 
 int mainloop_set_signal(sigset_t *mask, mainloop_signal_func callback,
diff --git a/tools/3dsp.c b/tools/3dsp.c
index d1b17f2..fc5c8e6 100644
--- a/tools/3dsp.c
+++ b/tools/3dsp.c
@@ -66,7 +66,7 @@ static void shutdown_device(void)
 	bt_hci_flush(hci_dev);
 
 	if (reset_on_shutdown) {
-		id = mainloop_add_timeout(5, shutdown_timeout, NULL, NULL);
+		id = mainloop_add_timeout(5000, shutdown_timeout, NULL, NULL);
 
 		bt_hci_send(hci_dev, BT_HCI_CMD_RESET, NULL, 0,
 				shutdown_complete, UINT_TO_PTR(id), NULL);
diff --git a/tools/btinfo.c b/tools/btinfo.c
index 7951808..6693132 100644
--- a/tools/btinfo.c
+++ b/tools/btinfo.c
@@ -109,7 +109,7 @@ static void shutdown_device(void)
 	bt_hci_flush(hci_dev);
 
 	if (reset_on_shutdown) {
-		id = mainloop_add_timeout(5, shutdown_timeout, NULL, NULL);
+		id = mainloop_add_timeout(5000, shutdown_timeout, NULL, NULL);
 
 		bt_hci_send(hci_dev, BT_HCI_CMD_RESET, NULL, 0,
 				shutdown_complete, UINT_TO_PTR(id), NULL);
diff --git a/tools/ibeacon.c b/tools/ibeacon.c
index 2071c6b..093fba1 100644
--- a/tools/ibeacon.c
+++ b/tools/ibeacon.c
@@ -65,7 +65,7 @@ static void shutdown_device(void)
 
 	bt_hci_flush(hci_dev);
 
-	id = mainloop_add_timeout(5, shutdown_timeout, NULL, NULL);
+	id = mainloop_add_timeout(5000, shutdown_timeout, NULL, NULL);
 
 	bt_hci_send(hci_dev, BT_HCI_CMD_LE_SET_ADV_ENABLE,
 					&enable, 1, NULL, NULL, NULL);
-- 
1.8.4

