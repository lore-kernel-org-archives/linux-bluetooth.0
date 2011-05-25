Return-Path: <cyrus@holtmann.org>
Subject: Add little note to the docs
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Wed, 25 May 2011 16:34:05 +0100
Content-Type: multipart/mixed; boundary="=-vqPgtzwTOuu5TQeH6gjL"
Message-ID: <1306337646.2010.219.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-vqPgtzwTOuu5TQeH6gjL
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Heya,

If one didn't read the Bluetooth 2.1 specs, we could easily miss that
particular point. Passkeys used for SSP need to have zeros prepended if
they are less than 6 digits long.

Added to the docs in the patch below, and will fix the bugs in
gnome-bluetooth.

Cheers

--=-vqPgtzwTOuu5TQeH6gjL
Content-Disposition: attachment;
	filename="0001-doc-Add-mention-of-the-6-digit-padding-problem.patch"
Content-Type: text/x-patch;
	name="0001-doc-Add-mention-of-the-6-digit-padding-problem.patch";
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 86b5302feedd578256aea400b8f220515220885e Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 25 May 2011 16:30:09 +0100
Subject: [PATCH] doc: Add mention of the 6-digit padding problem

Passkeys used for Secure Simple pairing should always appear
zero-padded in the end-user display, as per specification
(5.4 ASSOCIATION MODELS in BLUETOOTH SPECIFICATION Version 2.1 + EDR
 [vol 1])
---
 doc/agent-api.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index 0c84e1c..fca2875 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -63,6 +63,10 @@ Methods		void Release()
 			During the pairing process this method might be
 			called multiple times to update the entered value.
 
+			Note that the passkey will always be a 6-digit number,
+			so the display should be zero-padded at the start if
+			the value contains less than 6 digits.
+
 		void RequestConfirmation(object device, uint32 passkey)
 
 			This method gets called when the service daemon
@@ -71,6 +75,10 @@ Methods		void Release()
 			To confirm the value it should return an empty reply
 			or an error in case the passkey is invalid.
 
+			Note that the passkey will always be a 6-digit number,
+			so the display should be zero-padded at the start if
+			the value contains less than 6 digits.
+
 			Possible errors: org.bluez.Error.Rejected
 			                 org.bluez.Error.Canceled
 
-- 
1.7.5.1


--=-vqPgtzwTOuu5TQeH6gjL--

