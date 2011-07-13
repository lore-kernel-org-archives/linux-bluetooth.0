Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 1/3] Fix read_pin_code to return ssize_t
Date: Wed, 13 Jul 2011 15:40:13 +0200
Message-Id: <1310564415-26093-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

read_pin_code returns the length of a memory block and hence should use
ssize_t as type.
---
 src/event.c   |    2 +-
 src/storage.c |    4 ++--
 src/storage.h |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/event.c b/src/event.c
index d5462f6..a944248 100644
--- a/src/event.c
+++ b/src/event.c
@@ -128,7 +128,7 @@ int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, gboolean secure)
 	struct btd_adapter *adapter;
 	struct btd_device *device;
 	char pin[17];
-	int pinlen;
+	ssize_t pinlen;
 
 	if (!get_adapter_and_device(sba, dba, &adapter, &device, TRUE))
 		return -ENODEV;
diff --git a/src/storage.c b/src/storage.c
index 73bbc36..1f3da6e 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -594,10 +594,10 @@ int read_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key, uint8_t *
 	return 0;
 }
 
-int read_pin_code(bdaddr_t *local, bdaddr_t *peer, char *pin)
+ssize_t read_pin_code(bdaddr_t *local, bdaddr_t *peer, char *pin)
 {
 	char filename[PATH_MAX + 1], addr[18], *str;
-	int len;
+	ssize_t len;
 
 	create_filename(filename, PATH_MAX, local, "pincodes");
 
diff --git a/src/storage.h b/src/storage.h
index 6929ada..bb64727 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -49,7 +49,7 @@ int write_lastseen_info(bdaddr_t *local, bdaddr_t *peer, struct tm *tm);
 int write_lastused_info(bdaddr_t *local, bdaddr_t *peer, struct tm *tm);
 int write_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key, uint8_t type, int length);
 int read_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key, uint8_t *type);
-int read_pin_code(bdaddr_t *local, bdaddr_t *peer, char *pin);
+ssize_t read_pin_code(bdaddr_t *local, bdaddr_t *peer, char *pin);
 gboolean read_trust(const bdaddr_t *local, const char *addr, const char *service);
 int write_trust(const char *src, const char *addr, const char *service, gboolean trust);
 GSList *list_trusts(bdaddr_t *local, const char *service);
-- 
1.7.6

