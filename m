Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth:hci_qua: Coding style clean up
Date: Tue, 15 Sep 2015 12:19:45 +0000
Message-ID: <20150915121939.GA3369@jci-VirtualBox>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

Cleanup patch to fix spaces required reported by checkpatch

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/hci_qca.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index a8aa077..21f4ea4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -181,8 +181,8 @@ static void serial_clock_vote(unsigned long vote, struc=
t hci_uart *hu)
 		else
 			__serial_clock_off(hu->tty);

-		BT_DBG("Vote serial clock %s(%s)", new_vote? "true" : "false",
-		       vote? "true" : "false");
+		BT_DBG("Vote serial clock %s(%s)", new_vote ? "true" : "false",
+		       vote ? "true" : "false");

 		diff =3D jiffies_to_msecs(jiffies - qca->vote_last_jif);

@@ -821,7 +821,7 @@ static struct sk_buff *qca_dequeue(struct hci_uart *hu)

 static uint8_t qca_get_baudrate_value(int speed)
 {
-	switch(speed) {
+	switch (speed) {
 	case 9600:
 		return QCA_BAUDRATE_9600;
 	case 19200:
--
1.9.1
