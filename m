Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <dcbc35340702131508m11f35e92hb912ccc1a3d087a0@mail.gmail.com>
References: <dcbc35340702131508m11f35e92hb912ccc1a3d087a0@mail.gmail.com>
Date: Wed, 14 Feb 2007 09:39:38 +0100
Message-Id: <1171442378.14869.1.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] help installing bluez 3.9
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Paulo,

> I just installed bluez 3.9 (patched the kernel and build the modules,
> installed bluez-libs-3.9 and bluez-utils-3.9) 
> but i can't find the script to start|stop|restart the service
> (/etc/init.d/bluetooth).
> Where can I find it ?

by default they are not installed since all distributions provide their
own. Check "./configure --help" for the correct option.
 
> After i finish the instalation i checked that the modules ware loaded:
> root@xxxx:~/bluez-utils-3.9# lsmod
> Module                  Size  Used by    Not tainted
> bnep                    8020   0  (autoclean)
> l2cap                  15120   0  (autoclean) [bnep] 
> hci_usb                 8376   0  (unused)
> bluez                  27812   1  [bnep l2cap hci_usb]
>  
> so i run hciconfig:
> root@xxxx:/etc/bluetooth# /usr/sbin/hciconfig -a    
> hci0:   Type: USB
>  BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
>  DOWN 
>  RX bytes:0 acl:0 sco:0 events:0 errors:0 
>  TX bytes:0 acl:0 sco:0 commands:0 errors:0
>  
> but where is the BD Address ?
> and all the other data that i saw in some examples

You have to run "hcid" to bring up the adapter.
 
> then i run the pan daemon:
> root@dell:/etc/bluetooth# pand -s -M --role=NAP -n
> pand[18321]: Bluetooth PAN daemon version 3.9
> pand[18321]: Failed to connect to the local SDP server. No such file
> or directory(2)
>  
> is this error normal ?

You either have to start sdpd or tell hcid with the -s option to act as
SDP server.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
