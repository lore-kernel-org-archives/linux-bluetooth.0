Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Tue, 27 Dec 2011 15:37:25 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 05/12] Bluetooth: Don't use *_bh locks anymore
Message-ID: <20111227173725.GD8298@joana>
References: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-2-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-3-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-4-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-5-git-send-email-padovan@profusion.mobi>
 <1324583358.1965.225.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324583358.1965.225.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2011-12-22 11:49:18 -0800]:

> Hi Gustavo,
> 
> > Those locks are not shared between interrupt and process context anymore,
> > so remove the part that disable interruption. We are stiff safe because
> > preeption is disabled.
> > 
> > Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> > ---
> >  net/bluetooth/l2cap_core.c |   24 ++++++++++++------------
> >  1 files changed, 12 insertions(+), 12 deletions(-)
> 
> any reason why this can not be converted into RCU usage?

Yes, when the element is added to the list its psm and cid both equals to 0.
In a following call the psm or cid is set, but at this point, we can't let a
reader read an old version of these value, this may cause two socket to
succeed on trying to connect to the same psm for example. spin lock is the
only safe choice here I think.

	Gustavo
