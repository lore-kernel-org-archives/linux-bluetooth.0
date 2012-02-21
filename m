Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Feb 2012 15:56:03 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 12/14] Bluetooth: Change locking logic in security_cfm
Message-ID: <20120221175602.GC22229@joana>
References: <1329821707-11817-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1329821707-11817-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329821707-11817-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-02-21 12:55:05 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Change bh_ locking functions to mutex_locks since we can now sleep.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   17 ++++++++++-------
>  1 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 7baee68..49aa226 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4572,9 +4572,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>  	mutex_lock(&conn->chan_lock);
>  
>  	list_for_each_entry(chan, &conn->chan_l, list) {
> -		struct sock *sk = chan->sk;
> -
> -		bh_lock_sock(sk);
> +		l2cap_chan_lock(chan);
>  
>  		BT_DBG("chan->scid %d", chan->scid);
>  
> @@ -4584,19 +4582,19 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>  				l2cap_chan_ready(chan);
>  			}
>  
> -			bh_unlock_sock(sk);
> +			l2cap_chan_unlock(chan);
>  			continue;
>  		}
>  
>  		if (test_bit(CONF_CONNECT_PEND, &chan->conf_state)) {
> -			bh_unlock_sock(sk);
> +			l2cap_chan_unlock(chan);
>  			continue;
>  		}
>  
>  		if (!status && (chan->state == BT_CONNECTED ||
>  						chan->state == BT_CONFIG)) {
>  			l2cap_check_encryption(chan, encrypt);
> -			bh_unlock_sock(sk);
> +			l2cap_chan_unlock(chan);
>  			continue;
>  		}
>  
> @@ -4617,9 +4615,12 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>  					msecs_to_jiffies(L2CAP_DISC_TIMEOUT));
>  			}
>  		} else if (chan->state == BT_CONNECT2) {
> +			struct sock *sk = chan->sk;
>  			struct l2cap_conn_rsp rsp;
>  			__u16 res, stat;
>  
> +			lock_sock(sk);
> +
>  			if (!status) {
>  				if (bt_sk(sk)->defer_setup) {
>  					struct sock *parent = bt_sk(sk)->parent;
> @@ -4640,6 +4641,8 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>  				stat = L2CAP_CS_NO_INFO;
>  			}
>  
> +			release_sock(sk);
> +
>  			rsp.scid   = cpu_to_le16(chan->dcid);
>  			rsp.dcid   = cpu_to_le16(chan->scid);
>  			rsp.result = cpu_to_le16(res);
> @@ -4648,7 +4651,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>  							sizeof(rsp), &rsp);
>  		}
>  
> -		bh_unlock_sock(sk);
> +		l2cap_chan_unlock(chan);

I don't like the idea of this locking change in multiple separate patches, it
could put the stack in a broken and racy state if we stop in the middle of
these patches.
I would say to merge all these patches into one, they were a lot reviewed
alone, there is no problem in create a big one with all the changes together.

	Gustavo
