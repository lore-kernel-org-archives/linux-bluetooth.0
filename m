Return-Path: <cyrus@holtmann.org>
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, mdpoole@troilus.org,
	"Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH] HID:magicmouse: This fixes a connection problem with the magicmouse.
Date: Tue, 11 May 2010 09:29:23 -0700
Message-Id: <1273595363-4020-1-git-send-email-justinmattock@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the latest HEAD, I've noticed that I needed to add: HIDRAW=y
in order for my apple magicmouse to connect.
After receiving some posts, it seems this it not
the case(HIDRAW just relays HID events to userspace).

The bisect results of this issue resulted in commit:
HID:magicmouse: fix oops after device removal.
(hash:28918c211d86b6eeb70182c523800c7bc442960c)

After examining this commit, I've noticed that
HID_CONNECT_DEFAULT has also an entry in there
of HID_CONNECT_HIDINPUT, not sure what "~" means,
before HID_CONNECT_HIDINPUT, but after removing
this(correct me if I'm wrong)"double" definition, 
I'm able to have my magicmouse connect without the 
need of HIDRAW, and also this in dmesg:

magicmouse 0005:05AC:030D.0004: claimed by neither input, hiddev nor hidraw
magicmouse 0005:05AC:030D.0004: magicmouse hw start failed

and as well as the crash that the above commit fixes when waking
up from suspend(mouse connects perfectly upon wakeup).

Please have a look, and if this works, take it
if theres another solution let me know.
(so I can enjoy the power of the magicmouse!!).


Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 drivers/hid/hid-magicmouse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 0d471fc..0de5e96 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -354,7 +354,7 @@ static int magicmouse_probe(struct hid_device *hdev,
 		goto err_free;
 	}
 
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_HIDINPUT);
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret) {
 		dev_err(&hdev->dev, "magicmouse hw start failed\n");
 		goto err_free;
-- 
1.6.5.GIT

