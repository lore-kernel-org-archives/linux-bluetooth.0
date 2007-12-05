Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200712051601.03309.denis.kenzior@trolltech.com>
References: <20071204232538.GA23003@wavehammer.waldi.eu.org>
	<200712051601.03309.denis.kenzior@trolltech.com>
Date: Wed, 05 Dec 2007 08:28:02 +0100
Message-Id: <1196839682.12292.159.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Possible Race condition in Rfcomm TTY
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

Hi Denis,

> I think there is a race condition in the RFCOMM Socket -> TTY adaptation.  
> Basically whenever a client device connects and starts sending data right 
> away, the serial port will not receive it.
> 
> To see what I mean:
> 
> run 'rfcomm -r listen 0 15' on a server.
> 
> and run a simple test app that sends data right after connecting (one 
> attached).
> 
> Once connection has been established, run 'cat /dev/rfcomm0' 
> 
> Using my Suse 10.2 desktop with kernel 2.6.18.8 and Neo with kernel 2.6.22.5 
> (Nov 26 snapshot), about 95% of the time the initial data sent never shows up 
> on the serial port.  If I reverse the roles, the desktop usually gets the 
> initial chunk of data.  This inconsistency makes it hard to implement 
> something like the DUN or Handsfree services where clients very frequently 
> send data right away.

I am not a big fan of the TTY support at all. It had more problems in
the end than we ever expected. Using the socket directly is always the
better approach.

For Handsfree, I would prefer if the audio service will be extended and
that is what is currently planned. For DUN you can use the serial
service proxy feature. This can directly attach to a physical TTY or to
a Unix socket.

> Looking at the kernel code it seems that the data is copied into the socket 
> buf or into the serial buf from the rfcomm_recv_data.  It also seems that 
> rfcomm_dev_add never copies what is in the socket buffer to what is in the 
> serial buffer.  It would seem that rfomm_dev_add should also copy any pending 
> data from a socket read buffer to the serial port read buffer whenever doing 
> the conversion.  Or is there something else going on here?

No. That is probably it. Feel free to send a patch.

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
