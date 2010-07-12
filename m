Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/3] Bluetooth: Synchronize SCO/eSCO connection
 requests to ACL state
From: Marcel Holtmann <marcel@holtmann.org>
To: Ron Shaffer <rshaffer@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1278968772-29446-1-git-send-email-rshaffer@codeaurora.org>
References: <1278625779.10421.80.camel@localhost.localdomain>
	 <1278968772-29446-1-git-send-email-rshaffer@codeaurora.org>
Content-Type: multipart/mixed; boundary="=-bZ4c6PNe6OEoQsGEqVcg"
Date: Mon, 12 Jul 2010 19:07:57 -0300
Message-ID: <1278972477.6282.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-bZ4c6PNe6OEoQsGEqVcg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Ron,

> Certain headsets such as the Motorola H350 will reject SCO and eSCO
> connection requests while the ACL is transitioning from sniff mode
> to active mode. Add synchronization so that SCO and eSCO connection
> requests will wait until the ACL has fully transitioned to active mode.

I find your patch actually highly complicated. So I tried to capture
your intend the in the attached patch (only compiled test) and it would
be good if you can try that.

So in general it makes no difference which mode we are in. If a mode
change is pending, then we have to delay the SCO setup. And once we are
done we the mode change we just setup the SCO link. So in theory that
should be enough. Not sure if that is true. I could have overlooked
something since I don't really have tested the patch at all ;)

Regards

Marcel


--=-bZ4c6PNe6OEoQsGEqVcg
Content-Disposition: attachment; filename="patch"
Content-Type: text/x-patch; name="patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 600372d..f508d2b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -256,6 +256,7 @@ enum {
 	HCI_CONN_ENCRYPT_PEND,
 	HCI_CONN_RSWITCH_PEND,
 	HCI_CONN_MODE_CHANGE_PEND,
+	HCI_CONN_SCO_SETUP_PEND,
 };
 
 static inline void hci_conn_hash_init(struct hci_dev *hdev)
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e9fef83..38c86f6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -385,6 +385,12 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 		acl->power_save = 1;
 		hci_conn_enter_active_mode(acl);
 
+		if (test_bit(HCI_CONN_MODE_CHANGE_PEND, &acl->pend)) {
+			/* defer SCO setup until mode change completed */
+			set_bit(HCI_CONN_SCO_SETUP_PEND, &acl->pend);
+			return sco;
+		}
+
 		if (lmp_esco_capable(hdev))
 			hci_setup_sync(sco, acl->handle);
 		else
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a969800..3500fe8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1481,6 +1481,15 @@ static inline void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb
 			else
 				conn->power_save = 0;
 		}
+
+		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->pend)) {
+			struct hci_conn *sco = conn->link;
+
+			if (lmp_esco_capable(hdev))
+				hci_setup_sync(sco, conn->handle);
+			else
+				hci_add_sco(sco, conn->handle);
+                }
 	}
 
 	hci_dev_unlock(hdev);

--=-bZ4c6PNe6OEoQsGEqVcg--

