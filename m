Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 12/12] attrib: Fix memory leak
Date: Tue, 29 Jul 2014 17:21:01 +0300
Message-Id: <1406643661-29323-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1406643661-29323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587306-20020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1406643661-29323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 attrib/gatttool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index bca7f69..db5da62 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -340,6 +340,7 @@ static gboolean characteristics_write(gpointer user_data)
 
 	gatt_write_cmd(attrib, opt_handle, value, len, mainloop_quit, value);
 
+	g_free(value);
 	return FALSE;
 
 error:
@@ -393,6 +394,7 @@ static gboolean characteristics_write_req(gpointer user_data)
 	gatt_write_char(attrib, opt_handle, value, len, char_write_req_cb,
 									NULL);
 
+	g_free(value);
 	return FALSE;
 
 error:
-- 
1.9.1

