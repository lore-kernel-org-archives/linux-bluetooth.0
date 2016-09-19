Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>,
        Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2 4/5] Bluetooth: Add supported data types to ext info changed event
Date: Mon, 19 Sep 2016 20:25:55 +0200
Message-Id: <1474309556-7447-4-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1474309556-7447-1-git-send-email-szymon.janc@codecoup.pl>
References: <1474309556-7447-1-git-send-email-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Michał Narajowski <michal.narajowski@codecoup.pl>

This patch adds EIR data to extended info changed event.

Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
---
 net/bluetooth/mgmt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d3837e0..29e5ce9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -954,12 +954,18 @@ static int read_ext_controller_info(struct sock *sk, struct hci_dev *hdev,
 
 static int ext_info_changed(struct hci_dev *hdev, struct sock *skip)
 {
-	struct mgmt_ev_ext_info_changed ev;
+	char buf[512];
+	struct mgmt_ev_ext_info_changed *ev = (void *)buf;
+	u16 eir_len;
 
-	ev.eir_len = cpu_to_le16(0);
+	memset(buf, 0, sizeof(buf));
+
+	eir_len = append_eir_data_to_buf(hdev, ev->eir);
+	ev->eir_len = cpu_to_le16(eir_len);
 
-	return mgmt_limited_event(MGMT_EV_EXT_INFO_CHANGED, hdev, &ev,
-				  sizeof(ev), HCI_MGMT_EXT_INFO_EVENTS, skip);
+	return mgmt_limited_event(MGMT_EV_EXT_INFO_CHANGED, hdev, ev,
+				  sizeof(*ev) + eir_len,
+				  HCI_MGMT_EXT_INFO_EVENTS, skip);
 }
 
 static int send_settings_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev)
-- 
2.7.4

