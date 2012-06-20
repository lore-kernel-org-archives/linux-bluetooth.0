Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix warning: using int as NULL pointer
Date: Wed, 20 Jun 2012 14:40:12 +0300
Message-Id: <1340192412-30161-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fix for warnings below:

...
drivers/bluetooth/bt3c_cs.c:667:20: warning: Using plain integer
	as NULL pointer
drivers/bluetooth/btuart_cs.c:596:20: warning: Using plain integer
	as NULL pointer
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 drivers/bluetooth/bt3c_cs.c   |    2 +-
 drivers/bluetooth/btuart_cs.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index b2b0fbb..8925b6d 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -664,7 +664,7 @@ static int bt3c_check_config(struct pcmcia_device *p_dev, void *priv_data)
 {
 	int *try = priv_data;
 
-	if (try == 0)
+	if (!try)
 		p_dev->io_lines = 16;
 
 	if ((p_dev->resource[0]->end != 8) || (p_dev->resource[0]->start == 0))
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index 65b8d99..21e803a 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -593,7 +593,7 @@ static int btuart_check_config(struct pcmcia_device *p_dev, void *priv_data)
 {
 	int *try = priv_data;
 
-	if (try == 0)
+	if (!try)
 		p_dev->io_lines = 16;
 
 	if ((p_dev->resource[0]->end != 8) || (p_dev->resource[0]->start == 0))
-- 
1.7.9.5

