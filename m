Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd] Add Name header check to ftp_chkput
Date: Thu,  4 Aug 2011 14:49:56 +0200
Message-Id: <1312462196-18443-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Validation of Name header was missing from ftp_chkput, thus still allowing
actual putting.
---
 plugins/ftp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index 57b187c..b0ef540 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -267,6 +267,9 @@ int ftp_chkput(struct obex_session *os, void *user_data)
 	if (name == NULL)
 		return -EBADR;
 
+	if (!is_filename(name))
+		return -EBADR;
+
 	if (obex_get_size(os) == OBJECT_SIZE_DELETE)
 		return 0;
 
-- 
1.7.4.1

