Return-Path: <cyrus@holtmann.org>
Date: Sat, 14 Sep 2013 19:11:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Fix L2CAP Disconnect response for unknown
 CID
Message-ID: <20130914161131.GB12683@x220.p-661hnu-f1>
References: <1379061827-8595-1-git-send-email-johan.hedberg@gmail.com>
 <1379061827-8595-2-git-send-email-johan.hedberg@gmail.com>
 <34565D06-3DDE-40FE-A9D7-D2667630C5A7@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <34565D06-3DDE-40FE-A9D7-D2667630C5A7@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Sep 13, 2013, Marcel Holtmann wrote:
> > If we receive an L2CAP Disconnect Request for an unknown CID we should
> > not just silently drop it but reply with a proper Command Reject
> > response. This patch fixes this by ensuring that the disconnect handler
> > returns a proper error instead of 0 and will cause the function caller
> > to send the right response.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> > net/bluetooth/l2cap_core.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index b3bb7bc..ea3792f 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -4206,7 +4206,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
> > 	chan = __l2cap_get_chan_by_scid(conn, dcid);
> > 	if (!chan) {
> > 		mutex_unlock(&conn->chan_lock);
> > -		return 0;
> > +		return -EINVAL;
> > 	}
> 
> the only problem that I have here is that we end up with the wrong
> error code. The L2CAP core still contains this comment:
> 
> /* FIXME: Map err to a valid reason */
> 
> And now we default to L2CAP_REJ_NOT_UNDERSTOOD, but in this case it
> should be L2CAP_REJ_INVALID_CID.

Well, starting to look at this opened quite a can of worms. There are
several existing inconsistencies in what error codes request handlers
return in various situations. Some are even broken in that they send
their own response but still return non-zero (causing a second response
to be sent).

The current code will also sometimes send a command reject as a
consequence of incorrectly formatted response packets, which is also
wrong according to the core spec (p.1416): "Command Reject packets
should not be sent in response to an identified Response packet.".

I'll fix all of the above issues before introducing a helper function to
map the handler return value to an L2CAP error code.

Johan
