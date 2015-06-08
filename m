Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Jun 2015 18:10:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix encryption key size handling for LTKs
Message-ID: <20150608151028.GA16737@t440s.P-661HNU-F1>
References: <1433758095-3583-1-git-send-email-johan.hedberg@gmail.com>
 <74CABAA8-2FD0-443E-A26A-5DEA2B2FFBB3@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <74CABAA8-2FD0-443E-A26A-5DEA2B2FFBB3@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jun 08, 2015, Marcel Holtmann wrote:
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -276,7 +276,7 @@ u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
> > }
> > 
> > void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
> > -		      __u8 ltk[16])
> > +		      __u8 ltk[16], __u8 key_size)
> > {
> > 	struct hci_dev *hdev = conn->hdev;
> > 	struct hci_cp_le_start_enc cp;
> > @@ -288,7 +288,7 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
> > 	cp.handle = cpu_to_le16(conn->handle);
> > 	cp.rand = rand;
> > 	cp.ediv = ediv;
> > -	memcpy(cp.ltk, ltk, sizeof(cp.ltk));
> > +	memcpy(cp.ltk, ltk, key_size);
> > 
> > 	hci_send_cmd(hdev, HCI_OP_LE_START_ENC, sizeof(cp), &cp);
> > }
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 7b61be73650f..8ba29ce92b60 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -4955,7 +4955,7 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
> > 			goto not_found;
> > 	}
> > 
> > -	memcpy(cp.ltk, ltk->val, sizeof(ltk->val));
> > +	memcpy(cp.ltk, ltk->val, ltk->enc_size);
> > 	cp.handle = cpu_to_le16(conn->handle);
> 
> this is actually leaking data and might cause wrong LTK data to be
> used. We are missing the memset of the rest of key length to zero.

Good catch. I must have thought there was a memset somewhere there like
there is for hci_le_start_enc(). v2 coming up soon.

Johan
