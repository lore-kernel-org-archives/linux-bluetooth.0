Return-Path: <johan.hedberg@gmail.com>
Date: Wed, 2 Dec 2015 10:46:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Don't treat connection timeout as a failure
Message-ID: <20151202084606.GB13305@t440s.lan>
References: <1448961769-20546-1-git-send-email-johan.hedberg@gmail.com>
 <7DB5C188-FDEA-45D4-B02D-36FA5454563F@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7DB5C188-FDEA-45D4-B02D-36FA5454563F@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Dec 01, 2015, Marcel Holtmann wrote:
> > When we're doing background scanning and connection attempts it's
> > possible we timeout trying to connect and go back to scanning again.
> > The timeout triggers a HCI_LE_Create_Connection_Cancel which will
> > trigger a Connection Complete with "Unknown Connection Identifier"
> > error status. Since we go back to scanning this isn't really a failure
> > and shouldn't be presented as such to user space through mgmt.
> > 
> > The exception to this is if the connection attempt was due to an
> > explicit request on an L2CAP socket (indicated by
> > params->explicit_connect being true). Since the socket will get an
> > error it's consistent to also notify the failure on mgmt in this case.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> > net/bluetooth/hci_conn.c | 12 ++++++++++--
> > 1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index f28741d78e0b..de7fa9f78cbe 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -668,8 +668,16 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
> > 
> > 	conn->state = BT_CLOSED;
> > 
> > -	mgmt_connect_failed(hdev, &conn->dst, conn->type, conn->dst_type,
> > -			    status);
> > +	/* If the failure was due to a timeout and cancelation of the
> > +	 * attempt there's no point of notifying failure since we'll go
> > +	 * back to keep trying to connect. The only exception is
> > +	 * explicit connect requests where a timeout + cancel does
> > +	 * indicate an actual failure.
> > +	 */
> > +	if (status != HCI_ERROR_UNKNOWN_CONN_ID ||
> > +	    (params && params->explicit_connect))
> > +		mgmt_connect_failed(hdev, &conn->dst, conn->type,
> > +				    conn->dst_type, status);
> 
> are we okay with the oversimplified error handling. I think the HCI is
> pretty clear that an Unknown Connection Identifier error can only be
> traced back to the fact that LE Create Connection Cancel was issued,
> but the connection had already been established.

Where in the spec do you conclude this from? The section for
HCI_LE_Create_Connection_Cancel states:

"
If the cancellation was successful then, after the Command Complete
event for the LE_Create_Connection_Cancel command:

 - if the LE Enhanced Connection Complete event is unmasked, then that
   event shall be sent.
 - otherwise the LE Connection Complete event shall be sent.

In either case, the event shall be sent with the error code Unknown
Connection Identifier (0x02).
"

That doesn't talk anything about a connection already having been
established but rather a successful cancellation. The
hci_le_conn_failed() gets called from the event handler for LE
Connection Complete, so this error code here means that the cancellation
was successful.

> Can you cause that error also with LE Create Connection itself? I
> doubt it, but we want to be 100% clear here and maybe also be event
> clear in the the comment on what kind of errors we are catching and
> why. I think citing the spec might be a good idea here as well.

I can clarify in the comment that specifically Unknown Conn ID means
that the cancellation was successful.

Johan
