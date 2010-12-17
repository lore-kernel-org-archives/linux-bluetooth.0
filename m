Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Pavan Savoy <pavan_savoy@sify.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	Linus WALLEIJ <linus.walleij@stericsson.com>,
	Par-Gunnar Hjalmdahl <pghatwork@gmail.com>
Date: Fri, 17 Dec 2010 13:29:11 +0100
Subject: RE: [PATCH 08/11] Bluetooth: Add support for CG2900 UART
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA33489D2B69@EXDCVYMBSTM005.EQ1STM.local>
References: <1292585117-28584-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
 <AANLkTimjDCF4V9wGszVcuDYqZ8Qq0CYhCzxnxEKcibxN@mail.gmail.com>
In-Reply-To: <AANLkTimjDCF4V9wGszVcuDYqZ8Qq0CYhCzxnxEKcibxN@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vitaly,

> -----Original Message-----
> From: Vitaly Wool [mailto:vitalywool@gmail.com]
> Sent: den 17 december 2010 13:03
> To: Par-Gunnar HJALMDAHL
> Cc: Pavan Savoy; Alan Cox; Arnd Bergmann; Samuel Ortiz; Marcel
> Holtmann; linux-kernel@vger.kernel.org; linux-
> bluetooth@vger.kernel.org; Lukasz Rymanowski; Linus WALLEIJ; Par-Gunnar
> Hjalmdahl
> Subject: Re: [PATCH 08/11] Bluetooth: Add support for CG2900 UART
>=20
> Hi Par,
>=20
> so on the top level: this is yet another H4 implementation plus
> channel-based packet routing, right?
>=20
> Could you please also elaborate
>=20

Yes, the low-level basis is similar to e.g. hci_h4.c, where we register to =
N_HCI line discipline and then use the first byte to separate between diffe=
rent channels.
While hci_h4.c supports only the standardized Bluetooth H4 channels, the cg=
2900_uart targets also the CG2900 specific H4 channels.

> More comments on the code are inlined.
>=20
> > +#define MAIN_DEV =A0 =A0 =A0 =A0 =A0 =A0 =A0 (uart_info->dev)
>=20
> What is that for?
>=20

This is just a simplification when using for example dev_err(). It's just t=
o shorten the text (not much in this case but there are other files where i=
t looks better).
No big problem to fix if you want that.

> > + * cg2900_uart_suspend() - Called by Linux PM to put the device in a
> low power mode.
> > + * @pdev: =A0 =A0 =A0Pointer to platform device.
> > + * @state: =A0 =A0 New state.
> > + *
> > + * In UART case, CG2900 driver does nothing on suspend.
> > + *
> > + * Returns:
> > + * =A0 0 - Success.
> > + */
> > +static int cg2900_uart_suspend(struct platform_device *pdev,
> pm_message_t state)
> > +{
> > + =A0 =A0 =A0 struct uart_info *uart_info =3D dev_get_drvdata(&pdev->de=
v);
> > +
> > + =A0 =A0 =A0 if (uart_info->sleep_state =3D=3D CHIP_POWERED_DOWN)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> > +
> > + =A0 =A0 =A0 if (uart_info->sleep_state !=3D CHIP_ASLEEP)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> > +
> > + =A0 =A0 =A0 dev_dbg(MAIN_DEV, "New sleep_state: CHIP_SUSPENDED\n");
> > + =A0 =A0 =A0 uart_info->sleep_state =3D CHIP_SUSPENDED;
> > + =A0 =A0 =A0 return 0;
> > +}
>=20
> I don't think this is safe wrt work queue. What if it gets scheduled
> when drivers are suspended?
>=20
> Thanks,
>    Vitaly

I'm not 100% sure what you mean since I don't think sleep_state should ever=
 be in CHIP_ASLEEP if we have a work ongoing or in the queue, but I will as=
k our low power expert to look into this.

/P-G
