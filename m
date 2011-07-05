Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
CC: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>
Date: Tue, 5 Jul 2011 11:13:41 -0400
Subject: Re: [PATCH v2 1/1] Bluetooth: l2cap: fix NULL ACL packet handling
Message-ID: <1309878821.4125.23.camel@THOR>
References: <1309628689.22449.12.camel@THOR>
	 <1309644714.21109.7.camel@aeonflux>  <20110703014958.GA2706@joana>
In-Reply-To: <20110703014958.GA2706@joana>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Sat, 2011-07-02 at 21:49 -0400, Gustavo F. Padovan wrote:
> * Marcel Holtmann <marcel@holtmann.org> [2011-07-02 15:11:51 -0700]:
>=20
> > Hi Peter,
> >=20
> > > A 0-length ACL continuation-fragment is a valid NULL packet. Remote
> > > devices can use the FLOW indicator in the ACL packet header to
> > > flow-control ACL packets without sending a payload.
> > >=20
> > > Track as a device stat instead of logging.
> > >=20
> > > Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> > > ---
> > >  include/net/bluetooth/hci.h |    1 +
> > >  net/bluetooth/l2cap_core.c  |    8 ++++++++
> > >  2 files changed, 9 insertions(+), 0 deletions(-)
> > >=20
> > > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.=
h
> > > index 0c20227..de7ed81 100644
> > > --- a/include/net/bluetooth/hci.h
> > > +++ b/include/net/bluetooth/hci.h
> > > @@ -1142,6 +1142,7 @@ struct hci_ufilter {
> > > =20
> > >  /* ---- HCI Ioctl requests structures ---- */
> > >  struct hci_dev_stats {
> > > +	__u32 null_rx;		/* # NULL pkts recvd */
> > >  	__u32 err_rx;
> > >  	__u32 err_tx;
> > >  	__u32 cmd_tx;
> >=20
> > you can not do it like this. This will break userspace API/ABI.
>=20
> Actually I don't see a point to have null_rx counter, just drop the packe=
t and
> we are done.

Although a null_rx counter doesn't really qualify as critical or even
necessary, I thought it might be useful in helping users troubleshoot
apparent link quality issues - especially those relating to A2DP, like
dropouts and sputter.

Currently, some users experience significant audio quality issues that I
suspect is actually *not* related to link quality nor old LMP
implementations. Often these are accompanied by logs full of "Unexpected
continuation frame ..." messages. By 'full', I mean on the order of
30,000 messages in < 10 minutes.

Although I thought it appropriate to not log an error message for an
accepted flow control method, it seems a shame to simply ignore it.

Regards,
Peter
