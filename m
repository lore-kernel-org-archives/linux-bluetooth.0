Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] Bluetooth: Remove not needed status parameter
Date: Thu, 19 Apr 2012 16:12:28 +0200
Message-ID: <1334844749-13441-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1334844749-13441-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <y>
 <1334844749-13441-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sco_conn_add is called from two places and always with status = 0.

Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
---
 net/bluetooth/sco.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 32c0e31..d20d719 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -94,12 +94,12 @@ static void sco_sock_clear_timer(struct sock *sk)
 }
 
 /* ---- SCO connections ---- */
-static struct sco_conn *sco_conn_add(struct hci_conn *hcon, __u8 status)
+static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 {
 	struct hci_dev *hdev = hcon->hdev;
 	struct sco_conn *conn = hcon->sco_data;
 
-	if (conn || status)
+	if (conn)
 		return conn;
 
 	conn = kzalloc(sizeof(struct sco_conn), GFP_ATOMIC);
@@ -200,7 +200,7 @@ static int sco_connect(struct sock *sk)
 		goto done;
 	}
 
-	conn = sco_conn_add(hcon, 0);
+	conn = sco_conn_add(hcon);
 	if (!conn) {
 		hci_conn_put(hcon);
 		err = -ENOMEM;
@@ -920,7 +920,7 @@ int sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 	if (!status) {
 		struct sco_conn *conn;
 
-		conn = sco_conn_add(hcon, status);
+		conn = sco_conn_add(hcon);
 		if (conn)
 			sco_conn_ready(conn);
 	} else
-- 
1.7.9.4

