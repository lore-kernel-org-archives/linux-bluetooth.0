Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Davide Rizzo <rizzo@eidosspa.it>
Message-ID: <loom.20041110T103214-10@post.gmane.org>
References: <4190FB84.1040000@eidosspa.it>  <1100023997.6866.16.camel@pegasus>  <loom.20041110T091344-899@post.gmane.org> <1100078284.25879.61.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: How to emulate slave serial ports ?
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
Date: Wed, 10 Nov 2004 09:51:35 +0000 (UTC)

Marcel Holtmann <marcel <at> holtmann.org> writes:

> 
> Hi Davide,
> 
> > On the linux machine now I have a program that opens the serial device (and
> > keeps it opened), periodically polls it for incoming requests, and eventually
> > responds to the requests.
> 
> I don't understand this. Show me that program.
> 
> > I wish to substitute this physical RS232 line with a bluetooth connection,
> > without changing the Windows software on the PC (and the software on the
> > target), except for the device names. Is it possible ?
> 
> It is possible, but I still don't know what you really wanna do. Replace
> some serial port is not a detailed description.
> 
> > Which bluez tools should I run on the init script ?
> 
> Besides hcid and sdpd, nothing more. But you must write a program that
> accepts connections on RFCOMM and that also registers a service record
> for your serial port.
> 
> Regards
> 
> Marcel
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
> 

Hi Marcel,

Let me start from the outside.

The final result I want to obtain is:

>From a PC running Windows (master):
1) I scan the bluetooth devices, and find one (or more) my linux devices
2) I pair the device with the correct PIN code
3) I browse the device's services and find one communication ports
4) I establish a Link with that comm port to a Windows virtual COMx port
5) I use the connected COMx port like any other "true" COMx port, sending
inquiries and reading results in a proprietary format.
Until now I succeeded in points 1) and 2)

>From the target running linux 2.6.9 on an ARM9 (slave):
1) I run hciconfig
2) I start hcid
3) I start sdpd
4) My application opens /dev/rfcomm0 and keeps it opened
5) My application polls with read() on /dev/rfcomm0 for incoming messages

Question 1:
Is necessary to have on the target my application running with /dev/rfcomm0
opened for the Windows PC to look at the exported serial port ?

Question 2:
I setted up /usr/local/etc/bluetooth/pin and /usr/local/etc/bluetooth/hcid.conf
for hcid, and it works OK. Does sdpd needs any configuration file ? Where is
stored the sdpd configuration ? Where is stored the fact that I want to export
one virtual serial port ?

Question 3:
If I run sdpd without any flags, it doesn't fork() because getppid()==1. Why ?
Which is the correct mode of starting sdpd like a daemon ?

Thanks

Davide



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
