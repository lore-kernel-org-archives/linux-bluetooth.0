Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] btmgmt: fix used without initialization
Date: Mon,  7 Nov 2011 13:58:35 -0300
Message-Id: <1320685115-20542-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the following warning being treated as error:
mgmt/main.c: In function 'mgmt_process_data':
mgmt/main.c:508:3: error: 'len' may be used uninitialized in this
function [-Werror=uninitialized]
---
 mgmt/main.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/mgmt/main.c b/mgmt/main.c
index c970f62..d939cca 100644
--- a/mgmt/main.c
+++ b/mgmt/main.c
@@ -504,8 +504,10 @@ static int mgmt_process_data(int mgmt_sk)
 
 	ret = read(mgmt_sk, buf, sizeof(buf));
 	if (ret < 0) {
-		fprintf(stderr, "read: %s\n", strerror(errno));
-		return len;
+		int err = errno;
+
+		fprintf(stderr, "read: %s\n", strerror(err));
+		return -err;
 	}
 
 	if (ret < MGMT_HDR_SIZE) {
-- 
1.7.7.2

