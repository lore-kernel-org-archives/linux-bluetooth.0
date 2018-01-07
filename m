Return-Path: <lukas@wunner.de>
Message-Id: <d342089a0c3f1d3180ea774cc2ad2263d2fa152d.1515348092.git.lukas@wunner.de>
In-Reply-To: <cover.1515348092.git.lukas@wunner.de>
References: <cover.1515348092.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 7 Jan 2018 20:16:32 +0100
Subject: [PATCH v3 12/13] Bluetooth: hci_bcm: Sleep instead of spinning
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The driver calls mdelay(15) in the ->suspend, ->resume, ->runtime_suspend
and ->runtime_resume hook, however spinning for such a long period of
time is discouraged as per Documentation/timers/timers-howto.txt.

The use of mdelay() seems unnecessary, it is allowed to sleep in the
system sleep and runtime PM hooks (with the exception of ->suspend_noirq
and ->resume_noirq) and the driver itself also does not rely on a
non-sleeping ->runtime_resume as the only place where a synchronous
resume is performed, in bcm_dequeue(), is called from a work item in
hci_ldisc.c and hci_serdev.c.

So replace the mdelay(15) with msleep(15).

Note that the delay is inserted after asserting or deasserting the
device wake pin, but in bcm_gpio_set_power() that pin is asserted or
deasserted *without* observing a delay.  It is thus unclear if the delay
is necessary at all.  It is likewise unclear why it is exactly 15 ms,
the commit introducing it, 118612fb9165 ("Bluetooth: hci_bcm: Add
suspend/resume PM functions"), does not provide a rationale.

Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/bluetooth/hci_bcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 5252b3ef5ad4..81e82ce2da96 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -657,7 +657,7 @@ static int bcm_suspend_device(struct device *dev)
 	}
 
 	bt_dev_dbg(bdev, "suspend, delaying 15 ms");
-	mdelay(15);
+	msleep(15);
 
 	return 0;
 }
@@ -676,7 +676,7 @@ static int bcm_resume_device(struct device *dev)
 	}
 
 	bt_dev_dbg(bdev, "resume, delaying 15 ms");
-	mdelay(15);
+	msleep(15);
 
 	/* When this executes, the device has woken up already */
 	if (bdev->is_suspended && bdev->hu) {
-- 
2.15.1
