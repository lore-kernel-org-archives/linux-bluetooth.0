Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Mar 2012 18:06:11 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: don't increment twice in eir_has_data_type()
Message-ID: <20120320150611.GA24873@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I don't have this hardware, and I'm not familiar with this code.  It
just looked suspicious that we move the parsed counter forward faster
than the data pointer.  We do it once in middle the loop and again as
the for loop incrementer.  The effect is that we only search half the
data_len before returning false.

Also I've changed the breaks to just return false directly because it
made the code easier to follow.

I wrote this patch based on a guess of what the data might look like so
it's very likely wrong.  Could you maybe treat it as a bug report and
give me a Reported-by?

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8dc07fa..ff79f41 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -912,22 +912,17 @@ static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
 static inline bool eir_has_data_type(u8 *data, size_t data_len, u8 type)
 {
 	u8 field_len;
-	size_t parsed;
+	size_t parsed = 0;
 
-	for (parsed = 0; parsed < data_len - 1; parsed += field_len) {
+	while (parsed < data_len - 1) {
 		field_len = data[0];
 
 		if (field_len == 0)
-			break;
-
-		parsed += field_len + 1;
-
-		if (parsed > data_len)
-			break;
-
+			return false;
 		if (data[1] == type)
 			return true;
 
+		parsed += field_len + 1;
 		data += field_len + 1;
 	}
 
