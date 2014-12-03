Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Dec 2014 10:17:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth: Fix possible NULL dereference
Message-ID: <20141203081709.GA18422@t440s.lan>
References: <1417592765-24836-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1CCB1571-FD46-4F46-9106-2FAD1ABB3960@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1CCB1571-FD46-4F46-9106-2FAD1ABB3960@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Dec 03, 2014, Marcel Holtmann wrote:
> > conn might be NULL and would be dereferenced in conn_set_key()
> > ---
> > net/bluetooth/hci_event.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index bd0a801..95f8057 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -3312,7 +3312,7 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
> > 	/* Update connection information since adding the key will have
> > 	 * fixed up the type in the case of changed combination keys.
> > 	 */
> > -	if (ev->key_type == HCI_LK_CHANGED_COMBINATION)
> > +	if (conn && ev->key_type == HCI_LK_CHANGED_COMBINATION)
> > 		conn_set_key(conn, key->type, key->pin_len);
> > 
> > 	mgmt_new_link_key(hdev, key, persistent);
> 
> the more important question is why we are considering link keys from
> the controller for a device that we do not have a hci_conn object for.
> 
> If this is for security mode 3, then we should handle security mode 3
> and then bail out of this function. Since security mode 3 means that
> we never get SSP or SC based keys. It is legacy pairing and does not
> need any special handling for debug keys or changed combination keys.

The existence of a hci_conn object in this case is not dependent on
whether we're in security mode 3 or not. The hci_conn should have either
way been created when we initiated the connection or received a
connection request (only speciality with sec mode 3 is when the conn
complete finally comes). So this particular fix is really only for a
coverity warning as far as I see (and some very broken controllers).

As for security mode 3 connections we would still want to make a note of
the key type and PIN length.

Johan
