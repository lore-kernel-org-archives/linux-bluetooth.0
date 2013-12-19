Return-Path: <cyrus@holtmann.org>
Message-ID: <1387487227.986.30.camel@bali>
Subject: Re: [RFC v4 05/12] Bluetooth: Stop scanning on LE connection
From: Andre Guedes <andre.guedes@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 19 Dec 2013 18:07:07 -0300
In-Reply-To: <20131218111116.GA25848@x220.p-661hnu-f1>
References: <1386367549-29136-1-git-send-email-andre.guedes@openbossa.org>
	 <1386367549-29136-6-git-send-email-andre.guedes@openbossa.org>
	 <20131210132131.GA10392@x220.p-661hnu-f1> <1387289112.1231.21.camel@bali>
	 <20131218111116.GA25848@x220.p-661hnu-f1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, 2013-12-18 at 13:11 +0200, Johan Hedberg wrote:
> Hi Andre,
> 
> On Tue, Dec 17, 2013, Andre Guedes wrote:
> > > > @@ -518,8 +518,17 @@ static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
> > > >  {
> > > >  	struct hci_conn *conn;
> > > >  
> > > > -	if (status == 0)
> > > > +	if (status == 0) {
> > > > +		/* If the discovery procedure was running, we prematurely
> > > > +		 * stopped it. So we have to change the discovery state.
> > > > +		 */
> > > > +		if (hdev->discovery.state == DISCOVERY_FINDING) {
> > > > +			cancel_delayed_work(&hdev->le_scan_disable);
> > > > +			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> > > > +		}
> > > > +
> > > >  		return;
> > > > +	}
> > > >  
> > > >  	BT_ERR("HCI request failed to create LE connection: status 0x%2.2x",
> > > >  	       status);
> > > > @@ -552,6 +561,18 @@ static int hci_create_le_conn(struct hci_conn *conn)
> > > >  
> > > >  	hci_req_init(&req, hdev);
> > > >  
> > > > +	/* If controller is scanning, we stop it since some controllers are
> > > > +	 * not able to scan and connect at the same time.
> > > > +	 */
> > > > +	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags)) {
> > > > +		struct hci_cp_le_set_scan_enable enable_cp;
> > > > +
> > > > +		memset(&enable_cp, 0, sizeof(enable_cp));
> > > > +		enable_cp.enable = LE_SCAN_DISABLE;
> > > > +		hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
> > > > +			    &enable_cp);
> > > > +	}
> > > > +
> > > >  	memset(&cp, 0, sizeof(cp));
> > > >  	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
> > > >  	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
> > > 
> > > The way this all hangs together with a discovery process started through
> > > mgmt_start_discovery feels a bit flimsy to me. Particularly, have you
> > > ensured that everything is fine if you've got inquiry ongoing when you
> > > do hci_discovery_set_state(hdev, DISCOVERY_STOPPED). Also, are there any
> > > risks of race conditions here, e.g. is it fine to let the
> > > cancel_delayed_work() call be in create_le_conn_complete() instead of
> > > doing it in hci_create_le_conn()?
> > 
> > Yes, I did lots of testing, including the inquiry test you mentioned,
> > and I didn't find any issues.
> > 
> > I failed to see any race conditons since cancel_delayed_work() does not
> > block. So it is fine to call cancel_delayed_work() in
> > create_le_conn_complete() as well as in hci_create_le_conn().
> 
> I presume you'd want to prevent the delayed work from getting called as
> soon as you've entered the if (test_bit(HCI_LE_SCAN)) section in
> hci_create_le_conn? In theory it might get called before
> create_le_conn_complete. In such a scenario
> le_scan_disable_work_complete could e.g. trigger inquiry before
> create_le_conn_complete is called, couldn't it?

Yes, this scenario can indeed happen in a very short window. However, it
doesn't seem to be a big issue. If that happen then the discovery
procedure keeps running normally and the connection attempt fails. If it
is a auto connection then the kernel will retry in a near future. If it
a user connection, it will get a busy error.   

> > > What also makes this hard to track is that the condition you're testing
> > > for first is the HCI_LE_SCAN bit, but then later you look at
> > > discovery.state == DISCOVERY_FINDING. For the casual reader there's no
> > > direct indication of how these two are releated for the various types of
> > > discovery that are possible (LE-only, BR/EDR-only and interleaved).
> > 
> > Yes, I see your point. However, we can't check HCI_LE_SCAN in
> > create_le_conn_complete() because the flag was already cleared in
> > hci_cc_le_set_scan_enable().
> 
> Understood.
> 
> > > I don't mean to say that this is a nack for the patch, but I'd like to
> > > know that you've considered and tested this kind of cases. I had to
> > > spend quite some time looking through the existing code and this patch
> > > and still couldn't arrive at absolute confidence of its correctness,
> > > meaning there should hopefully be some room for simplification.
> > 
> > So I think we can do some simplification by moving this discovery
> > handling from create_le_conn_complete() to hci_create_le_conn(), at
> > least I think this code will become a bit easier to follow. What do you
> > think?
> 
> I think it would at least close the potential race I described above,
> i.e. the delayed work getting triggered before create_le_conn_complete.

I realized this approach is not good enough since we'll be changing
discovery state before being sure the HCI command executed successfully.
This could let the discovery state inconsistent.

So after spending some time thinking about this issue, I believe the
better way to handle this is taking it in two steps. First, we simply
stop scanning and handle the discovery state. Then we create the LE
connection.

I'm already working on this "two steps" approach and I should send the
v5 patch set very soon.

Regards,

Andre

