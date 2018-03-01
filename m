Return-Path: <kai.heng.feng@canonical.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	stable@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] Bluetooth: btusb: Add Dell OptiPlex 3060 to btusb_needs_reset_resume_table
Date: Thu,  1 Mar 2018 13:42:52 +0800
Message-Id: <20180301054252.16007-1-kai.heng.feng@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The issue can be reproduced before commit fd865802c66b ("Bluetooth:
btusb: fix QCA Rome suspend/resume") gets introduced, so the reset
resume quirk is still needed for this system.

T:  Bus=01 Lev=01 Prnt=01 Port=13 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0cf3 ProdID=e007 Rev=00.01
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Cc: stable@vger.kernel.org
Cc: Brian Norris <briannorris@chromium.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/bluetooth/btusb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c5cebf53eae5..e98fb5343a00 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -389,6 +389,13 @@ static const struct usb_device_id blacklist_table[] = {
  * the module itself. So we use a DMI list to match known broken platforms.
  */
 static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
+	{
+		/* Dell OptiPlex 3060 (QCA ROME device 0cf3:e007) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 3060"),
+		},
+	},
 	{}
 };
 
-- 
2.15.1
