Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 7 Jan 2014 22:23:08 +0800
Message-ID: <CAPgLHd9XikeBP3moVKugtsAD83CD1HqE82KeYOyYNdY+=0vctQ@mail.gmail.com>
Subject: [PATCH -next] Bluetooth: Convert to use ATTRIBUTE_GROUPS macro
From: Wei Yongjun <weiyj.lk@gmail.com>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
Cc: yongjun_wei@trendmicro.com.cn, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Use ATTRIBUTE_GROUPS macro to reduce the number of lines of code.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 net/bluetooth/hci_sysfs.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 0b61250..555982a 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -49,14 +49,7 @@ static struct attribute *bt_link_attrs[] = {
 	NULL
 };
 
-static struct attribute_group bt_link_group = {
-	.attrs = bt_link_attrs,
-};
-
-static const struct attribute_group *bt_link_groups[] = {
-	&bt_link_group,
-	NULL
-};
+ATTRIBUTE_GROUPS(bt_link);
 
 static void bt_link_release(struct device *dev)
 {
@@ -182,14 +175,7 @@ static struct attribute *bt_host_attrs[] = {
 	NULL
 };
 
-static struct attribute_group bt_host_group = {
-	.attrs = bt_host_attrs,
-};
-
-static const struct attribute_group *bt_host_groups[] = {
-	&bt_host_group,
-	NULL
-};
+ATTRIBUTE_GROUPS(bt_host);
 
 static void bt_host_release(struct device *dev)
 {
