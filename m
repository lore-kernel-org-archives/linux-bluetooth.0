Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Feb 2013 16:31:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 07/14] Bluetooth: Add transaction cmd_complete and
 cmd_status functions
Message-ID: <20130222143115.GA2718@x220>
References: <1361538759-13558-1-git-send-email-johan.hedberg@gmail.com>
 <1361538759-13558-8-git-send-email-johan.hedberg@gmail.com>
 <20130222141740.GA6830@echo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130222141740.GA6830@echo>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Feb 22, 2013, Vinicius Costa Gomes wrote:
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -53,6 +53,7 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
> >  	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> >  	hci_dev_unlock(hdev);
> >  
> > +	hci_transaction_cmd_complete(hdev, HCI_OP_INQUIRY, status);
> >  	hci_req_complete(hdev, HCI_OP_INQUIRY_CANCEL, status);
> >  
> >  	hci_conn_check_pending(hdev);
> > @@ -1692,6 +1693,7 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> >  
> >  	BT_DBG("%s status 0x%2.2x", hdev->name, status);
> >  
> > +	hci_transaction_cmd_complete(hdev, HCI_OP_INQUIRY, status);
> 
> There are quite a few other commands that do not cause a Command Complete
> event, for example, LE Start Encryption, causes either a Encrypt Change or a
> Key Refresh; LE Create Connection, causes a Connection Complete.
> 
> So if I want to add support for these commands to be part of a transaction I
> would need to add the appropriate handler to the associated "complete" events,
> right?  I feel that I already know the answer ;-) This question is more about
> others developers losing time thinking: "Why transactions doesn't work for
> these particular commands?".

Right. Any multi-command transactions, or transactions with a complete
callback that contain HCI commands that do not result in command
complete will need to have these extra calls to
hci_transaction_cmd_complete added. Probably some comment might be worth
adding to the code about this.

Johan
