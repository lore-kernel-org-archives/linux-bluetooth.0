Return-Path: <cyrus@holtmann.org>
Message-ID: <006001c842ee$f30945e0$0200a8c0@jester>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <200712192341.02293.post@hendrik-sattler.de>
	<1198107273.8050.228.camel@aeonflux>
Date: Thu, 20 Dec 2007 10:59:01 +0100
MIME-Version: 1.0
Subject: [Bluez-devel] Multi-device : maximizing the number of concurrent
	ourgoing RFCOMM connections
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi,

I am currently working on trying to have the maximum concurrent RFCOMM 
connections (OBEX) from a PC with several dongles to mobile phones. I use 
several BT dongles, usually 4. From a bluetooth point of view, the device is 
always master and the mobile slave.

I have big difficulties to define which is the best solution (Hardware, 
Kernel, BlueZ version).

I have developped a simple forking application which is opening concurrent 
sockets to remote mobiles and I record the connection status (success, 
failure) and the connection delay, and I am running it on several 
configurations in order to get the best results.

I am really interested in contacting people having the same concern, or 
trying to find the best solution as well.

Here are some of my questions :
- Hardware
    . which BT dongles do you prefer (I use class 1 dongles, 2.0 EDR with 
USB2.0 support) ?
    . do you use a USB2.0 hub or direct connection to the PC USB ports ?
- OS / BlueZ
    . which Kernel version / distro and BlueZ version would you use ?

Everyone interested don't hesitate to contact me ( olepogam@free.fr ) so we 
can share our experience.

Best regards,
Oli 


-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
