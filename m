Return-Path: <cyrus@holtmann.org>
Message-ID: <1346378760.7976.2.camel@obelisk.thedillows.org>
Subject: [PATCH] Add support for Logitech Harmony Adapter for PS3
From: David Dillow <dave@thedillows.org>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 30 Aug 2012 22:06:00 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This emulates a Sony BD Remote for the Logitech Harmony series of
universal remotes.
--
 profiles/input/fakehid.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/profiles/input/fakehid.c b/profiles/input/fakehid.c
index 3be1489..dd47287 100644
--- a/profiles/input/fakehid.c
+++ b/profiles/input/fakehid.c
@@ -342,6 +342,16 @@ static struct fake_hid fake_hid_table[] = {
 		.setup_uinput	= ps3remote_setup_uinput,
 		.devices	= NULL,
 	},
+	/* Logitech Harmony Adapter for PS3 */
+	{
+		.vendor		= 0x046d,
+		.product	= 0x0306,
+		.connect	= fake_hid_common_connect,
+		.disconnect	= fake_hid_common_disconnect,
+		.event		= ps3remote_event,
+		.setup_uinput	= ps3remote_setup_uinput,
+		.devices	= NULL,
+	},
 
 	{ },
 };


