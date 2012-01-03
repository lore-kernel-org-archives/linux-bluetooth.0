Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 2 Jan 2012 22:18:27 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] Bluetooth: Fix context in rfcomm_sock_lock
Message-ID: <20120103001826.GB1472@joana>
References: <1325006928-3338-1-git-send-email-padovan@profusion.mobi>
 <1325542684.1965.394.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325542684.1965.394.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2012-01-02 14:18:04 -0800]:

> Hi Gustavo,
> 
> > Code now run in process context, does not need to disable interrupt
> > anymore.
> > 
> > Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> > ---
> >  net/bluetooth/rfcomm/sock.c |   12 ++++++------
> >  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> 
> However I get the feeling that we might should mover all the Bluetooth
> specific socket list locking to RCU.

I agree, but I can't go ahead with such a change now, the merge windows is
around the corner.

	Gustavo
