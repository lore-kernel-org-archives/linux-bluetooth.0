Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Thu, 8 May 2003 14:55:10 -0700
Message-ID: <001101c315ac$7f545fa0$5796fea9@baked>
MIME-Version: 1.0
In-Reply-To: <000801c3158d$497da950$5796fea9@baked>
Content-Type: text/plain; CHARSET=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

Have a look at the rfcomm_recv_rpn() function pasted below. I did a diff
between it and the latest, and the only difference is how a variable is
declared - nothing significant.

Here's what I see happening:

Take a look at XON and XOFF. If we see a value we don't like, we set
rpn->xon_char to the value that we would like to see. We also update the
rpn_mask variable. Then at the bottom of the function we call
rfcomm_send_rpn() with xon_char and not rpn->xon_char. So it sends 0 instea=
d
of the desired character, but it does send the correct rpn_mask.

It looks to me like most of the tests act on the right variables. Just xon,
xoff, and flow control appear to have the problem.=20

Do you agree?

-Daryl.

> > >         4.) TP/RFC/BV-17-C: RFCOMM Parameter Negotiation: RFCOMM
> > > doesn't respond with desired parameters in RPN response (it=20
> > responds
> > > with 0's). I took a quick look at the RFCOMM code (our
> > older version)
> > > and it's apparent that variables are being set with the
> > desired values
> > > when the tester requests values that we don't like, but those
> > > variables are not the ones that are actually sent in the=20
> > response. The
> > > parameter mask is set correctly though.
> >=20
> > Please enable RFCOMM debug output and send us the request
> > that the Tester performs.
>=20
> It'll take a bit of work to accomplish that because testing=20
> is being done remotely... But if we need to do it, we can.
>=20
> As a first step I'll send you an e-mail with the snippet of=20
> code I'm talking about and point out what I think the problem=20
> is. And when I get tester logs I'll send them too.

static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, struc=
t
sk_buff *skb)
{
	struct rfcomm_rpn *rpn =3D (void *) skb->data;
	int dlci =3D __get_dlci(rpn->dlci);

	u8 bit_rate  =3D 0;
	u8 data_bits =3D 0;
	u8 stop_bits =3D 0;
	u8 parity    =3D 0;
	u8 flow_ctrl =3D 0;
	u8 xon_char  =3D 0;
	u8 xoff_char =3D 0;
	u16 rpn_mask =3D RFCOMM_RPN_PM_ALL;
=09
	BT_DBG("dlci %d cr %d len 0x%x bitr 0x%x line 0x%x flow 0x%x xonc
0x%x xoffc 0x%x pm 0x%x",=20
	       dlci, cr, len, rpn->bit_rate, rpn->line_settings,
rpn->flow_ctrl,
	       rpn->xon_char, rpn->xoff_char, rpn->param_mask);
=09
	if (!cr)=20
		return 0;
=09
	if (len =3D=3D 1) {
		/* request: return default setting */
		bit_rate  =3D RFCOMM_RPN_BR_115200;
		data_bits =3D RFCOMM_RPN_DATA_8;
		stop_bits =3D RFCOMM_RPN_STOP_1;
		parity    =3D RFCOMM_RPN_PARITY_NONE;
		flow_ctrl =3D RFCOMM_RPN_FLOW_NONE;
		xon_char  =3D RFCOMM_RPN_XON_CHAR;
		xoff_char =3D RFCOMM_RPN_XOFF_CHAR;

		goto rpn_out;
	}
	/* check for sane values: ignore/accept bit_rate, 8 bits, 1 stop
bit, no parity,
	                          no flow control lines, normal XON/XOFF
chars */
	if (rpn->param_mask & RFCOMM_RPN_PM_DATA) {
		data_bits =3D __get_rpn_data_bits(rpn->line_settings);
		if (data_bits !=3D RFCOMM_RPN_DATA_8) {
			BT_DBG("RPN data bits mismatch 0x%x", data_bits);
			data_bits =3D RFCOMM_RPN_DATA_8;
			rpn_mask ^=3D RFCOMM_RPN_PM_DATA;
		}
	}
	if (rpn->param_mask & RFCOMM_RPN_PM_STOP) {
		stop_bits =3D __get_rpn_stop_bits(rpn->line_settings);
		if (stop_bits !=3D RFCOMM_RPN_STOP_1) {
			BT_DBG("RPN stop bits mismatch 0x%x", stop_bits);
			stop_bits =3D RFCOMM_RPN_STOP_1;
			rpn_mask ^=3D RFCOMM_RPN_PM_STOP;
		}
	}
	if (rpn->param_mask & RFCOMM_RPN_PM_PARITY) {
		parity =3D __get_rpn_parity(rpn->line_settings);
		if (parity !=3D RFCOMM_RPN_PARITY_NONE) {
			BT_DBG("RPN parity mismatch 0x%x", parity);
			parity =3D RFCOMM_RPN_PARITY_NONE;
			rpn_mask ^=3D RFCOMM_RPN_PM_PARITY;
		}
	}
	if (rpn->param_mask & RFCOMM_RPN_PM_FLOW) {
		if (rpn->flow_ctrl !=3D RFCOMM_RPN_FLOW_NONE) {
			BT_DBG("RPN flow ctrl mismatch 0x%x",
rpn->flow_ctrl);
			rpn->flow_ctrl =3D RFCOMM_RPN_FLOW_NONE;
			rpn_mask ^=3D RFCOMM_RPN_PM_FLOW;
		}
	}
	if (rpn->param_mask & RFCOMM_RPN_PM_XON) {
		if (rpn->xon_char !=3D RFCOMM_RPN_XON_CHAR) {
			BT_DBG("RPN XON char mismatch 0x%x", rpn->xon_char);
			rpn->xon_char =3D RFCOMM_RPN_XON_CHAR;
			rpn_mask ^=3D RFCOMM_RPN_PM_XON;
		}
	}
	if (rpn->param_mask & RFCOMM_RPN_PM_XOFF) {
		if (rpn->xoff_char !=3D RFCOMM_RPN_XOFF_CHAR) {
			BT_DBG("RPN XOFF char mismatch 0x%x",
rpn->xoff_char);
			rpn->xoff_char =3D RFCOMM_RPN_XOFF_CHAR;
			rpn_mask ^=3D RFCOMM_RPN_PM_XOFF;
		}
	}

rpn_out:
	rfcomm_send_rpn(s, 0, dlci,=20
			bit_rate, data_bits, stop_bits, parity, flow_ctrl,
			xon_char, xoff_char, rpn_mask);

	return 0;
}
