Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] how to use more than one dongle at the same time
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20060130144942.84846.qmail@web53105.mail.yahoo.com>
References: <20060130144942.84846.qmail@web53105.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1139310950.15160.17.camel@localhost>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 07 Feb 2006 12:15:50 +0100

Hi,

> I've been working around trying to use two ore more
> usb dongles at the same time ,(by the way I could send
> files from one dongle at the same time to more than
> one cellphones.)
> as usual i start command line tool to witch i give the
> address of one dongle
> and in another konsole i start another programm using
> the other dongle.
> Both programs are used to send different files from
> different dongles.
> 
> the way i bind the socket I use is this.
> 
>         struct sockaddr_rc addr={0},laddr={0};
>         s = socket(AF_BLUETOOTH, SOCK_STREAM,
> BTPROTO_RFCOMM);
> 
>         addr.rc_family = AF_BLUETOOTH;
>    	addr.rc_channel = port ; //remote port
>     	str2ba( remote_addr, &addr.rc_bdaddr );
> 	
> 	laddr.rc_family = AF_BLUETOOTH;
> 	laddr.rc_channel=0; //local
>     	str2ba( local_addr, &laddr.rc_bdaddr );
>         
>         bind(s, (struct sockaddr*)sockaddr,
> sizeof(laddr));
>          
>         connect(s, (struct sockaddr *)&addr,
> sizeof(addr));
>         ......
>          recv();
>          send();
>          .....
>         close(s);
> 
> here remote_addr and local_addr are the string
> representation of local and remote device addresses
> given to the programm from the command line.
> 
> when one of the programs is working(sending and
> recieving data)
> i start the other one and after the first packet is
> sent or the connection is made it all stops and both
> the connections remains open.
> I checked and i am the master in both cases.
> 
> Is this normal?
> why i can't use them concurrently.

in general this should work. However start using hcidump to debug this
and then send in more details.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
