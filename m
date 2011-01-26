Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Jan 2011 15:21:02 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: tim.bao@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Set connection state to BT_DISCONN to avoid multiple
 responses
Message-ID: <20110126172102.GD27017@joana>
References: <1295443329-26860-1-git-send-email-tim.bao@gmail.com>
 <20110126171815.GC27017@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110126171815.GC27017@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Gustavo F. Padovan <padovan@profusion.mobi> [2011-01-26 15:18:15 -0200]:

> Hi Bao,
> 
> * tim.bao@gmail.com <tim.bao@gmail.com> [2011-01-19 21:22:09 +0800]:
> 
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
> > ---
> >  net/bluetooth/l2cap.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> Patch has been applied. Thanks.

I had to revert it, your patch doesn't have a Signed-off-by: line. Please send
me that.

-- 
Gustavo F. Padovan
http://profusion.mobi
