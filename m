Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Sep 2010 15:07:35 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: haijun liu <liuhaijun.er@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mat Martineau <mathewm@codeaurora.org>,
	"dantian.ip" <dantian.ip@gmail.com>
Subject: Re: [PATCH] Bluetooth: Replace hard code of fixed channels bit mask
Message-ID: <20100917180735.GB7032@vigoh>
References: <AANLkTi=86t=osr8YUfUfU3QLHiHXgp8SCuwqOE_GoPgp@mail.gmail.com>
 <20100916141654.GB15000@vigoh>
 <20100917085047.GN14330@null>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100917085047.GN14330@null>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

* Ville Tervo <ville.tervo@nokia.com> [2010-09-17 11:50:47 +0300]:

> Hi Gustavo,
> 
> On Thu, Sep 16, 2010 at 04:16:54PM +0200, ext Gustavo F. Padovan wrote:
> > Hi Haijun,
> > 
> > * haijun liu <liuhaijun.er@gmail.com> [2010-09-16 15:15:18 +0800]:
> > 
> > > This patch add fixed channels bit mask definition for
> > >  		L2CAP_FIXCHAN_NULLID
> > >  		L2CAP_FIXCHAN_SIGNAL
> > >  		L2CAP_FIXCHAN_CONNLESS
> > >  		L2CAP_FIXCHAN_A2MP
> > > And replace hard code in source file with the macro.
> > > 
> > > Signed-off-by: Haijun.Liu <Haijun.Liu@Atheros.com>
> > > ---
> > >  include/net/bluetooth/l2cap.h |    6 ++++++
> > >  net/bluetooth/l2cap.c         |    2 +-
> > >  2 files changed, 7 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > > index 6c24144..e4fe2c7 100644
> > > --- a/include/net/bluetooth/l2cap.h
> > > +++ b/include/net/bluetooth/l2cap.h
> > > @@ -97,6 +97,12 @@ struct l2cap_conninfo {
> > >  #define L2CAP_FEAT_FCS		0x00000020
> > >  #define L2CAP_FEAT_FIXED_CHAN	0x00000080
> > > 
> > > +/* L2CAP fixed channel bitmask */
> > > +#define L2CAP_FIXCHAN_NULLID	0x00
> > > +#define L2CAP_FIXCHAN_SIGNAL	0x02
> > > +#define L2CAP_FIXCHAN_CONNLESS	0x04
> > > +#define L2CAP_FIXCHAN_A2MP	0x08
> > 
> > That's wrong, signaling channel is 0x01, connless is 0x02 and A2MP is
> > 0x03. And if you haven't noted we already have macros for the signaling
> > and connectionless channels:
> 
> But these are bit masks and looks ok to me except L2CAP_FIXCHAN_A2MP which I
> could not find from the list.. Check Vol 3 Part A 4.13.
> 
> > #define L2CAP_CID_SIGNALING     0x0001
> > #define L2CAP_CID_CONN_LESS     0x0002
> 
> These are channel ids.

Yes, you guys are completely right. I was misunderstanding that piece of
code about fixed channels. Thanks for clarify. ;)

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
