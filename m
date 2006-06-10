Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <448A981D.6030101@free.fr>
Date: Sat, 10 Jun 2006 11:59:57 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <447B4F98.8020501@free.fr>	<1148934839.31689.116.camel@localhost>
	<447C4862.5050205@free.fr>	<1149189300.28511.61.camel@localhost>
	<448733E2.7090602@free.fr>	<1149712246.22472.56.camel@localhost>
	<4489AA6C.7010300@free.fr>
	<1149884263.3985.10.camel@aeonflux.holtmann.net>
In-Reply-To: <1149884263.3985.10.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] [PATCH] SCO flow control
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

Hi Marcel,

A just thought to a few more things related to a sco socket.
I just though to a real advantage of using socket for SCO (vs ALSA 
device or character device).
Using a character or block device usually means that the device is 
connected. You can plug your USB mass storage device, and the /dev/sda 
will be usefull.
Sockets are usually used to connect to devices that the OS does not know 
if they exist or not (think to a distant IP host: the kernel has no way 
of knowing if it is valid are not. The connect call will just ask the 
kernel to 'give a try', and bail out if the device does not exist).
Having said that, this is really quite similar to the bluetooth 
technology, where before you have tryed to connect, you don't know if 
the device is on or off...)

And for kfifo use: it make sense, however the bad point is that all 
bluez stack is coded with sk_buffs all over the place. Using kfifo
today will mean having to do the following convertion:

(hci core) kfifo --> (hci device) sk_buff

I think for now i'm gonna stick with sk_buffs :-)
However i will have a look to see how to queue sk_buffs at hci core 
layer instead of socket layer :-)

Cheers,

Fabien


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
