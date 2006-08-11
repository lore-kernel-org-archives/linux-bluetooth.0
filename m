Return-Path: <ulissesf@gmail.com>
Message-ID: <d23110170608111203g590369d4qdc4592c284eafa55@mail.gmail.com>
Date: Fri, 11 Aug 2006 16:03:26 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [Bluez-devel] "File descriptor in bad state" on sdp_connect()
Cc: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1155236923.4492.49.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <44D88EC1.7010009@pracucci.com> <44D8815D.4000108@infitsrl.com>
	 <d23110170608090806j2b39e87eqd84ba9843d216153@mail.gmail.com>
	 <1155236923.4492.49.camel@aeonflux.holtmann.net>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

On 8/10/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> The attached patch should not change any behavior, but keep track of
> L2CAP connections in creation state. Please test and check the output of
> dmesg.

Hmm.. actually it changes the behavior a little bit. This part:

	default:
		conn = hcon->l2cap_data;
		if (!conn)
			break;

		spin_lock_bh(&l2cap_conn_lock);
		list_del(&conn->list);
		spin_unlock_bh(&l2cap_conn_lock);

 		l2cap_conn_del(hcon, bt_err(status));
		break;

should be like the following code. Otherwise we end up not calling
l2cap_conn_del() on hcon, right? (or am I missing anything?)

       default:
               if ((conn = hcon->l2cap_data)) {
                       spin_lock_bh(&l2cap_conn_lock);
                       list_del(&conn->list);
                       spin_unlock_bh(&l2cap_conn_lock);
               }
               l2cap_conn_del(hcon, bt_err(status));
               break;

Best regards,

-- Ulisses
