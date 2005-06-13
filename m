Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BlueZ on ETRAX 100LX devboard 82+
From: Erwin Authried <eauth@softsys.co.at>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050610050635.82925.qmail@web52804.mail.yahoo.com>
References: <20050610050635.82925.qmail@web52804.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1118651555.25847.19.camel@justakiss>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 13 Jun 2005 10:32:35 +0200

Am Fre, den 10.06.2005 schrieb Naved Aziz um 7:06:
> Hi,
> 
> Basically, these are the steps that I am taking to set
> up an SP connection between the Axis board and the
> Nokia 6600:
> 
> (1) hcid
> (2) sdpd
> (3) hciconfig hci0 up #set up the bluetooth dongle
> (4) hcitool scan  #spot the phone, get the BD address
> (5) sdptool browse <BD address> #see services and 
>     their corrresponding channels
> (6) rfcomm connect /dev/rfcomm0 <BD address> <channel>
>     #where, if channel 2 is the one on nokia 6600    
>     providing serial port service, I put 2 for
> channel.   
>     The /dev/rfcomm0 is already created prior to 
>     flashing the image onto the board as follows:
>     mknod -m 0666 /dev/rfcomm0 c 216 0 
> 
> At this point, the phone gives a prompt, asking for a
> pin number.  The value in /etc/bluetooth/pin is 1234,
> and I have changed the pin_helper in hcid.conf to
> refer to a script file called qpin that looks like
> this:
> 
> #!/bin/sh
> #echo "PIN:1234"
> 
> This script file that I have created to work with the
> pin_helper is stored in the /tmp directory, since this
> is the only place where I am allowed to create any
> files, etc once an image has been downloaded onto the
> board. 
> 
> After I type in the pin on the Nokia 6600, there is a
> moment of wait, and then, the phone says "unable to
> connect", and the board says "can't create socket:
> resource temporarily unavailable".
> 
> You mentioned that the rfcomm utility creates a device
> that causes problems on some systems; how to get
> around this?
> 
> Thanks in advance for your help.
> 
> Naved
> 
are you sure that your board is able to save the link key? It is
normally stored in /etc/bluetooth/link_key. If your /etc is r/o, you
must make a symlink into a writeable directory.

Regards,
Erwin




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
