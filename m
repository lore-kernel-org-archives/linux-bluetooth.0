Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Jul 2011 10:17:26 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: L2CAP extended feature mask update
Message-ID: <20110706071724.GA31348@aemeltch-MOBL1>
References: <1309869322-26307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20110705160028.GB29925@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110705160028.GB29925@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Jul 05, 2011 at 01:00:28PM -0300, Gustavo Padovan wrote:
> Hi Andrei,
> 
> * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-07-05 15:35:22 +0300]:
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Update L2CAP extended feature mask to reflect recent BT spec.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  include/net/bluetooth/l2cap.h |    6 +++++-
> >  1 files changed, 5 insertions(+), 1 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > index 9c18e55..d85e55c 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -92,13 +92,17 @@ struct l2cap_conninfo {
> >  #define L2CAP_CONN_PARAM_UPDATE_REQ	0x12
> >  #define L2CAP_CONN_PARAM_UPDATE_RSP	0x13
> >  
> > -/* L2CAP feature mask */
> > +/* L2CAP extended feature mask */
> >  #define L2CAP_FEAT_FLOWCTL	0x00000001
> >  #define L2CAP_FEAT_RETRANS	0x00000002
> > +#define L2CAP_FEAT_BIDIR_QOS	0x00000004
> >  #define L2CAP_FEAT_ERTM		0x00000008
> >  #define L2CAP_FEAT_STREAMING	0x00000010
> >  #define L2CAP_FEAT_FCS		0x00000020
> > +#define L2CAP_FEAT_EXT_FLOW	0x00000040
> >  #define L2CAP_FEAT_FIXED_CHAN	0x00000080
> > +#define L2CAP_FEAT_EXT_WINDOW	0x00000100
> > +#define L2CAP_FEAT_UCD		0x00000200
> 
> I don't see the point in adding if we are not using them. Let's add them when
> we have code that uses such macros.

Those values are used in user space tools like l2test and hcidump, so I
was thinking to keep headers for userspace/kernel in sync.

BTW: Do we really need to have 2 sets of headers? 
Can we use (#if defined __KERNEL__) to separate kernel-specific code?

Best regards 
Andrei Emeltchenko 
