Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] what API to use to disconnect an rfcomm
	connection
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200412122338.11557.wim.delvaux@adaptiveplanet.com>
References: <200412110213.37305.wim.delvaux@adaptiveplanet.com>
	 <200412111314.05010.wim.delvaux@adaptiveplanet.com>
	 <1102768483.19086.21.camel@pegasus>
	 <200412122338.11557.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1102925490.8750.93.camel@pegasus>
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
Date: Mon, 13 Dec 2004 09:11:30 +0100

Hi Wim,

>  if I run the command rfcomm 0 xxxxx 1 under a linux shell,
>  the rfcomm program starts up and (if run in background) runs 
>  as a connection daemon between a device file /dev/xxx and a RFCOMM
>  connection to - say - a telephone.
> 
>  On top of that rfcomm device file (/dev/xxx) you can run a pppd and
>  hence create a GPRS connection over that phone.
> 
>  now suppose I want to disconnect from that GPRS connection.  First I need
>  to terminate the ppp connection.  This is easy : just kill pppd.
> 
>  Next I need to disconnect from the phone. I.e. terminate the serial 
> connection that the rfcomm daemon is managing.

you should use "rfcomm bind 0 ..." and simply open /dev/rfcomm0. If the
last user of /dev/rfcomm0 is gone and nobody else is using the ACL link
between these devices it will disconnect. These means kill the pppd
terminates the RFCOMM connection and in the end the ACL link.

>  I could kill the 'appropriate' rfcomm daemon.  However since the PAND
>  daemon serves a very similar purpose and you can call PAND with -k 
>  to terminate a certain NAP/PANU - BNEP connection without having
>  to kill that PAND I was wondering if there is a similar call for RFCOMM.
> 
>  The source for PAND shows that calling
> 
>   ioctl(ctl, bnepconndel, .... ) 
> 
>  terminates a certain BNEP connection.
> 
>  Does RFCOMM have a similar API e.g.
>   iotcl( ctl, rfcommconndel, ... ) ?

the BNEP and RFCOMM have actually nothing in common. Their design it
quite different. If you wan't something similar then you must play with
dund.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
