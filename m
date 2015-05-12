Return-Path: <cyrus@holtmann.org>
From: Ankur Patel <ankur@embertec.com>
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 12 May 2015 10:03:19 +0930
Subject: RE: LE only Mode:  PICS reference 
Message-ID: <BD5E516FF3711A41B93DC005170007BB010D943FD8B1@EMBSVR01.ember.local>
References: <BD5E516FF3711A41B93DC005170007BB010D943FD6AC@EMBSVR01.ember.local>
 <F726DD6C-2E39-44C1-B168-CE2723CF9069@holtmann.org>
In-Reply-To: <F726DD6C-2E39-44C1-B168-CE2723CF9069@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Ankur,
>=20
> > I am new to the BT LE and pls bare with me if I ask some silly question=
s.
> Thank you for support.
> >
> > I am now using 3.18.12 Linux kernel and Bluez 5.30 version on board. Ou=
r
> product requirement is to support only LE modes. To create PICS for host
> system using bluez, do I have to take
> http://git.kernel.org/cgit/bluetooth/bluez.git/tree/android/pics-gap.txt =
as a
> reference for selecting the configuration?
> > If yes, then in that case, why it has  Broadcaster and Observer selecte=
d to
> 'False' under line#150-151 in pics-gap.txt as bluez does supports
> Central/Broadcaster/Observer LE roles as mentioned under bluez-
> 5.30/doc/supported-features.txt?
>=20
> the main focus is central and peripheral role when it comes to Android. T=
he
> broadcaster and observer roles are connectionless and not much in use.
>=20
> You can select them in the PICS and qualify BlueZ as broadcaster and
> observer only, but then a lot of the settings need to be chosen correctly=
. In
> addition bluetoothd will not be of much help since that is build for cent=
ral and
> peripheral roles.
>=20
> > Inaddition, I am having some issue running the testcase
> TC_IDLE_NAMP_BV_02_C. pts-gts.txt says: "btmgmt advertising on" should
> work, but it is not working on my side.
> >
> > Following Log info:
> > Test case : TC_IDLE_NAMP_BV_02_C started
> >                - MTC: Successfully received
> HCI_LE_CLEAR_WHITE_LIST_COMPLETE_EVENT.
> >                - MTC: Successfully received
> HCI_LE_ADD_DEVICE_TO_WHITE_LIST_COMPLETE_EVENT.
> >                - MTC: Successfully received
> HCI_LE_SET_SCAN_PARAMETERS_COMPLETE_EVENT.
> >                - MTC: Successfully received
> HCI_LE_SET_SCAN_ENABLE_COMPLETE_EVENT.
> >                - MTC: Receive Advertising report successfully.
> >                - MTC: Successfully received
> HCI_LE_SET_SCAN_ENABLE_COMPLETE_EVENT.
> >                - MTC: ATT connection established successfully.
> >                - MTC-INCONC: Error returned in ATT_READ_BY_TYPE_CFM.
> >                - CM_EXIT
> >                - CM_EXIT
> >                - CM_EXIT
> >                - CM_EXIT
> >                - MTC: Test case ended
> >                -Final Verdict: INCONC
> > TC_IDLE_NAMP_BV_02_C finished
> >
> > -	Prior to running above command I have also set name using
> command 'btmgmt name test_dev'. Do I need to run more commands to it?
>=20
> The name also needs to be available via a GAP characteristic. Normally
> running bluetoothd will do that for you. But if you do that manually, the=
n
> need to register the GAP services.
>=20
> Regards
>=20
> Marcel

@Marcel @Luiz: Appreciate your help. Let me do some homework. I am looking =
forward to create similar documentation as available for android.=20

Regards,
Ankur
