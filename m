Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hidd --server only finding one device
From: Marcel Holtmann <marcel@holtmann.org>
To: Jon Valvatne <jon@valvatne.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1087507199.3103.27.camel@localhost.localdomain>
References: <1087496559.3103.11.camel@localhost.localdomain>
	 <1087504160.4309.78.camel@pegasus>
	 <1087507199.3103.27.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1087510775.4309.86.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 18 Jun 2004 00:19:36 +0200

Hi Jon,

> > do you've activated the role switch support on your host device?
> 
> I believe so:
> 
> # hciconfig hci0 lm
> hci0:   Type: PCCARD
>         BD Address: 00:E0:03:25:3E:29 ACL MTU: 340:4  SCO MTU: 64:0
>         Link mode: ACCEPT MASTER 
> # hciconfig hci0 lp
> hci0:   Type: PCCARD
>         BD Address: 00:E0:03:25:3E:29 ACL MTU: 340:4  SCO MTU: 64:0
>         Link policy: RSWITCH HOLD SNIFF PARK 

show us the output of "hciconfig -a".

> # hidd --server --nodaemon
> hidd[6666]: Bluetooth HID daemon
> hidd[6666]: New HID device 00:07:61:1A:78:E2 (Logitech Bluetooth Mouse)
> 
> ... and then nothing when I try to use the keyboard. Is there something
> I've overlooked regarding the role-switch stuff?
> 
> I've done some simple debugging in hidd's main.c, which so far only
> reveals that the poll() call in run_server() fails to produce any new
> events once the first create_device() call has been made. The problem
> doesn't appear to be caused inside hidd itself though, because killing
> and restarting it after it's established the connection to the first
> device doesn't help it discover the second one.
> 
> Any pointers to where else I might look for the bug? I'm afraid I don't
> really know my way around BlueZ internals.

Check with "hcidump -x" what happens when you press a button of your
second device.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
