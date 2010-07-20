Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Defer SCO setup if mode change is pending
From: Marcel Holtmann <marcel@holtmann.org>
To: Ron Shaffer <rshaffer@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4C45299D.9060504@codeaurora.org>
References: <1279562776-12901-1-git-send-email-marcel@holtmann.org>
	 <4C45299D.9060504@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Jul 2010 09:56:01 -0700
Message-ID: <1279644961.4572.60.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ron,

> > @@ -385,10 +406,13 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
> >  		acl->power_save = 1;
> >  		hci_conn_enter_active_mode(acl);
> >  
> > -		if (lmp_esco_capable(hdev))
> > -			hci_setup_sync(sco, acl->handle);
> > -		else
> > -			hci_add_sco(sco, acl->handle);
> > +		if (test_bit(HCI_CONN_MODE_CHANGE_PEND, &acl->pend)) {
> > +			/* defer SCO setup until mode change completed */
> > +			set_bit(HCI_CONN_SCO_SETUP_PEND, &acl->pend);
> > +			return sco;
> > +		}
> > +
> > +		hci_sco_setup(acl, 0x00);
> >  	}
> 
> Not in love with the "fake" status passed here, but the overall change
> to centralize this functionality provides a nice cleanup from the
> original patch and makes the code more readable and maintainable.

yeah, the 0x00 looks funny here. We could add a comment explaining it,
but it does make sense in the end.

> >  	return sco;
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 2069c3b..461413c 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -775,9 +775,6 @@ static void hci_cs_sniff_mode(struct hci_dev *hdev, __u8 status)
> >  
> >  	BT_DBG("%s status 0x%x", hdev->name, status);
> >  
> > -	if (!status)
> > -		return;
> > -
> >  	cp = hci_sent_cmd_data(hdev, HCI_OP_SNIFF_MODE);
> >  	if (!cp)
> >  		return;
> > @@ -785,8 +782,13 @@ static void hci_cs_sniff_mode(struct hci_dev *hdev, __u8 status)
> >  	hci_dev_lock(hdev);
> >  
> >  	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
> > -	if (conn)
> > -		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
> > +	if (conn) {
> > +		if (status)
> > +			clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
> > +
> > +		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->pend))
> > +			hci_sco_setup(conn, status);
> 
> Probably the subject for another patch, but has there been any reported
> issue where idle_timeout is set short enough that the timer expires
> after exit sniff mode has been requested but before the mode change
> event has been received?

I see that this could potentially happen. The timer is not suppose to be
running during that transaction. It should be only started when the mode
change has been completed. That needs fixing, but not in this patch.

Regards

Marcel


