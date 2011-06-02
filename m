Return-Path: <cyrus@holtmann.org>
From: Lukasz Pawlik <lucas.pawlik@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Pawlik <lucas.pawlik@gmail.com>
Subject: [PATCH] Fix type in conditional expression
Date: Thu,  2 Jun 2011 14:54:32 +0200
Message-Id: <1307019272-19810-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Function media_endpoint_create returns pointer to structure. In
conditional expression it is safer to compare returned value with NULL
and not with gboolean as it is done in register_endpoint function.
---
 audio/media.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 0efb0a8..0eb712a 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -365,7 +365,7 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 
 	if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
-				codec, capabilities, size, &err) == FALSE) {
+				codec, capabilities, size, &err) == NULL) {
 		if (err == -EPROTONOSUPPORT)
 			return btd_error_not_supported(msg);
 		else
-- 
1.7.4.1

