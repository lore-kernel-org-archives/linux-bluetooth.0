Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 1/5] media: release transport locks on acquisition failure
Date: Mon, 21 Nov 2011 11:07:40 +0100
Message-ID: <1321870064-20553-2-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1321870064-20553-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1321870064-20553-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/transport.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 2739199..7bde32d 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -670,6 +670,7 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	owner = media_owner_create(conn, msg, accesstype);
 	id = transport->resume(transport, owner);
 	if (id == 0) {
+		media_transport_release(transport, accesstype);
 		media_owner_free(owner);
 		return btd_error_not_authorized(msg);
 	}
-- 
1.7.6.4

