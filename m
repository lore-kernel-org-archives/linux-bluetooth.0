Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Oct 2012 11:22:37 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv1 03/11] Bluetooth: AMP: Process Physical Link Complete evt
Message-ID: <20121029092236.GA9314@aemeltch-MOBL1>
References: <1350493622.26318.114.camel@aeonflux>
 <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1351167652-12346-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1210261012440.2459@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1210261012440.2459@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Fri, Oct 26, 2012 at 10:16:53AM -0700, Mat Martineau wrote:\
...
> >+static void hci_phy_link_complete_evt(struct hci_dev *hdev,
> >+				      struct sk_buff *skb)
> >+{
> >+	struct hci_ev_phy_link_complete *ev = (void *) skb->data;
> >+	struct hci_conn *hcon, *bredr_hcon;
> >+
> >+	BT_DBG("%s handle 0x%2.2x status 0x%2.2x", hdev->name, ev->phy_handle,
> >+	       ev->status);
> >+
> >+	hci_dev_lock(hdev);
> >+
> >+	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
> >+	if (!hcon) {
> >+		hci_dev_unlock(hdev);
> >+		return;
> >+	}
> >+
> >+	if (ev->status) {
> >+		hci_conn_del(hcon);
> >+		hci_dev_unlock(hdev);
> >+		return;
> >+	}
> >+
> >+	bredr_hcon = hcon->amp_mgr->l2cap_conn->hcon;
> >+
> >+	hcon->state = BT_CONNECTED;
> >+	bacpy(&hcon->dst, &bredr_hcon->dst);
> >+
> >+	hci_conn_hold(hcon);
> >+	hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
> >+	hci_conn_put(hcon);
> >+
> >+	hci_conn_hold_device(hcon);
> >+	hci_conn_add_sysfs(hcon);
> >+
> >+	hci_dev_unlock(hdev);
> >+
> >+	if (hcon->out) {
> >+		struct hci_dev *bredr_hdev = hci_dev_hold(bredr_hcon->hdev);
> >+
> >+		if (!bredr_hdev)
> >+			return;
> >+
> >+		/* Placeholder - create chan req
> >+		l2cap_chan_create_cfm(bredr_hcon, hcon->remote_id);
> >+		*/
> 
> I think this is where you would call l2cap_physical_cfm(), but that
> function requires more information.  Is there enough context in hcon
> to get the local amp ID 

This one is easy to manage: hcon->dev->id

> and l2cap_chan, or does the AMP manager need
> to be notified of the physical link so it can match up the physical
> link with other information?

I get chan from amp_mgr through hcon->amp_mgr

I will send the patch later this week.

Best regards 
Andrei Emeltchenko 
