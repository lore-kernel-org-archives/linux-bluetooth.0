Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.00.0904102019220.21577@localhost.localdomain>
References: <8db1092f0904070037q426fd8dcx4aa48c70e40b5d6c@mail.gmail.com>
	 <20090409212028.7b2aa88c.akpm@linux-foundation.org>
	 <8db1092f0904100340g7b7eb310y805e8680a32e3ac8@mail.gmail.com>
	 <alpine.LFD.2.00.0904101329170.21577@localhost.localdomain>
	 <8db1092f0904100747w297a0daas9ebd05486d06e706@mail.gmail.com>
	 <alpine.LFD.2.00.0904101819070.21577@localhost.localdomain>
	 <8db1092f0904100952x64048907gea6bbaf25488de26@mail.gmail.com>
	 <alpine.LFD.2.00.0904101854250.21577@localhost.localdomain>
	 <8db1092f0904101057x56000b73w9de3227b2a3a9abb@mail.gmail.com>
	 <alpine.LFD.2.00.0904102019220.21577@localhost.localdomain>
Date: Sat, 18 Apr 2009 21:04:18 +0800
Message-ID: <a8e1da0904180604k8108bc5hf95705c42d80fcf9@mail.gmail.com>
Subject: Re: [2.6.29-git12] BUG: scheduling while atomic: swapper/0/0x10000100
From: Dave Young <hidave.darkstar@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Maciej Rutecki <maciej.rutecki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Apr 11, 2009 at 2:25 AM, Thomas Gleixner <tglx@linutronix.de> wrote=
:
> Maciej,
>
> On Fri, 10 Apr 2009, Maciej Rutecki wrote:
>> 2009/4/10 Thomas Gleixner <tglx@linutronix.de>:
>>
>> [...]
>> > Please upload trace.bz2 file to some place.
>>
>> http://unixy.pl/maciek/download/kernel/2.6.30-rc1-git3/laptop/trace-2.6.=
30-rc1-git3.bz2
>
> Ok. That gives us the necessary information:
>
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d... 76597263us : do_softirq <-irq_e=
xit
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d... 76597263us : __do_softirq <-do_=
softirq
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597264us : tasklet_action <-_=
_do_softirq
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597265us : hci_rx_task <-task=
let_action
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597266us : _read_lock <-hci_r=
x_task
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597267us : skb_dequeue <-hci_=
rx_task
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597268us : _spin_lock_irqsave=
 <-skb_dequeue
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597269us : _spin_unlock_irqre=
store <-skb_dequeue
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597270us : hci_send_to_sock <=
-hci_rx_task
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597270us+: _read_lock <-hci_s=
end_to_sock
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597272us : skb_clone <-hci_se=
nd_to_sock
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597273us : kmem_cache_alloc <=
-skb_clone
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597274us : __skb_clone <-skb_=
clone
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597275us : __copy_skb_header =
<-__skb_clone
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597276us : skb_push <-hci_sen=
d_to_sock
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597277us : sock_queue_rcv_skb=
 <-hci_send_to_sock
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597278us : sk_filter <-sock_q=
ueue_rcv_skb
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597279us : security_sock_rcv_=
skb <-sk_filter
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597280us : cap_socket_sock_rc=
v_skb <-security_sock_rcv_skb
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597280us : local_bh_disable <=
-sk_filter
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597281us : local_bh_enable <-=
sk_filter
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597282us : skb_queue_tail <-s=
ock_queue_rcv_skb
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597283us : _spin_lock_irqsave=
 <-skb_queue_tail
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597284us : _spin_unlock_irqre=
store <-skb_queue_tail
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597285us : sock_def_readable =
<-sock_queue_rcv_skb
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597286us : _read_lock <-sock_=
def_readable
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597286us : __wake_up_sync_key=
 <-sock_def_readable
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1..s. 76597287us : _spin_lock_irqsave=
 <-__wake_up_sync_key
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597288us : __wake_up_common <=
-__wake_up_sync_key
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597289us : pollwake <-__wake_=
up_common
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597290us : default_wake_funct=
ion <-pollwake
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597290us : try_to_wake_up <-d=
efault_wake_function
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597292us : update_shares <-tr=
y_to_wake_up
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597293us : walk_tg_tree <-upd=
ate_shares
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597294us : tg_nop <-walk_tg_t=
ree
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597294us : tg_nop <-walk_tg_t=
ree
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597295us : tg_shares_up <-wal=
k_tg_tree
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597297us : tg_nop <-walk_tg_t=
ree
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597297us : tg_shares_up <-wal=
k_tg_tree
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597298us : tg_nop <-walk_tg_t=
ree
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597299us : tg_shares_up <-wal=
k_tg_tree
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597300us : tg_nop <-walk_tg_t=
ree
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597301us : tg_shares_up <-wal=
k_tg_tree
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597302us : tg_nop <-walk_tg_t=
ree
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597303us : tg_shares_up <-wal=
k_tg_tree
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597304us : tg_shares_up <-wal=
k_tg_tree
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597305us+: task_rq_lock <-try=
_to_wake_up
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597314us : _spin_lock <-task_=
rq_lock
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597315us : select_task_rq_fai=
r <-try_to_wake_up
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597316us : activate_task <-tr=
y_to_wake_up
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597317us : enqueue_task_fair =
<-activate_task
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597317us : enqueue_entity <-e=
nqueue_task_fair
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597318us : update_curr <-enqu=
eue_entity
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597319us : place_entity <-enq=
ueue_entity
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597320us : enqueue_entity <-e=
nqueue_task_fair
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597321us : update_curr <-enqu=
eue_entity
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597321us : place_entity <-enq=
ueue_entity
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597322us : check_preempt_curr=
_idle <-try_to_wake_up
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1d.s. 76597323us : resched_task <-che=
ck_preempt_curr_idle
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1dNs. 76597324us : _spin_unlock_irqre=
store <-try_to_wake_up
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1dNs. 76597325us+: _spin_unlock_irqre=
store <-__wake_up_sync_key
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1.Ns. 76597326us : hci_event_packet <=
-hci_rx_task
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1.Ns. 76597327us : skb_pull <-hci_eve=
nt_packet
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1.Ns. 76597328us : _spin_lock <-hci_e=
vent_packet
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1.Ns. 76597330us : del_timer <-hci_ev=
ent_packet
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1.Ns. 76597331us : hci_conn_add_sysfs=
 <-hci_event_packet
> =C2=A0<idle>-0 =C2=A0 =C2=A0 =C2=A0 1.Ns. 76597332us+: dev_set_name <-hci=
_conn_add_sysfs

Marcel, this is caused by hci conn id changes, originally the conn id
is like "acl:xx:xx:xx:xx:xx:xx", then it was changed to
"hdev_name:connection_handle", yes use the handle looks better, but it
need to be done in the event handling function.

What do you think about change back to original way plus hdev_name?
like:  "hdev_name:xx:xx:xx:xx:xx:xx"


diff -uprN a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
--- a/net/bluetooth/hci_conn.c	2009-04-18 19:45:21.000000000 +0800
+++ b/net/bluetooth/hci_conn.c	2009-04-18 19:45:15.000000000 +0800
@@ -247,6 +247,8 @@ struct hci_conn *hci_conn_add(struct hci
 	if (hdev->notify)
 		hdev->notify(hdev, HCI_NOTIFY_CONN_ADD);

+	hci_conn_add_sysfs(conn);
+
 	tasklet_enable(&hdev->tx_task);

 	return conn;
diff -uprN a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
--- a/net/bluetooth/hci_event.c	2009-04-18 19:45:28.000000000 +0800
+++ b/net/bluetooth/hci_event.c	2009-04-18 19:45:15.000000000 +0800
@@ -878,8 +878,6 @@ static inline void hci_conn_complete_evt
 		} else
 			conn->state =3D BT_CONNECTED;

-		hci_conn_add_sysfs(conn);
-
 		if (test_bit(HCI_AUTH, &hdev->flags))
 			conn->link_mode |=3D HCI_LM_AUTH;

@@ -1656,8 +1654,6 @@ static inline void hci_sync_conn_complet
 	if (!ev->status) {
 		conn->handle =3D __le16_to_cpu(ev->handle);
 		conn->state  =3D BT_CONNECTED;
-
-		hci_conn_add_sysfs(conn);
 	} else
 		conn->state =3D BT_CLOSED;

diff -uprN a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
--- a/net/bluetooth/hci_sysfs.c	2009-04-18 19:45:35.000000000 +0800
+++ b/net/bluetooth/hci_sysfs.c	2009-04-18 19:45:15.000000000 +0800
@@ -101,6 +101,7 @@ static void add_conn(struct work_struct
 void hci_conn_add_sysfs(struct hci_conn *conn)
 {
 	struct hci_dev *hdev =3D conn->hdev;
+	bdaddr_t *ba =3D &conn->dst;

 	BT_DBG("conn %p", conn);

@@ -108,7 +109,11 @@ void hci_conn_add_sysfs(struct hci_conn
 	conn->dev.class =3D bt_class;
 	conn->dev.parent =3D &hdev->dev;

-	dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
+	dev_set_name(&conn->dev,
+			"%s:%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
+			hdev->name,
+			ba->b[5], ba->b[4], ba->b[3],
+			ba->b[2], ba->b[1], ba->b[0]);

 	dev_set_drvdata(&conn->dev, conn);
