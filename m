Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jeremy Cline <jeremy@jcline.org>,
	linux-bluetooth@vger.kernel.org,
	stable@vger.kernel.org,
	Garrett LeSage <glesage@redhat.com>
Subject: [PATCH] Bluetooth: btusb: Add Dell XPS 13 9360 to btusb_needs_reset_resume_table
Date: Thu, 26 Apr 2018 20:52:06 +0200
Message-Id: <20180426185206.29508-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The Dell XPS 13 9360 uses a QCA Rome chip which needs to be reset
(and have its firmware reloaded) for bluetooth to work after
suspend/resume.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
Cc: stable@vger.kernel.org
Cc: Garrett LeSage <glesage@redhat.com>
Reported-and-tested-by: Garrett LeSage <glesage@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btusb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ee31c997e695..55693648b211 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -399,6 +399,13 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 3060"),
 		},
 	},
+	{
+		/* Dell XPS 9360 (QCA ROME device 0cf3:e300) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9360"),
+		},
+	},
 	{}
 };
 
-- 
2.17.0
