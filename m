Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd 1/2] Return empty body instead -ENOENT when phonebook is empty
Date: Fri,  1 Jul 2011 13:42:42 +0200
Message-Id: <1309520562-19408-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously, when doing pull of empty phonebook, NOT FOUND error was
returned. Now returning empty body - this change is needed to pass PTS
testcase TC_PSE_PDF_BV_05_I (this testcase is optional).

PBAP spec says, that error NOT_FOUND should be returned when phonebook object
could not be found - very strict clients may think that phonebook does not exist
(and in scenario described above phonebook exists but its content is empty).
---
 plugins/pbap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 0356ae7..ab1d9ce 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -301,7 +301,7 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 
 	pbap->obj->lastpart = lastpart;
 
-	if (vcards <= 0) {
+	if (vcards < 0) {
 		obex_object_set_io_flags(pbap->obj, G_IO_ERR, -ENOENT);
 		return;
 	}
-- 
1.6.3.3

