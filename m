Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: Jeff Hansen <jhansen@cardaccess-inc.com>
From: Jeff Hansen <x@jeffhansen.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Jeff Hansen <x@jeffhansen.com>
Subject: [PATCH] [input] Set up uinput device again, if it was previously closed.
Date: Sun,  4 Mar 2012 20:44:19 -0700
Message-Id: <1330919059-5493-1-git-send-email-x@jeffhansen.com>
List-ID: <linux-bluetooth.vger.kernel.org>

If you connect a PS3 controller to bluetoothd as an input device, then
take the batteries out of a PS3 controller, then put them back in and
push a few buttons, it will eventually cause an error which causes the
uinput socket to be closed. It will then re-connect to bluetoothd, but
the uinput socket fd will be -1, so it needs to be set up again after
the re-connect.

Signed-off-by: Jeff Hansen <x@jeffhansen.com>
---
 input/fakehid.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/input/fakehid.c b/input/fakehid.c
index eebca05..a83f8c3 100644
--- a/input/fakehid.c
+++ b/input/fakehid.c
@@ -393,12 +393,15 @@ struct fake_input *fake_hid_connadd(struct fake_input *fake,
 
 	/* New device? Add it to the list of known devices,
 	 * and create the uinput necessary */
-	if (old == NULL) {
+	if (old == NULL || old->uinput == -1) {
 		if (fake_hid->setup_uinput(fake, fake_hid)) {
 			error("Error setting up uinput");
 			g_free(fake);
 			return NULL;
 		}
+	}
+
+	if (old == NULL) {
 		fake_hid->devices = g_list_append(fake_hid->devices, fake);
 	}
 
-- 
1.7.3.4
