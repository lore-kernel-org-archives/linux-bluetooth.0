Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: How to emulate slave serial ports ?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20041110T103214-10@post.gmane.org>
References: <4190FB84.1040000@eidosspa.it>
	 <1100023997.6866.16.camel@pegasus>
	 <loom.20041110T091344-899@post.gmane.org>
	 <1100078284.25879.61.camel@pegasus>
	 <loom.20041110T103214-10@post.gmane.org>
Content-Type: text/plain
Message-Id: <1100080758.25879.66.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 10 Nov 2004 10:59:17 +0100

Hi Davide,

> Let me start from the outside.
> 
> The final result I want to obtain is:
> 
> From a PC running Windows (master):
> 1) I scan the bluetooth devices, and find one (or more) my linux devices
> 2) I pair the device with the correct PIN code
> 3) I browse the device's services and find one communication ports
> 4) I establish a Link with that comm port to a Windows virtual COMx port
> 5) I use the connected COMx port like any other "true" COMx port, sending
> inquiries and reading results in a proprietary format.
> Until now I succeeded in points 1) and 2)
> 
> From the target running linux 2.6.9 on an ARM9 (slave):
> 1) I run hciconfig
> 2) I start hcid
> 3) I start sdpd
> 4) My application opens /dev/rfcomm0 and keeps it opened
> 5) My application polls with read() on /dev/rfcomm0 for incoming messages

point 4 and 5 don't work this way on the server side, because you need
to listen on incoming connections first before you can use the device
node. What is the program on the ARM9 (slave) doing? I think you need to
rewrite it and add native RFCOMM support.

> Question 1:
> Is necessary to have on the target my application running with /dev/rfcomm0
> opened for the Windows PC to look at the exported serial port ?

No. You need to setup a service record for the serial port profile and
listen on incoming connection on the RFCOMM channel.

> Question 2:
> I setted up /usr/local/etc/bluetooth/pin and /usr/local/etc/bluetooth/hcid.conf
> for hcid, and it works OK. Does sdpd needs any configuration file ? Where is
> stored the sdpd configuration ? Where is stored the fact that I want to export
> one virtual serial port ?

The SDP records are runtime records.

> Question 3:
> If I run sdpd without any flags, it doesn't fork() because getppid()==1. Why ?
> Which is the correct mode of starting sdpd like a daemon ?

Maybe this is problem with your ARM platform or your compiler.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
