Return-Path: <cyrus@holtmann.org>
Message-ID: <4B8788DD.8080706@atheros.com>
Date: Fri, 26 Feb 2010 14:09:57 +0530
From: Suraj Sumangala <suraj@atheros.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Vikram Kandukuri <Vikram.Kandukuri@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "Luis
 Rodriguez" <Luis.Rodriguez@Atheros.com>, Jothikumar Mothilal
	<Jothikumar.Mothilal@Atheros.com>, Zhongyi Chen <Zhongyi.Chen@Atheros.com>
Subject: link starvation during multi profile scenario
References: <20100209114231.GA6587@ATH-LT-538> <1266805799.18491.33.camel@violet> <4B836ABE.70505@atheros.com>
In-Reply-To: <4B836ABE.70505@atheros.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I am facing an issue on Bluetooth Multiprofile secnario on CSR board as 
well as Atheros board on Ubuntu git tree head source.
The scenario is
1. From Ubuntu make A2DP connection
2. Start Streaming
3. From Ubuntu do FTP connection
4. Send file from Ubuntu to remote device.
5. Take A2DP sink (Headset) out of range.
6. FTP operation stops.

 From my observation, it looks like the stalled A2DP connection is using 
up all HCI buffers and starving the FTP connection of HCI buffers.
I have written a small enhancement for this scenario.
Please have a look at it and let me know if you have a cleaner and 
better implementation.

Please find my changes below,

Regards
Suraj

Author: Suraj Sumangala <suraj@atheros.com>
Date: Fri Feb 26 12:16:50 2010 +0530

Avoid link starvation in multi-link scenario
Signed-off-by: <suraj@atheros.com>

diff --git a/include/net/bluetooth/hci_core.h 
b/include/net/bluetooth/hci_core.h
index ce3c99e..fcae633 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -181,6 +181,9 @@ struct hci_conn {

unsigned int sent;

+
+ unsigned int acl_avail;
+
struct sk_buff_head data_q;

struct timer_list disc_timer;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4ad2319..10b80c4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1359,6 +1359,9 @@ static inline struct hci_conn *hci_low_sent(struct 
hci_dev *hdev, __u8 type, int
if (c->state != BT_CONNECTED && c->state != BT_CONFIG)
continue;

+ if (c->acl_avail == 0)
+ continue;
+
num++;

if (c->sent < min) {
@@ -1423,6 +1426,10 @@ static inline void hci_sched_acl(struct hci_dev 
*hdev)

hdev->acl_cnt--;
conn->sent++;
+
+ if (conn->acl_avail != 0)
+ conn->acl_avail--;
+
}
}
}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 592da5c..18dbdc2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -900,6 +900,7 @@ static inline void hci_conn_complete_evt(struct 
hci_dev *hdev, struct sk_buff *s
if (conn->type == ACL_LINK) {
struct hci_cp_read_remote_features cp;
cp.handle = ev->handle;
+ conn->acl_avail = hdev->acl_pkts;
hci_send_cmd(hdev, HCI_OP_READ_REMOTE_FEATURES,
sizeof(cp), &cp);
}
@@ -1447,6 +1448,9 @@ static inline void hci_num_comp_pkts_evt(struct 
hci_dev *hdev, struct sk_buff *s
if (conn->type == ACL_LINK) {
if ((hdev->acl_cnt += count) > hdev->acl_pkts)
hdev->acl_cnt = hdev->acl_pkts;
+
+ conn->acl_avail = count;
+
} else {
if ((hdev->sco_cnt += count) > hdev->sco_pkts)
hdev->sco_cnt = hdev->sco_pkts;
