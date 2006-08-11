Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Ulisses Furquim <ulissesf@gmail.com>
In-Reply-To: <d23110170608111203g590369d4qdc4592c284eafa55@mail.gmail.com>
References: <44D88EC1.7010009@pracucci.com> <44D8815D.4000108@infitsrl.com>
	<d23110170608090806j2b39e87eqd84ba9843d216153@mail.gmail.com>
	<1155236923.4492.49.camel@aeonflux.holtmann.net>
	<d23110170608111203g590369d4qdc4592c284eafa55@mail.gmail.com>
Date: Sat, 12 Aug 2006 00:01:57 +0200
Message-Id: <1155333717.4518.14.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] "File descriptor in bad state" on sdp_connect()
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Ulisses,

> > The attached patch should not change any behavior, but keep track of
> > L2CAP connections in creation state. Please test and check the output of
> > dmesg.
> 
> Hmm.. actually it changes the behavior a little bit. This part:
> 
> 	default:
> 		conn = hcon->l2cap_data;
> 		if (!conn)
> 			break;
> 
> 		spin_lock_bh(&l2cap_conn_lock);
> 		list_del(&conn->list);
> 		spin_unlock_bh(&l2cap_conn_lock);
> 
>  		l2cap_conn_del(hcon, bt_err(status));
> 		break;
> 
> should be like the following code. Otherwise we end up not calling
> l2cap_conn_del() on hcon, right? (or am I missing anything?)
> 
>        default:
>                if ((conn = hcon->l2cap_data)) {
>                        spin_lock_bh(&l2cap_conn_lock);
>                        list_del(&conn->list);
>                        spin_unlock_bh(&l2cap_conn_lock);
>                }
>                l2cap_conn_del(hcon, bt_err(status));
>                break;

look into l2cap_conn_del() and check what happens if l2cap_data is NULL.
This doesn't change the behavior.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
