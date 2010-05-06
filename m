Return-Path: <cyrus@holtmann.org>
Message-ID: <549642.78851.qm@web94902.mail.in2.yahoo.com>
Date: Fri, 7 May 2010 04:08:08 +0530 (IST)
From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: Re: multiple HCI_UART protocols over hci_ldisc
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
  Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <4BE342F5.3060200@qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Max,=0A=0A--- On Fri, 7/5/10, Max Krasnyansky <maxk@qualcomm.com> wrote:=0A=
=0A> From: Max Krasnyansky <maxk@qualcomm.com>=0A> Subject: Re: multiple HC=
I_UART protocols over hci_ldisc=0A> To: "Pavan Savoy" <pavan_savoy@yahoo.co=
.in>=0A> Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel=
.org>, "Marcel Holtmann" <marcel@holtmann.org>=0A> Date: Friday, 7 May, 201=
0, 4:00 AM=0A> On 05/06/2010 03:04 PM, Pavan Savoy=0A> wrote:=0A> > Hi Marc=
el,=0A> >=0A> > I am working on a line discipline which in many=0A> respect=
s is similar to the hci_ldisc, but only extended to=0A> do plenty of other =
functionality.=0A> >=0A> > One road block which i have hit is to support mu=
ltiple=0A> devices/or as Alan Cox puts it "avoid single device limits"=0A> =
>=0A> > So, in somewhat relation to this, I wanted to ask, If=0A> in a syst=
em I have 2 UARTs both connected to BT chips but=0A> only from different ve=
ndors say TI/HCI-Ll and broadcomm with=0A> BCSP ..=0A> >=0A> > Can I have t=
hose 2 protocols on top of HCI-ldisc on=0A> different UARTs at the same tim=
e?=0A> > Is something like that feasible?=0A> Sure. You'll get two separate=
 HCI devices in that case.=0A=0ABut there seems to be only 1,=0Astatic stru=
ct hci_uart_proto *hup[HCI_UART_MAX_PROTO];=0Aint hci_uart_register_proto(s=
truct hci_uart_proto *p)=0A{=0A        if (p->id >=3D HCI_UART_MAX_PROTO)=
=0A                return -EINVAL;=0A=0A        if (hup[p->id])=0A         =
       return -EEXIST;=0A=0A        hup[p->id] =3D p;=0A=0A        return 0=
;=0A}=0A=0ASo, If suppose I have 2 UARTs both on which HCI-Ldisc exists, an=
d I try say HCI-LL on both, Now won't I get a -EEXIST for the 2nd HCI-LL ?=
=0A=0AI am a bit confused, can you explain in brief ?=0AIs there a possibil=
ity of copies of *hup[HCI_UART_MAX_PROTO] for each UART?=0A=0A> Max=0A> =0A=
=0A
