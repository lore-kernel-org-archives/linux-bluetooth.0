Return-Path: <cyrus@holtmann.org>
Subject: RE: kernel carsh using Bluez on Netbook platform
From: Marcel Holtmann <marcel@holtmann.org>
To: "Xu, Martin" <martin.xu@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Liu, Bing Wei" <bing.wei.liu@intel.com>
In-Reply-To: <1241538231.2987.1.camel@localhost.localdomain>
References: <ef67228d0905031346q740aa88es5203a64a151de2e@mail.gmail.com>
	 <1241399835.2899.0.camel@localhost.localdomain>
	 <9F0C1DB20AFA954FA1DA05309350433D5F913D45@pdsmsx503.ccr.corp.intel.com>
	 <9F0C1DB20AFA954FA1DA05309350433D5F913D94@pdsmsx503.ccr.corp.intel.com>
	 <1241538231.2987.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 05 May 2009 09:08:47 -0700
Message-Id: <1241539727.2987.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

> > >On netbook platform( Eeepc 901; "Aspire One + Omiz Bluetooth dongle"), when using >bluez, such as paring, l2ping and rfcomm, kernel crashes easily.
> > >I am using kernel 2.6.29. 
> > 
> > >I caught the crash messag:
> > >BUG: spinlock bad magic on CPU#0, swapper/0
> > >Bug: unable to handle kernel paging request at 00646733
> > 
> > I have done some research on the issue and found that at 
> > hci_event.c: hci_disconn_complete_evt()
> > After 
> > hci_conn_del_sysfs(conn)
> > The contents of conn maybe modified 
> > Such as 
> > conn->idle_timer
> > conn->disc_timer
> > and
> > conn->list
> > that leads to crash of kernel when run hci_conn_del(conn)
> > 
> > I worked a patch to run hci_conn_del_sysfs after hci_conn_del and find that the issue can be fixed. Some one can tell me whether the patch is ok, and the root cause of the issue. Thanks! :) 
> > 
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index f91ba69..1999ac1 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -1009,10 +1009,9 @@ static inline void hci_disconn_complete_evt(struct
> > hci_dev *hdev, struct sk_buff
> >         if (conn) {
> >                 conn->state = BT_CLOSED;
> > 
> > -               hci_conn_del_sysfs(conn);
> > -
> >                 hci_proto_disconn_ind(conn, ev->reason);
> >                 hci_conn_del(conn);
> > +               hci_conn_del_sysfs(conn);
> >         }
> > 
> >         hci_dev_unlock(hdev);
> 
> can you verify that a bluetooth-testing.git kernel would still procude
> this NULL pointer dereference. It looks a little bit different, but I
> think that actually got fixed now.

I just double-checked the kernel patches and since you are still running
a 2.6.29 kernel you might be missing this patch:

Bluetooth: Move hci_conn_del_sysfs() back to avoid device destruct too early

@@ -287,6 +287,8 @@ int hci_conn_del(struct hci_conn *conn)
 
 	skb_queue_purge(&conn->data_q);
 
+	hci_conn_del_sysfs(conn);
+
 	return 0;
 }
 
@@ -560,8 +562,6 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
 
 		c->state = BT_CLOSED;
 
-		hci_conn_del_sysfs(c);
-
 		hci_proto_disconn_cfm(c, 0x16);
 		hci_conn_del(c);
 	}

The code got a lot of changes when adding Simple Pairing support and
thus you might need a special patch if you wanna keep using 2.6.29. I
would still advise you to check with bluetooth-testing.git first and if
that works, then just backport all of the Bluetooth patches. The Fedora
kernel contains two patches for the backport already and the missing
ones can be added easily on top of it.

Regards

Marcel


