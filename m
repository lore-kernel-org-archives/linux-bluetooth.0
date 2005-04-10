Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <12a241ad050410073246654881@mail.gmail.com>
From: Bruno Abinader <brunoabinader@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: Re: [Bluez-users] How to create a shortcut for connecting to internet
In-Reply-To: <20050410141324.23307.qmail@webmail29.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20050410141324.23307.qmail@webmail29.rediffmail.com>
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
Date: Sun, 10 Apr 2005 10:32:28 -0400

bind 0... i think it only can be a "yes/no" answer, not "0/1", but i'm not sure!
 
>  Hi Marcel,
>  
>            Well i tried doing as u directed but it didnt seem to work.i
> guess i am making some mistake.Newa i am putting the contents of
> /etc/bluetooth/rfcomm.conf file below and also the console out i got after i
> restarted the bluetooth service. 
>  
>  
>  root@localhost ~]# cat /etc/bluetooth/rfcomm.conf
>  #
>  # RFCOMM configuration file.
>  #
>  # $Id: rfcomm.conf,v 1.1 2002/10/07 05:58:18 maxk Exp $
>  #
>  
>  #
>  # Example:
>  #
>  #rfcomm0 {
>  #      # Automatically bind the device at startup
>  #      bind no;
>  #
>  #      # Bluetooth address of the device
>  #      device 11:22:33:44:55:66;
>  #
>  #      # RFCOMM channel for the connection
>  #      channel 1;
>  #
>  #      # Description of the connection
>  #      comment "Example Bluetooth device";
>  #}
>  rfcomm0 {
>          bind 0;
>          device 00:0F:DE:86:2F:66;
>          channel  7;
>          }
>  [root@localhost ~]# service bluetooth restart
>  Stopping Bluetooth services:                              [  OK  ]
>  syntax error line 24ervices:                              [  OK  ]
>  
>  [root@localhost ~]#
>  
>  
>  Please Advice...?
>  
>  where do i put the init script....? am confused....
>  
>  Thanx..
>  
>  adil
-- 
Bruno de Oliveira Abinader
GVoIP - INdT/UFAM


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
