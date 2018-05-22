Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add Dell Inspiron 5565 to btusb_needs_reset_resume_table
Date: Tue, 22 May 2018 09:34:10 +0200
Message-Id: <20180522073410.10329-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The Dell Inspiron 5565 uses a QCA Rome chip which needs to be reset
(and have its firmware reloaded) for bluetooth to work after
suspend/resume.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=15750392
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btusb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b937cc1e2c07..8932855634b2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -406,6 +406,13 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9360"),
 		},
 	},
+	{
+		/* Dell Inspiron 5565 (QCA ROME device 0cf3:e009) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5565"),
+		},
+	},
 	{}
 };
 
-- 
2.17.0
