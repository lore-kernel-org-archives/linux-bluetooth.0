Return-Path: <cyrus@holtmann.org>
From: "Malovany, Ram" <ramm@ti.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: Device Scan and connection collision fix
Date: Tue, 17 Jul 2012 14:19:22 +0000
Message-ID: <2683478DEE33CD4DAF508ABCF391F6A40B4AEA5B@DNCE05.ent.ti.com>
References: <1342533126-23175-1-git-send-email-ramm@ti.com>
 <20120717141754.GB5330@aemeltch-MOBL1>
In-Reply-To: <20120717141754.GB5330@aemeltch-MOBL1>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> -----Original Message-----
> From: Andrei Emeltchenko [mailto:andrei.emeltchenko.news@gmail.com]
> Sent: Tuesday, July 17, 2012 5:18 PM
> To: Malovany, Ram
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH] Bluetooth: Device Scan and connection collision fix
> 
> Hi Ram,
> 
> On Tue, Jul 17, 2012 at 04:52:06PM +0300, ramm@ti.com wrote:
> > From: Ram Malovany <ramm@ti.com>
> >
> > During search of devices, HCI Remote Name Request Command is sent for
> > every device which name was not included in inquiry result. But the
> > same command is also sent during incoming connection establishing
> > procedure. Function hci_check_pending_name() was fixed in order to
> > handle this situation which led to a kernel crash when initiating
> > an incoming connection from a device that was not found in the
> > inquiry while doing a search. There is no need to continue resolving
> > the next name if we get the request from the incoming connection
> > procedure as it will be done upon receiving another remote name
> > request complete event
> >
> > Signed-off-by: Ram Malovany <ramm@ti.com>
> > ---
> >  net/bluetooth/hci_event.c |   16 ++++++++++++----
> >  1 files changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 41ff978..654b170 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -1365,7 +1365,7 @@ static bool hci_resolve_next_name(struct hci_dev
> *hdev)
> >  		return false;
> >
> >  	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY, NAME_NEEDED);
> > -	if (hci_resolve_name(hdev, e) == 0) {
> > +	if (e && hci_resolve_name(hdev, e) == 0) {
> 
> good catch
> 
> >  		e->name_state = NAME_PENDING;
> >  		return true;
> >  	}
> > @@ -1379,6 +1379,9 @@ static void hci_check_pending_name(struct hci_dev
> *hdev, struct hci_conn *conn,
> >  	struct discovery_state *discov = &hdev->discovery;
> >  	struct inquiry_entry *e;
> >
> > +	BT_DBG("name %p, name_len %d, discov->state %d",
> > +			name, name_len, discov->state);
> 
> wrong indentation
> 
> > +
> >  	if (conn && !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
> >  		mgmt_device_connected(hdev, bdaddr, ACL_LINK, 0x00, 0, name,
> >  				      name_len, conn->dev_class);
> > @@ -1394,11 +1397,16 @@ static void hci_check_pending_name(struct hci_dev
> *hdev, struct hci_conn *conn,
> >
> >  	e = hci_inquiry_cache_lookup_resolve(hdev, bdaddr, NAME_PENDING);
> >  	if (e) {
> > -		e->name_state = NAME_KNOWN;
> >  		list_del(&e->list);
> > -		if (name)
> > +		if (name) {
> > +			e->name_state = NAME_KNOWN;
> >  			mgmt_remote_name(hdev, bdaddr, ACL_LINK, 0x00,
> >  					 e->data.rssi, name, name_len);
> > +		} else {
> > +			e->name_state = NAME_NOT_KNOWN;
> > +		}
> > +	} else {
> > +	     return;
> >  	}
> >
> >  	if (hci_resolve_next_name(hdev))
> > @@ -1996,7 +2004,7 @@ static void hci_remote_name_evt(struct hci_dev *hdev,
> struct sk_buff *skb)
> >  	struct hci_ev_remote_name *ev = (void *) skb->data;
> >  	struct hci_conn *conn;
> >
> > -	BT_DBG("%s", hdev->name);
> > +	BT_DBG("%s, status %d", hdev->name, ev->status);
> 
> please use 0x%2.2x for status
> 
> Best regards
> Andrei Emeltchenko

Will fix it.

Thanks,
Ram

