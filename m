Return-Path: <cyrus@holtmann.org>
From: Vishal Agarwal <vishal.agarwal@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <naresh.gupta@stericsson.com>,
	Vishal Agarwal <vishal.agarwal@stericsson.com>
Subject: [PATCH] textfile: fix missing call to munmap in wite_key
Date: Thu, 10 May 2012 19:13:47 +0530
Message-ID: <1336657428-14129-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In some cases it was possible that munmap is not called corresponding
to mmap, which might result in future read or writes to fail.
---
 src/textfile.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/textfile.c b/src/textfile.c
index 2712cd8..9d88fbc 100644
--- a/src/textfile.c
+++ b/src/textfile.c
@@ -220,8 +220,8 @@ static int write_key(const char *pathname, const char *key, const char *value, i
 	len = strlen(key);
 	off = find_key(map, size, key, len, icase);
 	if (!off) {
+		munmap(map, size);
 		if (value) {
-			munmap(map, size);
 			lseek(fd, size, SEEK_SET);
 			err = write_key_value(fd, key, value);
 		}
-- 
1.7.0.4

