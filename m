Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Apr 2012 19:36:08 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org,
	marcel@holtmann.org, andrei.emeltchenko.news@gmail.com,
	szymon.janc@tieto.com
Subject: Re: [PATCHv4 2/2] Bluetooth: Functions for handling ERTM control
 fields
Message-ID: <20120406223608.GB2915@joana>
References: <1333564183-23442-1-git-send-email-mathewm@codeaurora.org>
 <1333564183-23442-3-git-send-email-mathewm@codeaurora.org>
 <20120406222935.GA2915@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20120406222935.GA2915@joana>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Gustavo Padovan <gustavo@padovan.org> [2012-04-06 19:29:35 -0300]:

> Hi Mat,
>=20
> * Mat Martineau <mathewm@codeaurora.org> [2012-04-04 11:29:43 -0700]:
>=20
> > These functions encode or decode ERTM control fields (extended or
> > enhanced) to or from the new l2cap_ctrl structure.
> >=20
> > Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> > ---
> >  net/bluetooth/l2cap_core.c |   99 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 99 insertions(+)
>=20
> Both patches were applied to bluetooth-next. thanks.

net/bluetooth/l2cap_core.c:317:12: warning: =E2=80=98l2cap_seq_list_pop=E2=
=80=99 defined but not used [-Wunused-function]
net/bluetooth/l2cap_core.c:323:13: warning: =E2=80=98l2cap_seq_list_clear=
=E2=80=99 defined but not used [-Wunused-function]
net/bluetooth/l2cap_core.c:335:13: warning: =E2=80=98l2cap_seq_list_append=
=E2=80=99 defined but not used [-Wunused-function]
net/bluetooth/l2cap_core.c:780:12: warning: =E2=80=98__pack_enhanced_contro=
l=E2=80=99 defined but not used [-Wunused-function]
net/bluetooth/l2cap_core.c:823:12: warning: =E2=80=98__pack_extended_contro=
l=E2=80=99 defined but not used [-Wunused-function]

So, this is not good, we can't just throw unused code here, they will gener=
ate
warnings and I'll get complains from maintainers above me if I merge this.
Both patches were reverted.

	Gustavo
