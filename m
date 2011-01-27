Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Jan 2011 14:03:15 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: "ext tim.bao@gmail.com" <tim.bao@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Set connection state to BT_DISCONN to avoid multiple
 responses
Message-ID: <20110127160315.GA2163@joana>
References: <1296091276-2238-1-git-send-email-tim.bao@gmail.com>
 <20110127074034.GI874@null>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110127074034.GI874@null>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

* Ville Tervo <ville.tervo@nokia.com> [2011-01-27 09:40:34 +0200]:

> Hi,
> 
> On Thu, Jan 27, 2011 at 09:21:16AM +0800, ext tim.bao@gmail.com wrote:
> > From: Bao Liang <tim.bao@gmail.com>
> > 
> > This patch fixes a minor issue that two connection responses will be sent
> > for one L2CAP connection request. If the L2CAP connection request is first
> > blocked due to security reason and responded with reason "security block",
> > the state of the connection remains BT_CONNECT2. If a pairing procedure
> > completes successfully before the ACL connection is down, local host will
> > send another connection complete response. See the following packets
> > captured by hcidump.
> > 
> > 2010-12-07 22:21:24.928096 < ACL data: handle 12 flags 0x00 dlen 16
> >     0000: 0c 00 01 00 03 19 08 00  41 00 53 00 03 00 00 00  ........A.S.....
> > ... ...
> > 
> > 2010-12-07 22:21:35.791747 > HCI Event: Auth Complete (0x06) plen 3
> >     status 0x00 handle 12
> > ... ...
> > 
> > 2010-12-07 22:21:35.872372 > ACL data: handle 12 flags 0x02 dlen 16
> >     L2CAP(s): Connect rsp: dcid 0x0054 scid 0x0040 result 0 status 0
> >       Connection successful
> > 
> > Signed-off-by: Bao Liang <tim.bao@gmail.com>
> > ---
> >  net/bluetooth/l2cap.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> > index fadf26b..40d70db 100644
> > --- a/net/bluetooth/l2cap.c
> > +++ b/net/bluetooth/l2cap.c
> > @@ -844,9 +844,10 @@ static void __l2cap_sock_close(struct sock *sk, int reason)
> >  			struct l2cap_conn_rsp rsp;
> >  			__u16 result;
> >  
> > -			if (bt_sk(sk)->defer_setup)
> > +			if (bt_sk(sk)->defer_setup) {
> > +				sk->sk_state = BT_DISCONN;
> >  				result = L2CAP_CR_SEC_BLOCK;
> > -			else
> > +			} else
> >  				result = L2CAP_CR_BAD_PSM;
> >  
> >  			rsp.scid   = cpu_to_le16(l2cap_pi(sk)->dcid);
> 
> Shouldn't sk->sk_state be changed in all cases and not only when socket is
> waiting for authorization?

I agree with you here. It's better treat all cases. 

-- 
Gustavo F. Padovan
http://profusion.mobi
