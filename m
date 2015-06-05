Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Marcel Holtmann' <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, bharat.panda@samsung.com
References: <1433413568-26382-1-git-send-email-gowtham.ab@samsung.com>
 <1433413568-26382-2-git-send-email-gowtham.ab@samsung.com>
 <399E856C-28E8-4A5A-98AB-BFB037680906@holtmann.org>
In-reply-to: <399E856C-28E8-4A5A-98AB-BFB037680906@holtmann.org>
Subject: RE: [PATCH  2/2] emulator/le: Add LE test commands
Date: Fri, 05 Jun 2015 17:45:18 +0530
Message-id: <000601d09f89$58a9e6d0$09fdb470$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Marcel Holtmann
> Sent: Thursday, June 04, 2015 4:29 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org; bharat.panda@samsung.com
> Subject: Re: [PATCH 2/2] emulator/le: Add LE test commands
> 
> Hi Gowtham,
> 
> > ---
> > emulator/le.c | 45 ++++++++++++++++++++++++++++++++++++++++++--
> -
> > 1 file changed, 42 insertions(+), 3 deletions(-)
> >
> > diff --git a/emulator/le.c b/emulator/le.c index dc51469..7f852a9
> > 100644
> > --- a/emulator/le.c
> > +++ b/emulator/le.c
> > @@ -258,9 +258,9 @@ static void reset_defaults(struct bt_le *hci)
> > 	//hci->commands[28] |= 0x02;	/* LE Long Term Key Request Reply
> */
> > 	//hci->commands[28] |= 0x04;	/* LE Long Term Key Request
> Negative Reply */
> > 	hci->commands[28] |= 0x08;	/* LE Read Supported States */
> > -	//hci->commands[28] |= 0x10;	/* LE Receiver Test */
> > -	//hci->commands[28] |= 0x20;	/* LE Transmitter Test */
> > -	//hci->commands[28] |= 0x40;	/* LE Test End */
> > +	hci->commands[28] |= 0x10;	/* LE Receiver Test */
> > +	hci->commands[28] |= 0x20;	/* LE Transmitter Test */
> > +	hci->commands[28] |= 0x40;	/* LE Test End */
> > 	//hci->commands[33] |= 0x10;	/* LE Remote Connection Parameter
> Request Reply */
> > 	//hci->commands[33] |= 0x20;	/* LE Remote Connection Parameter
> Request Negative Reply */
> > 	hci->commands[33] |= 0x40;	/* LE Set Data Length */
> > @@ -1218,6 +1218,36 @@ static void
> cmd_le_read_supported_states(struct bt_le *hci,
> > 							&rsp, sizeof(rsp));
> > }
> >
> > +static void cmd_le_receiver_test(struct bt_le *hci,
> > +						const void *data, uint8_t
size)
> {
> > +	uint8_t status;
> > +
> > +	status = BT_HCI_ERR_SUCCESS;
> > +	cmd_complete(hci, BT_HCI_CMD_LE_RECEIVER_TEST,
> > +					&status, sizeof(status));
> > +}
> > +
> > +static void cmd_le_transmitter_test(struct bt_le *hci,
> > +						const void *data, uint8_t
size)
> {
> > +	uint8_t status;
> > +
> > +	status = BT_HCI_ERR_SUCCESS;
> > +	cmd_complete(hci, BT_HCI_CMD_LE_TRANSMITTER_TEST,
> > +					&status, sizeof(status));
> > +}
> > +
> > +static void cmd_le_end_test(struct bt_le *hci, const void *data,
> > +uint8_t size) {
> > +	struct bt_hci_rsp_le_test_end lte;
> > +
> > +	lte.status = BT_HCI_ERR_SUCCESS;
> > +	lte.num_packets = 0;
> > +
> > +	cmd_complete(hci, BT_HCI_CMD_LE_TEST_END, &lte, sizeof(lte)); }
> > +
> 
> this is actually not enough. You need to put a bit of logic into this
code. For
> example it is either RX or TX test and not both at the same time. You need
to
> return proper errors. And the test end command you also return the correct
> value for num_packets. So if you do a receiver test against a transmitter
test
> you are getting some useful values here. Otherwise there are just empty
> stubs and we better not bother having them at all.
> 

Thanks for the quick review.
Below are the assumptions that I want to clarify:
1) Need to check  rx_chan and tx_chan are in 0x00 to 0x27 range, if not
return BT_HCI_ERR_INVALID_PARAMETERS.

2) Need to maintain a global variable (rx_test, tx_test) to track which test
is going on. 

3) When receiver test is called, a global variable (pkt_recv ) is
incremented to track  num of packets received.

Or Should I maintain a structure for (2) & (3) instead of maintaining
globals?

4) Finally while test end cmd,
	If (tx_test)
		num_packets = 0;
	else if (rx_test) {
		num_packets = pkt_recv;
		pkt_recv = 0;
	}


Is there any tool to test the above commands?
If not I can add these commands to any of the tools (hcitool, I guess) for
testing (If it is worth to add in BlueZ, then I will send them as patches
too).

> The standalone LE emulation in btvirt is trying really hard to have proper
and
> correct error handling for LE only single mode controller.
> 
> Regards
> 
> Marcel
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

Best Regards,
Gowtham Anandha Babu


