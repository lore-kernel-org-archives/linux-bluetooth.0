Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Setting up an hotplug connection with USB dongles
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200501021451.09711.rdorsch@web.de>
References: <200411282132.37941.rdorsch@web.de>
	 <200412232343.45609.rdorsch@web.de> <1103889889.20258.82.camel@pegasus>
	 <200501021451.09711.rdorsch@web.de>
Content-Type: text/plain
Message-Id: <1104674297.8894.3.camel@pegasus>
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
Date: Sun, 02 Jan 2005 14:58:17 +0100

Hi Rainer,

> > add a line with "auto bnep0" and it will bring up your interface when it
> > is available.
> 
> From man interfaces
> 
> Stanzas beginning with the word "auto" are used to identify the physical 
> interfaces to be brought up when ifup is run with the -a option.  (This
> option  is  used  by  the system boot scripts.)  Physical interface names 
> should follow the word "auto" on the same line.  There can be multiple
> "auto" stanzas.  ifup brings the named interfaces up in the order listed.
> 
> From the ifup manpage
> 
>       -a, --all
>               If given to ifup, affect all interfaces marked auto.  Interfaces 
> are brought up in the order in  which  they  are  defined  in  /etc/net-
>               work/interfaces.  If given to ifdown, affect all interfaces.  
> Interfaces are brought down in the order in which they are currently listed
>               in the state file.

if you use "auto bnep0" and hotplug is configured to deal also with the
network interface then bnep0 will be brought up at the time the kernel
created it. No need to run ifup/ifdown manually.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
