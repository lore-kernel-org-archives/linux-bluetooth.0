Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Apr 2012 14:51:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Remove err parameter from alloc_skb()
Message-ID: <20120412115140.GB20659@x220.ger.corp.intel.com>
References: <1333754148-18796-1-git-send-email-gustavo@padovan.org>
 <1333799079.16897.24.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333799079.16897.24.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Apr 07, 2012, Marcel Holtmann wrote:
> Hi Gustavo,
> 
> > Use ERR_PTR maginc instead.
> > 
> > Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
> > ---
> >  include/net/bluetooth/l2cap.h |    2 +-
> >  net/bluetooth/l2cap_core.c    |   30 +++++++++++++-----------------
> >  net/bluetooth/l2cap_sock.c    |   12 ++++++++----
> >  3 files changed, 22 insertions(+), 22 deletions(-)
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Applied to bluetooth-next.

Johan
