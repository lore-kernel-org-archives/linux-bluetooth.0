Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050324215110.15524.qmail@web50710.mail.yahoo.com>
From: "John H." <mistamaila@yahoo.com>
Subject: Re: [Bluez-users] cannot connect to pm-325
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Thu, 24 Mar 2005 13:51:10 -0800 (PST)

 hcitool scan
Scanning ...
        08:00:37:12:C4:B1       PM325 by LG
[root@laptop user]# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.18
device: hci0 snap_len: 1028 filter: 0xffffffff




--- Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi John,
> 
> >  Not been prompted to enter pin, keep getting 
> >  
> >  Can't connect RFCOMM socket: Connection refused
> >  
> >  despite scan finding the device.
> >  
> >  put those lm and lp entries in hcid.conf, and
> even
> >  tried(afterward)putting the following in
> rfcomm.conf
> >  
> >  rfcomm0 {
> >  bind no;
> >  device    08:00:37:12:C4:B1;
> >  channel   1;
> >  comment   "PM325 by LG";
> >  }
> >  
> > 
> >  any ideas?
> 
> run "hcidump -X -V" as root and show the output to
> us.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> This SF.net email is sponsored by Microsoft Mobile &
> Embedded DevCon 2005
> Attend MEDC 2005 May 9-12 in Vegas. Learn more about
> the latest Windows
> Embedded(r) & Windows Mobile(tm) platforms,
> applications & content.  Register
> by 3/29 & save $300
>
http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
