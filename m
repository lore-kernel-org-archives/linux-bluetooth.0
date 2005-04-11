Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <12a241ad050411052075fe55ff@mail.gmail.com>
From: Bruno Abinader <brunoabinader@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: Re: Re: [Bluez-users] How to create a shortcut for connecting to internet
In-Reply-To: <20050410194827.23674.qmail@webmail47.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20050410194827.23674.qmail@webmail47.rediffmail.com>
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
Date: Mon, 11 Apr 2005 12:20:16 +0000

Well, there are a lot of ways, but the 2 that i use most to kill
processes are (notice that both are console commands):

1. killall <name_of_the_program> or
2. ps ax | grep <name_of_the_program>
    kill -KILL <program_PID>

On 10 Apr 2005 19:48:27 -0000, adil  fulara <talk2me_adil@rediffmail.com> wrote:
> 
> 
>    Hey Bruno,
>  
>              You are right. i was treating it as bind no. (bind Number), so
> i was always typing bind 0. neways just tried it out. it works. Thanx alot
> to u and marcel i have created a shortcut which fires this command and i get
> connected. How do i disconnect....?
>  
>  I guess i will have to use KDE System Guard(ctrl+alt+delete) to kill the
> wvdial process. Any other ways of doing it....?
>  
>  Thanx alot folks....!!
>  
>  Cheerio
>  
>  Adil.
>  
>  
>  On Sun, 10 Apr 2005 Bruno Abinader wrote :
> 
>  >bind 0... i think it only can be a "yes/no" answer, not "0/1", but i'm not
> sure!
>  >
>  > >  Hi Marcel,
>  > >
>  > >            Well i tried doing as u directed but it didnt seem to work.i
>  > > guess i am making some mistake.Newa i am putting the contents of
>  > > /etc/bluetooth/rfcomm.conf file below and also the console out i got
> after i
>  > > restarted the bluetooth service.
>  > >
>  > >
>  > >  root@localhost ~]# cat /etc/bluetooth/rfcomm.conf
>  > >  #
>  > >  # RFCOMM configuration file.
>  > >  #
>  > >  # $Id: rfcomm.conf,v 1.1 2002/10/07 05:58:18 maxk Exp $
>  > >  #
>  > >
>  > >  #
>  > >  # Example:
>  > >  #
>  > >  #rfcomm0 {
>  > >  #      # Automatically bind the device at startup
>  > >  #      bind no;
>  > >  #
>  > >  #      # Bluetooth address of the device
>  > >  #      device 11:22:33:44:55:66;
>  > >  #
>  > >  #      # RFCOMM channel for the connection
>  > >  #      channel 1;
>  > >  #
>  > >  #      # Description of the connection
>  > >  #      comment "Example Bluetooth device";
>  > >  #}
>  > >  rfcomm0 {
>  > >          bind 0;
>  > >          device 00:0F:DE:86:2F:66;
>  > >          channel  7;
>  > >          }
>  > >  [root@localhost ~]# service bluetooth restart
>  > >  Stopping Bluetooth services:                              [  OK  ]
>  > >  syntax error line 24ervices:                              [  OK  ]
>  > >
>  > >  [root@localhost ~]#
>  > >
>  > >
>  > >  Please Advice...?
>  > >
>  > >  where do i put the init script....? am confused....
>  > >
>  > >  Thanx..
>  > >
>  > >  adil
>  >--
>  >Bruno de Oliveira Abinader
>  >GVoIP - INdT/UFAM
>  >
>  >
>  >-------------------------------------------------------
>  >SF email is sponsored by - The IT Product Guide
>  >Read honest & candid reviews on hundreds of IT Products from real users.
>  >Discover which products truly live up to the hype. Start reading now.
>  >http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
>  >_______________________________________________
>  >Bluez-users mailing list
>  >Bluez-users@lists.sourceforge.net
>  >https://lists.sourceforge.net/lists/listinfo/bluez-users

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
