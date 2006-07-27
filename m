Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44C881B5.7060809@infitsrl.com>
Date: Thu, 27 Jul 2006 11:04:53 +0200
From: Fabrizio Guglielmino <guglielmino@infitsrl.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44BE5DB3.7090406@gmail.com>	<1153356539.4094.9.camel@aeonflux.holtmann.net>	<2172AACE-61A5-4D43-90E2-059D659D8830@infitsrl.com>	<20060724103824.1ff98fa6@McGee-XPC>
	<44C4CC37.1060308@infitsrl.com>	<20060724155621.02cd5e11@localhost.localdomain>	<1153758912.25058.3.camel@localhost>	<20060724203433.7184d301@localhost.localdomain>	<7359D844-F738-4AD1-A1FD-F59BEFD149EC@infitsrl.com>
	<1153775541.25058.6.camel@localhost>
In-Reply-To: <1153775541.25058.6.camel@localhost>
Subject: Re: [Bluez-devel] It's rfcomm connect problem
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I Marcel,
I'm trying to use the patch to handle multiple l2cap connection, I'm not =

a kernel/modules expert developer so
I need a little help.
Firts I'm trying to understand what the patch do and I think it's clear =

(is used a linked list to handle multiple connection).

My problems are with kernel programming enviromnment:

1) I'm using kernel-2.6.10 I have to update to a more recent version?

2) Is there some documentation about bluez kernel modules? I need to =

understand how modules works to make try to make the patch.

Many thanks
Fabrizio


Marcel Holtmann ha scritto:
> Hi Fabrizio,
>
>   =

>> Last solutions it's to see at l2cap layer and try to understand ho wo  =

>> write the patch, if
>> I will succeed to find  the past Marcel's thread about it I'll try to  =

>> write this patch.
>>     =

>
> it must look something like the attached one. However that one might
> crash your machine.
>
> Regards
>
> Marcel
>
>   =

> ------------------------------------------------------------------------
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 8242a0e..cb19e66 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -183,6 +183,8 @@ struct l2cap_chan_list {
>  };
>  =

>  struct l2cap_conn {
> +	struct list_head list;
> +
>  	struct hci_conn	*hcon;
>  =

>  	bdaddr_t	*dst;
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index eaaad65..1d1c423 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -63,6 +63,9 @@ static struct bt_sock_list l2cap_sk_list
>  	.lock =3D RW_LOCK_UNLOCKED
>  };
>  =

> +static LIST_HEAD(l2cap_conn_list);
> +static DEFINE_SPINLOCK(l2cap_conn_lock);
> +
>  static void __l2cap_sock_close(struct sock *sk, int reason);
>  static void l2cap_sock_close(struct sock *sk);
>  static void l2cap_sock_kill(struct sock *sk);
> @@ -295,6 +298,10 @@ static void l2cap_conn_del(struct hci_co
>  =

>  	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
>  =

> +	spin_lock_bh(&l2cap_conn_lock);
> +	list_del(&conn->list);
> +	spin_unlock_bh(&l2cap_conn_lock);
> +
>  	if (conn->rx_skb)
>  		kfree_skb(conn->rx_skb);
>  =

> @@ -642,18 +649,23 @@ static int l2cap_do_connect(struct sock =

>  	sk->sk_state =3D BT_CONNECT;
>  	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
>  =

> -	if (hcon->state =3D=3D BT_CONNECTED) {
> -		if (sk->sk_type =3D=3D SOCK_SEQPACKET) {
> -			struct l2cap_conn_req req;
> -			l2cap_pi(sk)->ident =3D l2cap_get_ident(conn);
> -			req.scid =3D __cpu_to_le16(l2cap_pi(sk)->scid);
> -			req.psm  =3D l2cap_pi(sk)->psm;
> -			l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
> -					L2CAP_CONN_REQ, sizeof(req), &req);
> -		} else {
> -			l2cap_sock_clear_timer(sk);
> -			sk->sk_state =3D BT_CONNECTED;
> -		}
> +	if (hcon->state !=3D BT_CONNECTED) {
> +		spin_lock_bh(&l2cap_conn_lock);
> +		list_add_tail(&conn->list, &l2cap_conn_list);
> +		spin_unlock_bh(&l2cap_conn_lock);
> +		goto done;
> +	}
> +
> +	if (sk->sk_type =3D=3D SOCK_SEQPACKET) {
> +		struct l2cap_conn_req req;
> +		l2cap_pi(sk)->ident =3D l2cap_get_ident(conn);
> +		req.scid =3D __cpu_to_le16(l2cap_pi(sk)->scid);
> +		req.psm  =3D l2cap_pi(sk)->psm;
> +		l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
> +				L2CAP_CONN_REQ, sizeof(req), &req);
> +	} else {
> +		l2cap_sock_clear_timer(sk);
> +		sk->sk_state =3D BT_CONNECTED;
>  	}
>  =

>  done:
> @@ -1926,12 +1938,35 @@ static int l2cap_connect_cfm(struct hci_
>  	if (hcon->type !=3D ACL_LINK)
>  		return 0;
>  =

> -	if (!status) {
> +	switch (status) {
> +	case 0x00:
>  		conn =3D l2cap_conn_add(hcon, status);
> -		if (conn)
> -			l2cap_conn_ready(conn);
> -	} else
> +		if (!conn)
> +			break;
> +
> +		spin_lock_bh(&l2cap_conn_lock);
> +		list_del(&conn->list);
> +		spin_unlock_bh(&l2cap_conn_lock);
> +
> +		l2cap_conn_ready(conn);
> +
> +		spin_lock_bh(&l2cap_conn_lock);
> +		if (!list_empty(&l2cap_conn_list)) {
> +			conn =3D list_entry(l2cap_conn_list.next, struct l2cap_conn, list);
> +			list_move_tail(&conn->list, &l2cap_conn_list);
> +			hci_conn_put(conn->hcon);
> +			hci_connect(conn->hcon->hdev, ACL_LINK, conn->dst);
> +		}
> +		spin_unlock_bh(&l2cap_conn_lock);
> +		break;
> +
> +	case 0x0c:
> +		break;
> +
> +	default:
>  		l2cap_conn_del(hcon, bt_err(status));
> +		break;
> +	}
>  =

>  	return 0;
>  }
>   =

> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   =



-- =

______________________________
Fabrizio Guglielmino =

Infit Srl
Software Engineering
Tel. +39 11 7410915
Fax. +39 11 7410915
www.infitsrl.com
C.so Svizzera, 79/8 - Torino
______________________________

Il presente messaggio ed ogni eventuale allegato hanno natura
confidenziale e sono riservati ai destinatari indicati. La diffusione a
terzi e qualsiasi altro uso non autorizzato sono proibiti. I messaggi ed
i relativi allegati possono essere soggetti ad alterazioni. Il mittente
declina ogni responsabilit=E0 per le eventuali alterazioni, modificazioni
o falsificazioni.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
