Return-Path: <cyrus@holtmann.org>
From: Joe Perches <joe@perches.com>
To: Jiri Kosina <trivial@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/36] drivers/bluetooth: Remove unnecessary casts of private_data
Date: Mon, 12 Jul 2010 13:49:57 -0700
Message-Id: <2c766ab749f348012f0338eb41ec0b938a65044e.1278967120.git.joe@perches.com>
In-Reply-To: <cover.1278967120.git.joe@perches.com>
References: <cover.1278967120.git.joe@perches.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/bluetooth/btmrvl_debugfs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_debugfs.c b/drivers/bluetooth/btmrvl_debugfs.c
index b50b41d..54739b0 100644
--- a/drivers/bluetooth/btmrvl_debugfs.c
+++ b/drivers/bluetooth/btmrvl_debugfs.c
@@ -216,7 +216,7 @@ static const struct file_operations btmrvl_gpiogap_fops = {
 static ssize_t btmrvl_hscmd_write(struct file *file, const char __user *ubuf,
 						size_t count, loff_t *ppos)
 {
-	struct btmrvl_private *priv = (struct btmrvl_private *) file->private_data;
+	struct btmrvl_private *priv = file->private_data;
 	char buf[16];
 	long result, ret;
 
-- 
1.7.1.337.g6068.dirty
