Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Mon, 21 Jul 2008 03:05:26 +0000 (UTC)
Message-ID: <loom.20080721T023453-583@post.gmane.org>
References: <loom.20080714T020902-534@post.gmane.org>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] =?utf-8?q?Questions_when_tracing_the_hci=5Fusb?=
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

> (1) In hci_usb_isoc_rx_submit, I saw the usb_rcvisocpipe are 
> initializing settings for Host-side.
> But why is it necessary to call usb_submit_urb() to send
> the urb, and then repeat infinitely in hci_usb_rx_complete 
> when the returned count is 0? 
> Is that mandatory to do this to permit the usb device to send data
> up to Host?

Answering to myself
The USB host controls the transactions on the USB bus.
If host wants to retrieve the data from the USB device, 
it needs to initiate the transaction by submitting a request 
packet down to the USB bus (using the IN pipe).
Correct me if I am wrong.

> (2) Why the isoc is set to 2 in the beginning? 
> What will happen when we set it to something like "5" in the beginning? 
> (Alok's patches seems to dynamically
> adjust it depending on  hdev->conn_hash.sco_num)

>>From the HCI USB Transport Layer spec., 
interface 1 has the following requirement:
* alternative setting 0 is for "No active voice channels"
* alternative setting 1 is for "One voice channel with 8-bit encoding"
* alternative setting 2 is for "Two voice channels with 8-bit encoding 
& One voice channel with 16-bit encoding"

I have tried to setup three PCs, each with a bluetooth usb adapter.
http://www.cyber-blue.com/products_info.asp?id=19&code=AC
PC1 is configured as Master role, and PC2 is Slave.
The scotest can be used to send one SCO voice traffic from PC2 to PC1.
But when I use another PC3 to connect to PC1,
there is no connection request event found in PC1.
(tried alternative settings from 2 to 5)

I am wandering it's the adapter problem or the hci_usb problem? 
since so many people are using CSR adapter
(which product are you guys using?)

The following page is my tracing to the hci_usb, just for sharing.
http://docs.google.com/
View?docID=ajgdxrgpktxt_149gqvt45cw&revision=_latest

It's not a beautiful document.
But I really hope to find some comments from 
someone who is working on multiple SCO.

Bests, Jui-Hao



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
