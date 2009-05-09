Return-Path: <cyrus@holtmann.org>
Subject: Re: Security mode 3 pairing acceptor broken with current
 bluetooth-testing
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090509085925.GA4205@jh-x301>
References: <20090508234902.GA6615@jh-x301>
	 <1241827683.4903.78.camel@localhost.localdomain>
	 <20090509085925.GA4205@jh-x301>
Content-Type: multipart/mixed; boundary="=-CMjsu++qNP6YZr+xs1+T"
Date: Sat, 09 May 2009 09:53:22 -0700
Message-Id: <1241888002.4903.92.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-CMjsu++qNP6YZr+xs1+T
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Johan,

> > what is the time between the PIN code request and the cancel command?
> 
> It is almost immediate. Here's the timings before your patch:
> 
> 1241826073.405723 > HCI Event: Connect Request (0x04) plen 10
> 1241826073.405782 < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> 1241826073.407540 > HCI Event: Command Status (0x0f) plen 4
> 1241826073.569728 > HCI Event: Role Change (0x12) plen 8
> 1241826073.717728 > HCI Event: Link Key Request (0x17) plen 6
> 1241826073.718103 < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
> 1241826073.719726 > HCI Event: Command Complete (0x0e) plen 10
> 1241826073.720548 > HCI Event: PIN Code Request (0x16) plen 6
> 1241826073.732176 < HCI Command: Create Connection Cancel (0x01|0x0008) plen 6
> 
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -171,7 +171,7 @@ static void hci_conn_timeout(unsigned long arg)
> >         switch (conn->state) {
> >         case BT_CONNECT:
> >         case BT_CONNECT2:
> > -               if (conn->type == ACL_LINK)
> > +               if (conn->type == ACL_LINK && conn->out)
> >                         hci_acl_connect_cancel(conn);
> >                 else
> >                         hci_acl_disconn(conn, 0x13);
> > 
> > The above patch might fixes it. However without the timing between the
> > commands, I don't know what triggers it.
> 
> Thanks for the patch. Unfortunately it doesn't fix the issue, though it does
> show that it is this hci_conn_timeout function that's to blame of the
> situation. Here's what happens with your patch:
> 
> 1241859026.835365 < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> 1241859026.837313 > HCI Event: Command Status (0x0f) plen 4
> 1241859026.999322 > HCI Event: Role Change (0x12) plen 8
> 1241859027.147328 > HCI Event: Link Key Request (0x17) plen 6
> 1241859027.147583 < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
> 1241859027.149329 > HCI Event: Command Complete (0x0e) plen 10
> 1241859027.150324 > HCI Event: PIN Code Request (0x16) plen 6
> 1241859027.164053 < HCI Command: Disconnect (0x01|0x0006) plen 3

I was expecting that it still fails, but at least it doesn't try to
cancel a connection it hasn't attempted to create.

> One problem here is that from the host perspective there's no ACL yet
> since there hasn't been any "connect complete" event. So HCI_Disconnect is
> incorrect in this case and doesn't even have a real handle to give so it
> looks like (hcidump -V):
> 
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>     handle 0 reason 0x13
>     Reason: Remote User Terminated Connection
> 
> I'll do some investigation later today to try to figure out why this
> timeout function gets immediately triggered.

So we have two problems here. The conn_cancel vs conn_disconnect is a
mistake, I have added when adding eSCO support and I really think this
is a total thinko and would never be triggered. Since as you say, a
connection in BT_CONNECT state never has a valid handle anyway. So that
needs changing.

The second is that on a PIN code request we switch to a longer pairing
timeout. However this only works for outgoing connections. For incoming
connections the timeout is still almost instantly. So if a connection is
not in BT_CONNECTED state yet, then there is no point in adapting the
timeout here. The attached patch does this.

Question is now what happens to a remote device doing dedicated bonding
(without using security mode 3) and using legacy pairing. This should
not work either. Can you test that.

Regards

Marcel


--=-CMjsu++qNP6YZr+xs1+T
Content-Disposition: attachment; filename="patch"
Content-Type: text/x-patch; name="patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 78a1d10..24430c2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -171,10 +171,8 @@ static void hci_conn_timeout(unsigned long arg)
 	switch (conn->state) {
 	case BT_CONNECT:
 	case BT_CONNECT2:
-		if (conn->type == ACL_LINK && conn->out)
+		if (conn->out)
 			hci_acl_connect_cancel(conn);
-		else
-			hci_acl_disconn(conn, 0x13);
 		break;
 	case BT_CONFIG:
 	case BT_CONNECTED:
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4e7cb88..184ba0a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1493,7 +1493,7 @@ static inline void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (conn) {
+	if (conn && conn->state == BT_CONNECTED) {
 		hci_conn_hold(conn);
 		conn->disc_timeout = HCI_PAIRING_TIMEOUT;
 		hci_conn_put(conn);

--=-CMjsu++qNP6YZr+xs1+T--

