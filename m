Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Fix pad button definition in hid-wacom.c
From: =?UTF-8?Q?Przemys=C5=82aw?= Firszt <przemo@firszt.eu>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, jkosina@suse.cz
Content-Type: multipart/mixed; boundary="=-dsdWLKzLr/pC3/31KadP"
Date: Sun, 03 Jan 2010 18:46:37 +0000
Message-ID: <1262544397.10071.60.camel@pldmachine>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-dsdWLKzLr/pC3/31KadP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,
Please check attached patch and apply if it's possible.
The patch was also discussed here:
http://www.mail-archive.com/linuxwacom-devel@lists.sourceforge.net/msg00128.htm

--
Regards,
Przemo Firszt

--=-dsdWLKzLr/pC3/31KadP
Content-Disposition: attachment; filename="0001-Fix-pad-button-definition-in-hid-wacom.c.patch"
Content-Type: text/x-patch; name="0001-Fix-pad-button-definition-in-hid-wacom.c.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 63d3fd45f4ef9e02a1073f1c8b1adf226ac66cf3 Mon Sep 17 00:00:00 2001
From: Przemo Firszt <przemo@firszt.eu>
Date: Sun, 3 Jan 2010 18:31:31 +0000
Subject: [PATCH] Fix pad button definition in hid-wacom.c

This fix is required for xorg driver to recognise 2 pad buttons
Signed-off-by: Przemo Firszt <przemo@firszt.eu>
---
 drivers/hid/hid-wacom.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 7475421..75ea66a 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -196,6 +196,9 @@ static int wacom_probe(struct hid_device *hdev,
 	/* Pad */
 	input->evbit[0] |= BIT(EV_MSC);
 	input->mscbit[0] |= BIT(MSC_SERIAL);
+	set_bit(BTN_0, input->keybit);
+	set_bit(BTN_1, input->keybit);
+	set_bit(BTN_TOOL_FINGER, input->keybit);
 
 	/* Distance, rubber and mouse */
 	input->absbit[0] |= BIT(ABS_DISTANCE);
-- 
1.6.5.7


--=-dsdWLKzLr/pC3/31KadP--
