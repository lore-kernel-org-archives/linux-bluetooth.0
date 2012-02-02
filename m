Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Feb 2012 09:15:50 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 0/2] Fixes kernel crashes and warnings
Message-ID: <20120202171550.GA22585@x220.globalsuite.net>
References: <1328171538-16020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328199079.2062.16.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328199079.2062.16.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Feb 02, 2012, Marcel Holtmann wrote:
> > Set of patches fixes issues with traversing RCU lists.
> > 
> > Changes:
> > 	v2: removed patch fixing delayed work warnings since
> > 	the issue was proper fixed already.
> > 
> > Andrei Emeltchenko (2):
> >   Bluetooth: Use list _safe deleting from conn_hash_list
> >   Bluetooth: Use list _safe deleting from conn chan_list
> > 
> >  net/bluetooth/hci_conn.c |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> if nobody else objects, then these two patches should be applied.

They're in my bluetooth-next tree now. Thanks.

Johan
