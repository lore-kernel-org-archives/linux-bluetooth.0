Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 2/4] storage: Add storage to GAP characteristic
Date: Tue, 27 Mar 2012 09:29:36 -0400
Message-Id: <1332854978-26072-3-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1332854978-26072-1-git-send-email-bruna.moreira@openbossa.org>
References: <1332854978-26072-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add functions to read and write remote Appearance characteristic. The values
are saved in "appearance" file.
---
 src/storage.c |   38 ++++++++++++++++++++++++++++++++++++++
 src/storage.h |    2 ++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index a65cee4..e9413b4 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -282,6 +282,44 @@ int read_local_class(bdaddr_t *bdaddr, uint8_t *class)
 	return 0;
 }
 
+int read_remote_appearance(bdaddr_t *local, bdaddr_t *peer,
+							uint16_t *appearance)
+{
+	char filename[PATH_MAX + 1], addr[18], *str;
+
+	create_filename(filename, PATH_MAX, local, "appearance");
+
+	ba2str(peer, addr);
+
+	str = textfile_get(filename, addr);
+	if (!str)
+		return -ENOENT;
+
+	if (sscanf(str, "%hx", appearance) != 1) {
+		free(str);
+		return -ENOENT;
+	}
+
+	free(str);
+
+	return 0;
+}
+
+int write_remote_appearance(bdaddr_t *local, bdaddr_t *peer,
+							uint16_t appearance)
+{
+	char filename[PATH_MAX + 1], addr[18], str[7];
+
+	create_filename(filename, PATH_MAX, local, "appearance");
+
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	ba2str(peer, addr);
+	sprintf(str, "0x%4.4x", appearance);
+
+	return textfile_put(filename, addr, str);
+}
+
 int write_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class)
 {
 	char filename[PATH_MAX + 1], addr[18], str[9];
diff --git a/src/storage.h b/src/storage.h
index 2f145d0..6967f97 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -36,6 +36,8 @@ int write_local_name(bdaddr_t *bdaddr, const char *name);
 int read_local_name(bdaddr_t *bdaddr, char *name);
 int write_local_class(bdaddr_t *bdaddr, uint8_t *class);
 int read_local_class(bdaddr_t *bdaddr, uint8_t *class);
+int write_remote_appearance(bdaddr_t *local, bdaddr_t *peer, uint16_t appearance);
+int read_remote_appearance(bdaddr_t *local, bdaddr_t *peer, uint16_t *appearance);
 int write_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
 int read_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t *class);
 int write_device_name(bdaddr_t *local, bdaddr_t *peer, char *name);
-- 
1.7.5.4

