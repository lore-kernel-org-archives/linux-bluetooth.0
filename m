Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/13] adapter: Remove support of pincodes storage file
Date: Mon, 17 Dec 2012 16:09:51 +0100
Message-Id: <1355756994-18953-10-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is no more supported in new storage.
---
 src/adapter.c |    3 +--
 src/storage.c |   20 --------------------
 src/storage.h |    1 -
 3 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 581c528..dd1b0b1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3594,8 +3594,7 @@ ssize_t btd_adapter_get_pin(struct btd_adapter *adapter, struct btd_device *dev,
 			return ret;
 	}
 
-	return read_pin_code(&adapter->bdaddr, device_get_address(dev),
-								pin_buf);
+	return -1;
 }
 
 int btd_adapter_set_fast_connectable(struct btd_adapter *adapter,
diff --git a/src/storage.c b/src/storage.c
index 35049f1..375974a 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -144,26 +144,6 @@ int read_local_name(const bdaddr_t *bdaddr, char *name)
 	return 0;
 }
 
-ssize_t read_pin_code(const bdaddr_t *local, const bdaddr_t *peer, char *pin)
-{
-	char filename[PATH_MAX + 1], addr[18], *str;
-	ssize_t len;
-
-	create_filename(filename, PATH_MAX, local, "pincodes");
-
-	ba2str(peer, addr);
-	str = textfile_get(filename, addr);
-	if (!str)
-		return -ENOENT;
-
-	strncpy(pin, str, 16);
-	len = strlen(pin);
-
-	free(str);
-
-	return len;
-}
-
 sdp_record_t *record_from_string(const gchar *str)
 {
 	sdp_record_t *rec;
diff --git a/src/storage.h b/src/storage.h
index 9a9c82f..8d171b0 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -27,7 +27,6 @@ int read_discoverable_timeout(const char *src, int *timeout);
 int read_pairable_timeout(const char *src, int *timeout);
 int read_on_mode(const char *src, char *mode, int length);
 int read_local_name(const bdaddr_t *bdaddr, char *name);
-ssize_t read_pin_code(const bdaddr_t *local, const bdaddr_t *peer, char *pin);
 sdp_record_t *record_from_string(const gchar *str);
 sdp_record_t *find_record_in_list(sdp_list_t *recs, const char *uuid);
 int read_device_pairable(const bdaddr_t *local, gboolean *mode);
-- 
1.7.9.5

