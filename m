Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hcitool scan gives timeout on an ipaq 5500
From: Marcel Holtmann <marcel@holtmann.org>
To: filipe abrantes <fla@inescporto.pt>
Cc: bluez-users@lists.sourceforge.net, filipe_abrantes@netcabo.pt
In-Reply-To: <47EFEB1E.7010903@inescn.pt>
References: <47EFEB1E.7010903@inescn.pt>
Content-Type: text/plain
Message-Id: <1096373451.4649.3.camel@notepaq>
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
Date: Tue, 28 Sep 2004 14:10:56 +0200

Hi Filipe,

> ive been using bluez on an ipaq, but im having some problems:
> 
> how i set up bt on ipaq:
> 
> # uname -r
> 2.4.19-rmk6-pxa1-hh36
> # pand
> PAN daemon version 1.1rc2
> ..
> # hcitool
> hcitool - HCI Tool ver 2.2
> # hcid --version
> hcid: invalid option -- -
> hcid - HCI daemon ver 2.3
> 
> #hciattach /dev/tts/1 any 921600
> # hciconfig
> hci0:   Type: UART
>         BD Address: 08:00:17:1F:C5:E4 ACL MTU: 339:4  SCO MTU: 60:9
>         UP RUNNING PSCAN ISCAN
>         RX bytes:88 acl:0 sco:0 events:11 errors:1
>         TX bytes:652 acl:0 sco:0 commands:25 errors:0
> 
> ... and the hcid.conf files are similar on both the ipaq and my pc
> 
> 
> 
> when i try hcitool scan on ipaq:
> 
> # hcitool scan
> Scanning ...
> Inquiry failed.: Connection timed out
> 
> when i try on my pc:
> 
> # hcitool scan
> Scanning ...
>         08:00:17:1F:C5:E4       ipaq
> 
> then when i put my pc on: pand --listen --role GN
> ...and try to connect: pand --connect 00:10:60:A4:89:15 (on the ipaq side)
> 
> it doesn t establish connection.
> 
> but on the other end if i try  to switch roles, the pc can connect to 
> the ipaq  (the ipaq is now GN)  then it works out ok.

run hcidump -x as root on the iPAQ side to see what is going on.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
