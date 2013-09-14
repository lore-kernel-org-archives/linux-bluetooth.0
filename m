Return-Path: <cyrus@holtmann.org>
Date: Sat, 14 Sep 2013 08:48:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Bluetooth: Fix responding to invalid L2CAP signaling
 commands
Message-ID: <20130914054851.GA2777@x220.p-661hnu-f1>
References: <1379061827-8595-1-git-send-email-johan.hedberg@gmail.com>
 <1379061827-8595-3-git-send-email-johan.hedberg@gmail.com>
 <56BC5629-3745-4561-90CA-7BB66D52E205@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56BC5629-3745-4561-90CA-7BB66D52E205@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Sep 13, 2013, Marcel Holtmann wrote:
> > @@ -5304,6 +5305,9 @@ static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
> > 
> > 	l2cap_raw_recv(conn, skb);
> > 
> > +	if (hcon->type != LE_LINK)
> > +		return;
> > +
> 
> However I do have a question here. Can we just drop the packet or
> should we even in this case return invalid CID. What does the core
> spec. recommend in this case?

I faced this issue at the last UPF and had to do some thinking about it
as well as discuss it with some other stack developers. The conclusion
was that dropping is the right thing since on non-LE links this is in
practice an unknown CID and unknown data.

The core spec doesn't explicitly say that data should be dropped in this
case (it doesn't say anything about responding either). Instead, the LE
signaling channel is simply not defined for non-LE links (the exact
words in the spec are "not available" and "not supported"). It's like
you'd receive data on any unknown CID. Responding something on it would
be just as bad behavior as the peer sending the initial command.

Johan
