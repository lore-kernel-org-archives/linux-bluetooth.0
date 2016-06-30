Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Don Zickus <dzickus@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, mkasik@redhat.com,
	Don Zickus <dzickus@redhat.com>
Subject: [PATCH 1/3] obexd: Allow CreateFolder to create a directory
Date: Thu, 30 Jun 2016 17:01:27 -0400
Message-Id: <1467320489-127890-2-git-send-email-dzickus@redhat.com>
In-Reply-To: <1467320489-127890-1-git-send-email-dzickus@redhat.com>
References: <1467320489-127890-1-git-send-email-dzickus@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the remote device sends the 'CreateFolder' command, obexd
first tries to verify the path in ftp_setpath().  Because we are
creating a new directory, the verify_path() is expected to fail (it does
not exist yet; ENOENT).

Trap that special case and cause the function to fail directly to the
create directory path.

This patch is from Marek Kasik <mkasik@redhat.com>.
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
1.8.3.1

