Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 17 Nov 2010 14:52:48 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Pavan Savoy <pavan_savoy@sify.com>
Cc: Vitaly Wool <vitalywool@gmail.com>, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Bluetooth: btwilink driver
Message-ID: <20101117165248.GB21729@vigoh>
References: <1289394446-14021-1-git-send-email-pavan_savoy@ti.com>
 <20101116225418.GA15101@vigoh>
 <AANLkTi=TxKKxjLdK-6Jwu9oBCiGHXJ8UxrAQH+C82wNK@mail.gmail.com>
 <AANLkTi=NH8gbW8iCKOQN0bmbL=nqewsZkUik+VkvWUgi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTi=NH8gbW8iCKOQN0bmbL=nqewsZkUik+VkvWUgi@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

* Pavan Savoy <pavan_savoy@sify.com> [2010-11-17 11:13:26 +0530]:

> On Wed, Nov 17, 2010 at 4:50 AM, Vitaly Wool <vitalywool@gmail.com> wrote:
> >>> + =A0 =A0 /* Registration with ST layer is successful,
> >>> + =A0 =A0 =A0* hardware is ready to accept commands from HCI core.
> >>> + =A0 =A0 =A0*/
> >>> + =A0 =A0 if (test_and_set_bit(HCI_RUNNING, &hdev->flags)) {
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 clear_bit(HCI_RUNNING, &hdev->flags);
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D st_unregister(ST_BT);
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("st_unregister() fai=
led with error %d", err);
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 hst->st_write =3D NULL;
> >>> + =A0 =A0 }
> >>
> >>
> >> What are you trying to do here? test_and_set_bit() result doesn't say
> >> nothing about error and you shall put test_and_set_bit should be in the
> >> beginning, to know if your device is already opened or not and then
> >> clear_bit if some error ocurrs during the function.
> >>
> >
> > Yeap, this piece of code beats me is well. Why is it an error if this
> > bit wasn't already set?
>=20
> Vitaly, Gustavo,
>=20
> I suppose I never understood HCI_RUNNING flag that way, as in an error
> check mechanism to avoid multiple hci0 ups.
>=20
> What I understood was that HCI_RUNNING suggested as to when hci0 was
> ready to be used. With this understanding, I wanted to make sure I
> downloaded the firmware for the chip before I proclaim to the world
> that the hci0 is ready to be used, as in HCI_RUNNING.
>=20
> For example, I didn't want my _send_frame to be called before I did
> the firmware download - since firmware download takes time - 45kb
> send/wait commands :(
>=20
> But I suppose I now understand - What I would rather do is test_bit in
> the beginning of function and do a set_bit at the end of function -
> does this make sense ?

It does, but does it as test_and_set and then clear if error as we do in
other drivers.

--=20
Gustavo F. Padovan
http://profusion.mobi
