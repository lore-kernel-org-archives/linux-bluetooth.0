Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030912095921.030764b0@unixmail.qualcomm.com>
Date: Fri, 12 Sep 2003 10:44:29 -0700
To: Marcel Holtmann <marcel@holtmann.org>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: Bluetooth update for 2.4.23-pre2
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1062432872.13729.185.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 09:14 AM 9/1/2003, Marcel Holtmann wrote:
>here are the outstanding Bluetooth updates for 2.4.23-pre. All of them
>are well tested in my -mh patches and I don't expect any other big
>changes for the 2.4 series.

Ok. I got problem with the following Changesets.

><marcel@holtmann.org> (03/08/21 1.1067)
>   [Bluetooth] Add notify() callback for host drivers
>   
>   This patch adds a notification callback to the hci_dev structure which
>   is used by the HCI core to tell the driver about connection creation
>   and clearing. It also notifies about changed voice setting. To assure
>   that the core always knows the correct voice setting, it is read at
>   device initialization and stored in the hci_dev structure.

--- 1.5/net/bluetooth/hci_conn.c        Fri Mar 21 04:26:29 2003
+++ 1.6/net/bluetooth/hci_conn.c        Thu Aug 21 06:11:42 2003
@@ -168,6 +168,9 @@
 
        hci_dev_hold(hdev);
 
+       if (hdev->notify)
+               hdev->notify(hdev, HCI_NOTIFY_CONN_ADD, (unsigned long) conn);
+

I believe I mentioned that before. Above patch basically means that driver has to keep 
its own counter of ACL and SCO connection (ie check conn->type and stuff). That does 
not make sense to me. Core already has that information. It's part of hci_conn_hash. 
Currently we single counter. So we probably need to split it. And if we do it that way 
there is no need for the third argument to hdev->notify().

><marcel@holtmann.org> (03/07/31 1.1019.1.7)
>   [Bluetooth] Set initial value of RFCOMM credits to zero
>   
>   The initial credits value must be zero, because this is default
>   for Bluetooth 1.0b without credit based flow control. Once the
>   other side signals us that it supports credit based flow control
>   we set the session wide credits value.

@@ -746,7 +746,7 @@
        pn->ack_timer   = 0;
        pn->max_retrans = 0;
 
-       if (d->credits) {
+       if (cr || d->credits) {
                pn->flow_ctrl = cr ? 0xf0 : 0xe0;
                pn->credits = RFCOMM_DEFAULT_CREDITS;
        } else {

We talked about this one too. With that change we're going to ask
for credits every time we send PN request even if other side already told 
us that they don't support CFC. This is not right. We need to negotiate CFC 
only once.

Max
