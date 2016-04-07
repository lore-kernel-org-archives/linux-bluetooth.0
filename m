Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marek Kasik <mkasik@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marek Kasik <mkasik@redhat.com>
Subject: [PATCH] obexd/ftp: Don't fail if created folder doesn't exist
Date: Thu,  7 Apr 2016 13:58:31 +0200
Message-Id: <1460030311-7560-1-git-send-email-mkasik@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Don't fail when the folder we are about to create
by org.bluez.obex.FileTransfer1.CreateFolder
doesn't exist before its creation.

Signed-off-by: Marek Kasik <mkasik@redhat.com>
---
 obexd/plugins/ftp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/obexd/plugins/ftp.c b/obexd/plugins/ftp.c
index a906527..3ee18a6 100644
--- a/obexd/plugins/ftp.c
+++ b/obexd/plugins/ftp.c
@@ -278,6 +278,8 @@ int ftp_setpath(struct obex_session *os, void *user_data)
 	DBG("Fullname: %s", fullname);
 
 	err = verify_path(fullname);
+	if (err == -ENOENT)
+		goto not_found;
 
 	if (err < 0)
 		goto done;
-- 
2.7.3

