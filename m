Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Aug 2015 13:23:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Nicholas Krause <xerofoify@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth:Fix locking issues in the function
 l2cap_connect_cfm
Message-ID: <20150824102335.GF6958@t440s.lan>
References: <1439924902-13408-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439924902-13408-1-git-send-email-xerofoify@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nicholas,

On Tue, Aug 18, 2015, Nicholas Krause wrote:
> This fixes a locking issue in the function l2cap_connect_cfm for
> not locking the mutex lock for channels on the l2cap_conn structure
> pointer conn before calling __l2cap_get_chan_by_dcid as all callers
> need to lock and unlock this mutex before calling this function due
> to issues with either concurrent users or race conditions arising
> if this mutex is not locked before these calls.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  net/bluetooth/l2cap_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 45fffa4..fcee783 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -7285,9 +7285,11 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
>  		struct l2cap_chan *chan, *next;
>  
>  		/* Client fixed channels should override server ones */
> +		mutex_lock(&conn->chan_lock);
>  		if (__l2cap_get_chan_by_dcid(conn, pchan->scid))
>  			goto next;
> -
> +
> +		mutex_unlock(&conn->chan_lock);
>  		l2cap_chan_lock(pchan);
>  		chan = pchan->ops->new_connection(pchan);
>  		if (chan) {
> @@ -7301,6 +7303,7 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
>  
>  		l2cap_chan_unlock(pchan);
>  next:
> +		mutex_unlock(&conn->chan_lock);
>  		next = l2cap_global_fixed_chan(pchan, hcon);
>  		l2cap_chan_put(pchan);
>  		pchan = next;

This looks broken to me. If __l2cap_get_chan_by_dcid() returns NULL
(i.e. the jump to 'next' is *not* taken then the code will end up
calling mutex_unlock(&conn->chan_lock) twice. We can probably take the
penalty of keeping the lock a bit longer, i.e. you should be able to
drop your first unlock() call. In fact you *have* to keep the lock
longer since __l2cap_chan_add() requires it.

Johan
