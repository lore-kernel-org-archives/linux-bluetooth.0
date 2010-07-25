Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2] Bluetooth: Defer SCO setup if mode change is pending
From: Marcel Holtmann <marcel@holtmann.org>
To: Ron Shaffer <rshaffer@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4C49B7B5.9040802@codeaurora.org>
References: <1279644961.4572.60.camel@localhost.localdomain>
	 <1279827933-4180-1-git-send-email-rshaffer@codeaurora.org>
	 <1279853339.2621.14.camel@localhost.localdomain>
	 <4C49B7B5.9040802@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 25 Jul 2010 11:41:56 -0700
Message-ID: <1280083316.2621.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ron,

> >> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >> index 6c57fc7..9aee8c5 100644
> >> --- a/net/bluetooth/hci_event.c
> >> +++ b/net/bluetooth/hci_event.c
> >> @@ -775,9 +775,6 @@ static void hci_cs_sniff_mode(struct hci_dev *hdev, __u8 status)
> >>  
> >>  	BT_DBG("%s status 0x%x", hdev->name, status);
> >>  
> >> -	if (!status)
> >> -		return;
> >> -
> >>  	cp = hci_sent_cmd_data(hdev, HCI_OP_SNIFF_MODE);
> >>  	if (!cp)
> >>  		return;
> >> @@ -785,8 +782,15 @@ static void hci_cs_sniff_mode(struct hci_dev *hdev, __u8 status)
> >>  	hci_dev_lock(hdev);
> >>  
> >>  	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
> >> -	if (conn)
> >> -		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
> >> +	if (conn) {
> >> +		if (status) {
> >> +			clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
> >> +
> >> +			if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND,
> >> +					&conn->pend))
> >> +				hci_sco_setup(conn, status);
> >> +		}
> >> +	}
> >>  
> >>  	hci_dev_unlock(hdev);
> >>  }
> > 
> > this change now makes it worse, please revert to initial
> > 
> > 	if (!status)
> > 		return;
> > 
> > check at the top and the just do
> > 
> > 	if (conn) {
> > 		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
> > 
> > 		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->pend))
> > 			hci_sco_setup(conn, status);
> > 	}
> > 
> > The only reason why I moved the status check down, because I was not
> > thinking straight and overlooked that in case of success we don't wanna
> > do a single thing here.
> 
> Makes sense. Done.
> 
> > 
> >> @@ -798,9 +802,6 @@ static void hci_cs_exit_sniff_mode(struct hci_dev *hdev, __u8 status)
> >>  
> >>  	BT_DBG("%s status 0x%x", hdev->name, status);
> >>  
> >> -	if (!status)
> >> -		return;
> >> -
> >>  	cp = hci_sent_cmd_data(hdev, HCI_OP_EXIT_SNIFF_MODE);
> >>  	if (!cp)
> >>  		return;
> >> @@ -808,8 +809,15 @@ static void hci_cs_exit_sniff_mode(struct hci_dev *hdev, __u8 status)
> >>  	hci_dev_lock(hdev);
> >>  
> >>  	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
> >> -	if (conn)
> >> -		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
> >> +	if (conn) {
> >> +		if (status) {
> >> +			clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
> >> +
> >> +			if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND,
> >> +					&conn->pend))
> >> +				hci_sco_setup(conn, status);
> >> +		}
> >> +	}
> >>  
> >>  	hci_dev_unlock(hdev);
> >>  }
> > 
> > Same applies here btw.
> 
> Same. Done.
> 
> > 
> >> @@ -915,20 +923,8 @@ static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *s
> >>  	} else
> >>  		conn->state = BT_CLOSED;
> >>  
> >> -	if (conn->type == ACL_LINK) {
> >> -		struct hci_conn *sco = conn->link;
> >> -		if (sco) {
> >> -			if (!ev->status) {
> >> -				if (lmp_esco_capable(hdev))
> >> -					hci_setup_sync(sco, conn->handle);
> >> -				else
> >> -					hci_add_sco(sco, conn->handle);
> >> -			} else {
> >> -				hci_proto_connect_cfm(sco, ev->status);
> >> -				hci_conn_del(sco);
> >> -			}
> >> -		}
> >> -	}
> >> +	if (conn->type == ACL_LINK)
> >> +		hci_sco_setup(conn, ev->status);
> >>  
> >>  	if (ev->status) {
> >>  		hci_proto_connect_cfm(conn, ev->status);
> >> @@ -1478,6 +1474,9 @@ static inline void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb
> >>  				conn->power_save = 1;
> >>  			else
> >>  				conn->power_save = 0;
> >> +		} else if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND,
> >> +				&conn->pend)) {
> >> +			hci_sco_setup(conn, ev->status);
> >>  		}
> >>  	}
> > 
> > Please don't do else if here. Just add a separate check like I had in my
> > initial patch. We don't wanna depend on two flags pending flags set
> > here. If the SCO setup is pending, then we execute it. No matter how we
> > reached that point. It is important that even if we receive a mode
> > change without us triggering it, that we clear any potential SCO pending
> > flag.
> 
> Hmmm. I know I found a bug here, but I can't remember how it manifested
> itself. Today, I can't reproduce it, so either I was seeing things or
> I'm losing it.
> 
> I'll revert it back, and if I run across the issue again, we can fix it
> later.

please send v3 of this patch then.

Regards

Marcel


