Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 3/4] media: Extend media API with optional acquire
Date: Tue, 24 Jul 2012 17:52:29 +0200
Message-Id: <1343145150-6427-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1343145150-6427-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1343145150-6427-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Acquiring a transport is needed in two different situations: either
we are initiating the audio stream locally, or the remote side initiated
it and thus we are just reacting. In the second case, we would expect
the stream is already available, and otherwise the operation should
fail. This means the media API needs to be extended in order to make
this difference.

This issue is specially relevant in the case of SCO, because the current
approach is racy. With HFP, for example (say BlueZ has the HS role), the
following race condition could be met:

1. Phone has an incoming call and thus starts in-band ringing.
2. SCO connection is accepted and stablished by BlueZ.
3. Gateway interface state is changed to Playing.
4. Exactly afterwards, the user routes the audio to the phone, to have
   a private conversation. So the SCO link is closed.
5. In parallel, PulseAudio sees the transition to Playing, and acquires
   the transport.
6. BlueZ receives an Acquire() request, but SCO is down. So it tries to
   reconnect the SCO link.

The last step is an undesired behavior (the audio is routed back to the
car). BlueZ should be smart enough to know that the SCO connection
shouldn't be reestablished, but this is only possible if the endpoint
provides additional information in the media API.
---
 audio/transport.c |    3 +++
 doc/media-api.txt |    7 +++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index f988d48..ffc637c 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -679,6 +679,9 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	if (media_transport_acquire(transport, accesstype) == FALSE)
 		return btd_error_not_authorized(msg);
 
+	if (!transport->playing && g_strstr_len(accesstype, -1, "?") != NULL)
+		return btd_error_failed(msg, "Transport not playing");
+
 	owner = media_owner_create(conn, msg, accesstype);
 	id = transport->resume(transport, owner);
 	if (id == 0) {
diff --git a/doc/media-api.txt b/doc/media-api.txt
index e5eeaa0..4853196 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -282,6 +282,13 @@ Methods		dict GetProperties()
 
 				"rw": Read and write access
 
+			The accesstype string can also be combined with a "?"
+			suffix, which will make the request optional. This
+			typically means the transport will only be acquired if
+			it is already available (remote-initiated), but
+			otherwise no request will be sent to the remote side.
+			In this last case the function will fail.
+
 		void Release(string accesstype)
 
 			Releases file descriptor.
-- 
1.7.7.6

