Return-Path: <konrad.zapalowicz@canonical.com>
From: Konrad Zapalowicz <konrad.zapalowicz@canonical.com>
To: marcel@holtmann.org
Cc: luiz.von.dentz@intel.com,
	linux-bluetooth@vger.kernel.org,
	=?UTF-8?q?Konrad=20Zapa=C5=82owicz?= <konrad.zapalowicz@canonical.com>
Subject: [PATCH] core: replace sizeof(filename) with PATH_MAX
Date: Fri, 31 Mar 2017 13:03:57 +0200
Message-Id: <1490958237-9299-1-git-send-email-bergo.torino@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

From: Konrad Zapałowicz <konrad.zapalowicz@canonical.com>

This commit replaces sizeof(filename) with PATH_MAX to match the common
scheme which is used in other places.

Signed-off-by: Konrad Zapałowicz <konrad.zapalowicz@canonical.com>
---
 src/adapter.c     | 2 +-
 src/shared/util.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3dac7d6..3935460 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7107,7 +7107,7 @@ static void store_csrk(struct btd_adapter *adapter, const bdaddr_t *peer,
 
 	ba2str(peer, device_addr);
 
-	snprintf(filename, sizeof(filename), STORAGEDIR "/%s/%s/info",
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
 					adapter_dir(adapter), device_addr);
 
 	key_file = g_key_file_new();
diff --git a/src/shared/util.c b/src/shared/util.c
index 7878552..4b59fad 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -117,7 +117,7 @@ unsigned char util_get_dt(const char *parent, const char *name)
 	char filename[PATH_MAX];
 	struct stat st;
 
-	snprintf(filename, sizeof(filename), "%s/%s", parent, name);
+	snprintf(filename, PATH_MAX, "%s/%s", parent, name);
 	if (lstat(filename, &st) == 0 && S_ISDIR(st.st_mode))
 		return DT_DIR;
 
-- 
2.7.4
