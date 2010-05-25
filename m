Return-Path: <cyrus@holtmann.org>
Message-ID: <4BFC0228.8050206@codeaurora.org>
Date: Tue, 25 May 2010 12:00:24 -0500
From: Ron Shaffer <rshaffer@codeaurora.org>
MIME-Version: 1.0
To: "Gustavo F. Padovan" <gustavo@padovan.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth: Synchronize SCO/eSCO connection requests
 to ACL state
References: <4BFAEB65.2060503@codeaurora.org> <20100524215202.GA28028@vigoh>
In-Reply-To: <20100524215202.GA28028@vigoh>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

trimmed.

> Hi Ron,
> 
> * Ron Shaffer <rshaffer@codeaurora.org> [2010-05-24 16:11:01 -0500]:
> 
>>
>> Certain headsets such as the Motorola H350 will reject SCO and eSCO
>> connection requests while the ACL is transitioning from sniff mode
>> to active mode. Add synchronization so that SCO and eSCO connection
>> requests will wait until the ACL has fully transitioned to active mode.
>>
>> Signed-off-by: Ron Shaffer <rshaffer@codeaurora.org>

> @@ -117,9 +117,18 @@ void hci_add_sco(struct hci_conn *conn, __u16 handle)
> >  {
> >  	struct hci_dev *hdev = conn->hdev;
> >  	struct hci_cp_add_sco cp;
> > +	struct hci_conn *acl = conn->link;
> >  
> >  	BT_DBG("%p", conn);
> >  
> > +	if (acl->mode == HCI_CM_SNIFF &&
> > +		test_bit(HCI_CONN_MODE_CHANGE_PEND, &acl->pend)) {
> Wrong indentation here. Add a extra tab for test_bit.

> > +		set_bit(HCI_CONN_SCO_PEND, &conn->pend);
> > +		return;
> > +	}
> > +
> > +	clear_bit(HCI_CONN_SCO_PEND, &conn->pend);

> 
> 
> You already clear the bit on hci_mode_change_evt with
> test_and_clear_bit. No need to clear it again here.
> The same happens for hci_setup_sync().
> 

Clearing the bit and clearing it in hci_change_mode_evt are independent
actions for two different scenarios.

Scenario 1:
A SCO/eSCO connection is requested and the ACL is in active mode. 

Scenario 2:
A SCO/eSCO connection is requested and the ACL is transitioning modes.

For scenario 1, I cleared the bit here because I did not want to assume
the bit had been initialized. If it's set, then any future changes to 
the ACL mode (sniff, active) requested by the local side would result
in a request for a SCO or eSCO connection when one already exists.

For scenario 2, the first conditional is TRUE, and the bit gets set.
Later when the mode change event is received, the bit is cleared and
the SCO/eSCO connection is requested.

-- 
Ron Shaffer
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
