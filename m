Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Oct 2011 11:25:00 +0300
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH bluez 1/2] add definitions for L2CAP fixed channels
Message-ID: <20111018082459.GB8054@aemeltch-MOBL1>
References: <1318921872-18474-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1318921872-18474-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111018075610.GA28040@fusion.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111018075610.GA28040@fusion.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Oct 18, 2011 at 10:56:10AM +0300, Johan Hedberg wrote:
> > ---
> >  lib/l2cap.h |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> > 
> > diff --git a/lib/l2cap.h b/lib/l2cap.h
> > index 47b3dc3..3880551 100644
> > --- a/lib/l2cap.h
> > +++ b/lib/l2cap.h
> > @@ -139,6 +139,11 @@ struct l2cap_conninfo {
> >  
> >  #define L2CAP_SDULEN_SIZE	2
> >  
> > +/* L2CAP fixed channels */
> > +#define L2CAP_FC_L2CAP		0x02
> > +#define L2CAP_FC_CONNLESS	0x04
> > +#define L2CAP_FC_A2MP		0x08
> > +
> >  /* L2CAP structures */
> >  typedef struct {
> >  	uint16_t	len;
> 
> This doesn't apply to current bluez.git.

Sorry, rebased to bluez from kernel.org and rearranged my patches.

Best regards 
Andrei Emeltchenko 
