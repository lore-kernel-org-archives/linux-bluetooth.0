Return-Path: <cyrus@holtmann.org>
Message-ID: <1391436370.1075.3.camel@bali>
Subject: Re: [RFC v6 03/14] Bluetooth: Introduce connection parameters list
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Mon, 03 Feb 2014 11:06:10 -0300
In-Reply-To: <94043278-430F-4EAE-A4F1-36AB1FB614A6@holtmann.org>
References: <1391116937-28217-1-git-send-email-andre.guedes@openbossa.org>
	 <1391116937-28217-4-git-send-email-andre.guedes@openbossa.org>
	 <94043278-430F-4EAE-A4F1-36AB1FB614A6@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Marcel,

On Fri, 2014-01-31 at 17:11 -0800, Marcel Holtmann wrote:
> Hi Andre,
> 
> > This patch adds to hdev the connection parameters list (hdev->le_
> > conn_params). The elements from this list (struct hci_conn_params)
> > contains the connection parameters (for now, minimum and maximum
> > connection interval) that should be used during the connection
> > establishment.
> > 
> > The struct hci_conn_params also defines the 'auto_connect' field
> > which will be used to implement the auto connection mechanism.
> > 
> > Moreover, this patch adds helper functions to manipulate hdev->le_
> > conn_params list. Some of these functions are also declared in
> > hci_core.h since they will be used outside hci_core.c in upcoming
> > patches.
> > 
> > Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> > ---
> > include/net/bluetooth/hci_core.h | 25 +++++++++++++
> > net/bluetooth/hci_core.c         | 80 ++++++++++++++++++++++++++++++++++++++++
> > 2 files changed, 105 insertions(+)
> > 
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index 197413b..f757b3f 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -269,6 +269,7 @@ struct hci_dev {
> > 	struct list_head	link_keys;
> > 	struct list_head	long_term_keys;
> > 	struct list_head	remote_oob_data;
> > +	struct list_head	le_conn_params;
> > 
> > 	struct hci_dev_stats	stat;
> > 
> > @@ -373,6 +374,22 @@ struct hci_chan {
> > 	__u8		state;
> > };
> > 
> > +struct hci_conn_params {
> > +	struct list_head list;
> > +
> > +	bdaddr_t addr;
> > +	u8 addr_type;
> > +
> > +	enum {
> > +		HCI_AUTO_CONN_DISABLED,
> > +		HCI_AUTO_CONN_ALWAYS,
> > +		HCI_AUTO_CONN_LINK_LOSS,
> > +	} auto_connect;
> 
> actually I would not include the auto_connect mode in the this stage of the patch set. We could have made more progress with this patch set and get things applied if things are not intermixed. So lets leave this out and only introduce it once we need it.

All right, I'll introduce this auto_connect mode in patch 13/14. It
clearly makes more sense.

Thanks,

Andre
