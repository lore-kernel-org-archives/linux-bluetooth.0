Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, hadess@hadess.net, padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 4/5] Remove 16 byte limit for PIN codes returned by agents
Date: Thu,  5 May 2011 21:17:19 +0200
Message-Id: <1304623040-30461-4-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1304623040-30461-1-git-send-email-dh.herrmann@googlemail.com>
References: <1304623040-30461-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Agents can now return PIN codes longer than 16 characters. The
pin parser automatically truncates all PINs to 16 characters, but
allows hexadecimal PINs to be longer than 16 characters because
each two hexdecimal encoded bytes are parsed into one output byte.
---
 src/agent.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index f87f253..40495bf 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -403,7 +403,7 @@ static void pincode_reply(DBusPendingCall *call, void *user_data)
 	len = strlen(pin);
 
 	dbus_error_init(&err);
-	if (len > 16 || len < 1) {
+	if (len < 1) {
 		error("Invalid PIN length (%zu) from agent", len);
 		dbus_set_error_const(&err, "org.bluez.Error.InvalidArgs",
 					"Invalid passkey length");
-- 
1.7.5

