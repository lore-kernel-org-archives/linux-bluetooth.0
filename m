Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <200409281319.i8SDJkQt011868@news01.csr.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] ipaq 1945 
In-reply-to: <320075ff04092805251ce925e6@mail.gmail.com> 
References: <320075ff040925153753850d92@mail.gmail.com> <1096153758.7719.12.camel@pegasus> <320075ff040926011212538dac@mail.gmail.com> <003001c4a3ba$d064fba0$8696a8c0@marcy> <320075ff0409270050bbaf228@mail.gmail.com> <1096371841.4950.5.camel@notepaq> <320075ff04092805251ce925e6@mail.gmail.com>
From: Peter Stephenson <pws@csr.com>
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
Date: Tue, 28 Sep 2004 14:19:45 +0100

Nigel Magnay wrote:
> I had thought I could bridge the interfaces, but I have tried lots of
> things like
> brctl addbr br0
>  brctl addif br0 eth0
>  brctl addif br0 bnep0
> 
> but that just leads to aggravating things like the linux box dropping
> off the network altogether ..

The particular problem I had when I tried this a while ago now was that
you need to be careful to use br0 as the interface anywhere you would
normally use eth0 or bnep0.  So for example if you're using DHCP you
need to run it on br0 to give the IP address to that, or packets won't
get routed properly (the Ethernet and IP routes aren't consistent).  And
so on.

This may be completely irrelevant and my memory is a bit faded.

pws


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
