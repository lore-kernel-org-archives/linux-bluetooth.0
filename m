Return-Path: <cyrus@holtmann.org>
From: Hirenkumar Tandel <hirent@marvell.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann
	<marcel@holtmann.org>
CC: Bing Zhao <bzhao@marvell.com>,
        "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>,
        "Gustavo F. Padovan"
	<gustavo@padovan.org>,
        Rahul Tank <rahult@marvell.com>, Quinton Yuan
	<qyuan@marvell.com>
Date: Tue, 1 Apr 2014 00:26:00 -0700
Subject: RE: [PATCH] Bluetooth: Fix to auto accept pairing request for no
 MITM case
Message-ID: <CBACCFA0AEB13A41977475BCF3E896FC3E9D2AE463@SC-VEXCH2.marvell.com>
References: <1391626900-11168-1-git-send-email-bzhao@marvell.com>
 <20140329072359.GA31453@t440s.P-661HNU-F1>
 <CBACCFA0AEB13A41977475BCF3E896FC3E9D2AE11D@SC-VEXCH2.marvell.com>
 <20140331060954.GA21227@t440s.P-661HNU-F1>
 <AFB16602-E5BA-41D2-A94A-B83501BE014C@holtmann.org>
 <20140331094934.GA9902@t440s.lan>
In-Reply-To: <20140331094934.GA9902@t440s.lan>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

-----Original Message-----
From: Johan Hedberg [mailto:johan.hedberg@gmail.com]=20
Sent: Monday, March 31, 2014 3:20 PM
To: Marcel Holtmann
Cc: Hirenkumar Tandel; Bing Zhao; linux-bluetooth@vger.kernel.org; Gustavo =
F. Padovan; Rahul Tank; Quinton Yuan
Subject: Re: [PATCH] Bluetooth: Fix to auto accept pairing request for no M=
ITM case

Hi Marcel,

On Mon, Mar 31, 2014, Marcel Holtmann wrote:
> >>>> --- a/net/bluetooth/hci_event.c
> >>>> +++ b/net/bluetooth/hci_event.c
> >>>> @@ -3239,8 +3239,13 @@ static void=20
> >>>> hci_user_confirm_request_evt(struct
> >>>> hci_dev *hdev,
> >>>>=20
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
> >>>> +		    conn->io_capability !=3D HCI_IO_NO_INPUT_OUTPUT) {
> >>>> 			BT_DBG("Confirming auto-accept as acceptor");
> >>>> 			confirm_hint =3D 1;
> >>>> 			goto confirm;
> >>>=20
> >>> So basically this changes the policy from rejecting pairings when=20
> >>> an agent is not registered to accepting them in case it's a=20
> >>> just-works pairing? I'm not convinced we want to do such a policy=20
> >>> change that relaxes security in this regard.
> >>>=20
> >>> Do you have an actual product use case for this? What's the=20
> >>> background and reasoning behind it?
> >>=20
> >> A use case is for chrome book, for user not logged in case,=20
> >> Bluetooth is working at this time, but default-agent is not=20
> >> registered, however user will expect  Bluetooth to work for certain=20
> >> simple devices like mouse.
> >=20
> > I still don't completely understand this. If the user has paired the=20
> > mouse previously (which must be the case since otherwise the mouse=20
> > would not be connecting to the PC) then there will not be any user=20
> > confirm request during the connection creation.
>=20
> actually bluetoothd must be running to accept an incoming connection=20
> from a HID device. The initial connection handling is done in=20
> bluetoothd. Also without bluetoothd running, you do not have page scan=20
> enabled either. The kernel starts out with page scan disabled.

Sure, but if I understand the situation here bluetoothd *is* already runnin=
g at the login prompt stage but there is no agent registered. In such a cas=
e I think it should be fine to accept connections from already paired and t=
rusted devices but we should probably keep rejecting them from any other de=
vice (even if the pairing would trigger just-works).

We are ok to drop this patch if, without agent registered, it is not comfor=
table to allow incoming pairing which even ask for just work model.

Johan

Thanks,
Hiren
