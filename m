Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BCSP problem
From: Erwin Authried <eauth@softsys.co.at>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY104-F11D4725B89F5B0701A79B8C18B0@phx.gbl>
References: <BAY104-F11D4725B89F5B0701A79B8C18B0@phx.gbl>
Content-Type: text/plain
Message-Id: <1105700391.17326.32.camel@justakiss>
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
Date: Fri, 14 Jan 2005 11:59:51 +0100

Am Fre, den 14.01.2005 schrieb blookk - um 10:03:
> Hello Erwin:
> 
> What changes have you done in hci_bcsp.c?
> Could be the error in wait_states in serial driver?
> 
> I change the timeout to 1 HZ but the problem continue.
> 
> Regards.
Hi,
I have posted the patch some time ago. 

http://sourceforge.net/mailarchive/message.php?msg_id=9908045

Be aware that it is incomplete, it doesn't support packets with CRC. The
patch is only useful when the incoming data rate from the uart is higher
than the processing speed in the hci line discipline. What kind of
machine (cpu speed?) do you use?

Regards,
Erwin






-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
