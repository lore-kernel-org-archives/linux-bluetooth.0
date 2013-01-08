Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0 2/2] media: Clarify Acquire/TryAcquire error cases
Date: Tue,  8 Jan 2013 10:41:05 +0100
Message-Id: <1357638065-19156-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1357638065-19156-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1357638065-19156-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Document the reported errors for Acquire() and TryAcquire(). For the
later, make sure a specific error in guaranteed for the typical scenario
of audio not streaming.
---
 doc/media-api.txt          | 10 +++++++++-
 profiles/audio/transport.c |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index cdde6ea..bb5ced0 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -321,12 +321,20 @@ Methods		fd, uint16, uint16 Acquire()
 			Acquire transport file descriptor and the MTU for read
 			and write respectively.
 
+			Possible Errors: org.bluez.Error.NotAuthorized
+					 org.bluez.Error.Failed
+
 		fd, uint16, uint16 TryAcquire()
 
 			Acquire transport file descriptor only if the transport
 			is in "pending" state at the time the message is
 			received by BlueZ. Otherwise no request will be sent
-			to the remote device and the function will just fail.
+			to the remote device and the function will just fail
+			with org.bluez.Error.NotAvailable.
+
+			Possible Errors: org.bluez.Error.NotAuthorized
+					 org.bluez.Error.Failed
+					 org.bluez.Error.NotAvailable
 
 		void Release()
 
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 54461d8..58240ac 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -477,7 +477,7 @@ static DBusMessage *try_acquire(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_not_authorized(msg);
 
 	if (transport->state != TRANSPORT_STATE_PENDING)
-		return btd_error_failed(msg, "Transport not playing");
+		return btd_error_not_available(msg);
 
 	owner = media_owner_create(msg);
 	id = transport->resume(transport, owner);
-- 
1.7.11.7

