Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030912095921.030764b0@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030912095921.030764b0@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1063406933.28891.361.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: Bluetooth update for 2.4.23-pre2
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 13 Sep 2003 00:48:47 +0200

Hi Max,

> Ok. I got problem with the following Changesets.
> 
> ><marcel@holtmann.org> (03/08/21 1.1067)
> >   [Bluetooth] Add notify() callback for host drivers
> >   
> >   This patch adds a notification callback to the hci_dev structure which
> >   is used by the HCI core to tell the driver about connection creation
> >   and clearing. It also notifies about changed voice setting. To assure
> >   that the core always knows the correct voice setting, it is read at
> >   device initialization and stored in the hci_dev structure.
> 
> --- 1.5/net/bluetooth/hci_conn.c        Fri Mar 21 04:26:29 2003
> +++ 1.6/net/bluetooth/hci_conn.c        Thu Aug 21 06:11:42 2003
> @@ -168,6 +168,9 @@
>  
>         hci_dev_hold(hdev);
>  
> +       if (hdev->notify)
> +               hdev->notify(hdev, HCI_NOTIFY_CONN_ADD, (unsigned long) conn);
> +
> 
> I believe I mentioned that before. Above patch basically means that driver has to keep 
> its own counter of ACL and SCO connection (ie check conn->type and stuff). That does 
> not make sense to me. Core already has that information. It's part of hci_conn_hash. 
> Currently we single counter. So we probably need to split it. And if we do it that way 
> there is no need for the third argument to hdev->notify().

you mention that, but I only thought of it as some kind of additional
modification so we don't have to count the number of ACL and SCO in the
driver itself.

I want to keep the the third parameter to be save in future if we need
to send other notifications down to the HCI driver for which we can use
it eventually. Bluetooth 1.2 and 2.0 will come with new stuff that may
need it.

For the CONN_ADD and CONN_DEL I think we should also send the "conn"
down to the driver so it can read from it if needed. If not, it has to
go by itself through the hash and I don't see any way that the driver
can find out the current added connection. Am I wrong?

> ><marcel@holtmann.org> (03/07/31 1.1019.1.7)
> >   [Bluetooth] Set initial value of RFCOMM credits to zero
> >   
> >   The initial credits value must be zero, because this is default
> >   for Bluetooth 1.0b without credit based flow control. Once the
> >   other side signals us that it supports credit based flow control
> >   we set the session wide credits value.
> 
> @@ -746,7 +746,7 @@
>         pn->ack_timer   = 0;
>         pn->max_retrans = 0;
>  
> -       if (d->credits) {
> +       if (cr || d->credits) {
>                 pn->flow_ctrl = cr ? 0xf0 : 0xe0;
>                 pn->credits = RFCOMM_DEFAULT_CREDITS;
>         } else {
> 
> We talked about this one too. With that change we're going to ask
> for credits every time we send PN request even if other side already told 
> us that they don't support CFC. This is not right. We need to negotiate CFC 
> only once.

Yes, you told me that. And I put a note on my TODO list that this needs
further attention. But your suggestions was to change the credits value
from uint to int and don't find the time to check if a type change may
not causes other problems. And as I also said a new flag may be a better
solution.

Anyway I took the patch in, because it fixes the problem and whithout we
have a bug with incoming 1.0b connections. The double negotiation only
takes place on the second outgoing connections to the same 1.0b device.
And how much 1.0b devices do you have or do you know of? My only 1.0b
device is a Ericsson T39m and even my old Nokia 6210 already supports
CFC. And my HBH-10 don't count, because it support only one RFCOMM
connection ;)

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
