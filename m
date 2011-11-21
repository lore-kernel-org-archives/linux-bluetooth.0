Return-Path: <cyrus@holtmann.org>
Message-ID: <1321880454.2011.8.camel@aeonflux>
Subject: Re: [RFC 3/3] Bluetooth: Add AMP initialization
From: Marcel Holtmann <marcel@holtmann.org>
To: 'Emeltchenko Andrei' <Andrei.Emeltchenko.news@gmail.com>
Cc: Peter Krystad <pkrystad@codeaurora.org>,
	linux-bluetooth@vger.kernel.org
Date: Mon, 21 Nov 2011 14:00:54 +0100
In-Reply-To: <20111121101331.GE32261@aemeltch-MOBL1>
References: <1321457422-31641-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1321457422-31641-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1321480186.15441.554.camel@aeonflux> <20111117132047.GH415@aemeltch-MOBL1>
	 <1321544714.15441.568.camel@aeonflux> <005d01cca555$280fa960$782efc20$@org>
	 <1321593256.15441.575.camel@aeonflux>
	 <20111118135412.GC24392@aemeltch-MOBL1>
	 <1321633382.15441.618.camel@aeonflux>
	 <20111121101331.GE32261@aemeltch-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > > > However since we are talking about controller init. Can someone please
> > > > first propose a list of how we init AMP vs BR/EDR/LE controllers instead
> > > > of just dumping code here. I think it needs some clear strategy on how
> > > > to do it.
> > > 
> > > AMP controller is initialized following way in Code Aurora code:
> > > 
> > > Common part:
> > > 
> > > <------8<--------------------------------------------------
> > > |  /* Mandatory initialization */
> > > |
> > > |  /* Reset */
> > > |  if (!test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
> > > |          set_bit(HCI_RESET, &hdev->flags);
> > > |          hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
> > > |  }
> > 
> > this check for QUIRK_NO_RESET is pointless. That is just there for old
> > Bluetooth 1.0b controllers. Or broken hardware. Let's assume the AMP
> > controllers are fine and just issue OP_RESET.
> > 
> > > |  /* Read Local Version */
> > > |  hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
> > > |
> > > |  /* Read HCI Flow Control Mode */
> > > |  hci_send_cmd(hdev, HCI_OP_READ_FLOW_CONTROL_MODE, 0, NULL);
> > > |
> > > |  /* Read Buffer Size (ACL mtu, max pkt, etc.) */
> > > |  hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
> > > |
> > > |  /* Read Data Block Size (ACL mtu, max pkt, etc.) */
> > > |  hci_send_cmd(hdev, HCI_OP_READ_DATA_BLOCK_SIZE, 0, NULL);
> > > <------8<------------------------------------------------------
> > 
> > This is not a generic sequence. We will not be reading flow control or
> > data block size commands. It will heavily fail on older controllers.
> 
> What about following code (basically BR/EDR initialization is the same as
> now and only amp_init is new). I use now virtual AMP device so any init is
> good, I need Read Version and Read AMP info commands.
> 
> static void bredr_init(struct hci_dev *hdev)
> {
> 	struct hci_cp_delete_stored_link_key cp;
> 	__le16 param;
> 	__u8 flt_type;
> 
> 	/* Mandatory initialization */
> 	/* Reset */
> 	if (!test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
> 		set_bit(HCI_RESET, &hdev->flags);
> 		hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
> 	}
> 
> 	/* Read Local Supported Features */
> 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
> 
> 	/* Read Local Version */
> 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
> 
> 	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
> 	hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
> 
> 	/* Read BD Address */
> 	hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);
> 
> 	/* Read Class of Device */
> 	hci_send_cmd(hdev, HCI_OP_READ_CLASS_OF_DEV, 0, NULL);
> 
> 	/* Read Local Name */
> 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_NAME, 0, NULL);
> 
> 	/* Read Voice Setting */
> 	hci_send_cmd(hdev, HCI_OP_READ_VOICE_SETTING, 0, NULL);
> 
> 	/* Optional initialization */
> 	/* Clear Event Filters */
> 	flt_type = HCI_FLT_CLEAR_ALL;
> 	hci_send_cmd(hdev, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
> 
> 	/* Connection accept timeout ~20 secs */
> 	param = cpu_to_le16(0x7d00);
> 	hci_send_cmd(hdev, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
> 
> 	bacpy(&cp.bdaddr, BDADDR_ANY);
> 	cp.delete_all = 1;
> 	hci_send_cmd(hdev, HCI_OP_DELETE_STORED_LINK_KEY, sizeof(cp), &cp);
> }
> 
> static void amp_init(struct hci_dev *hdev)
> {
> 	/* Mandatory initialization */
> 	/* Reset */
> 	hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
> 
> 	/* Read Local Version */
> 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
> 
> 	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
> 	hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
> 
> 	/* Read AMP Info */
> 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
> }

actually I think the READ_AMP_INFO is wrong here. It should be only
executed based on an AMP_Get_Info_Request during a connection setup
procedure.

And even the READ_BUFFER_SIZE is the wrong command since by default the
AMP controller is in block based flow control mode. So you would need to
read the flow control mode first actually.

Regards

Marcel


