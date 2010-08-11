Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Wed, 11 Aug 2010 00:58:45 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Mat Martineau <mathewm@codeaurora.org>, linux-bluetooth@vger.kernel.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RFC 4/7] Bluetooth: Linearize received L2CAP skbuffs.
Message-ID: <20100811035845.GB9293@vigoh>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
 <1281467704-5378-5-git-send-email-mathewm@codeaurora.org>
 <1281476313.12579.229.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281476313.12579.229.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Marcel Holtmann <marcel@holtmann.org> [2010-08-10 17:38:33 -0400]:

> Hi Mat,
> 
> > Fragmented skbs are only encountered by in-kernel protocols and
> > profiles when receiving ERTM or streaming mode L2CAP data.  BNEP,
> > CMTP, HIDP, and RFCOMM generally use basic mode, so will not
> > generally need the extra memcpy's necessary to put the L2CAP
> > payload in to a linear buffer.  However, it is possible to
> > use enhanced L2CAP in these modes so the possibility needs
> > to be handled.
> > 
> > Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> > ---
> >  net/bluetooth/bnep/core.c   |    5 ++++-
> >  net/bluetooth/cmtp/core.c   |    5 ++++-
> >  net/bluetooth/hidp/core.c   |   10 ++++++++--
> >  net/bluetooth/rfcomm/core.c |    5 ++++-
> >  4 files changed, 20 insertions(+), 5 deletions(-)
> 
> in general I am fine with this.

Same from me.

-- 
Gustavo F. Padovan
http://padovan.org
