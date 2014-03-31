Return-Path: <cyrus@holtmann.org>
Date: Mon, 31 Mar 2014 12:49:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Hirenkumar Tandel <hirent@marvell.com>, Bing Zhao <bzhao@marvell.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Rahul Tank <rahult@marvell.com>, Quinton Yuan <qyuan@marvell.com>
Subject: Re: [PATCH] Bluetooth: Fix to auto accept pairing request for no
 MITM case
Message-ID: <20140331094934.GA9902@t440s.lan>
References: <1391626900-11168-1-git-send-email-bzhao@marvell.com>
 <20140329072359.GA31453@t440s.P-661HNU-F1>
 <CBACCFA0AEB13A41977475BCF3E896FC3E9D2AE11D@SC-VEXCH2.marvell.com>
 <20140331060954.GA21227@t440s.P-661HNU-F1>
 <AFB16602-E5BA-41D2-A94A-B83501BE014C@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AFB16602-E5BA-41D2-A94A-B83501BE014C@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Mar 31, 2014, Marcel Holtmann wrote:
> >>>> --- a/net/bluetooth/hci_event.c
> >>>> +++ b/net/bluetooth/hci_event.c
> >>>> @@ -3239,8 +3239,13 @@ static void hci_user_confirm_request_evt(struct 
> >>>> hci_dev *hdev,
> >>>> 
> >>>> 		/* If we're not the initiators request authorization to
> >>>> 		 * proceed from user space (mgmt_user_confirm with
> >>>> -		 * confirm_hint set to 1). */
> >>>> -		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags)) {
> >>>> +		 * confirm_hint set to 1).
> >>>> +		 * But if local host has NoInputNoOutput capability,
> >>>> +		 * then no use of passing request to user space,
> >>>> +		 * so go ahead with auto accept.
> >>>> +		 */
> >>>> +		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) &&
> >>>> +		    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT) {
> >>>> 			BT_DBG("Confirming auto-accept as acceptor");
> >>>> 			confirm_hint = 1;
> >>>> 			goto confirm;
> >>> 
> >>> So basically this changes the policy from rejecting pairings when an
> >>> agent is not registered to accepting them in case it's a just-works
> >>> pairing? I'm not convinced we want to do such a policy change that
> >>> relaxes security in this regard.
> >>> 
> >>> Do you have an actual product use case for this? What's the background
> >>> and reasoning behind it?
> >> 
> >> A use case is for chrome book, for user not logged in case, Bluetooth
> >> is working at this time, but default-agent is not registered, however
> >> user will expect  Bluetooth to work for certain simple devices like
> >> mouse.
> > 
> > I still don't completely understand this. If the user has paired the
> > mouse previously (which must be the case since otherwise the mouse would
> > not be connecting to the PC) then there will not be any user confirm
> > request during the connection creation.
> 
> actually bluetoothd must be running to accept an incoming connection
> from a HID device. The initial connection handling is done in
> bluetoothd. Also without bluetoothd running, you do not have page scan
> enabled either. The kernel starts out with page scan disabled.

Sure, but if I understand the situation here bluetoothd *is* already
running at the login prompt stage but there is no agent registered. In
such a case I think it should be fine to accept connections from already
paired and trusted devices but we should probably keep rejecting them
from any other device (even if the pairing would trigger just-works).

Johan
