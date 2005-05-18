Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problems syncing with bluetooth on multisync:
	evolution/blueotooth plugin
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1116417991.10287.4.camel@linux.site>
References: <1116313073.10074.8.camel@linux.site>
	 <4289A32A.1040907@citromail.hu>  <1116327973.21185.1.camel@linux.site>
	 <1116329361.10063.44.camel@pegasus>  <1116333932.32701.4.camel@linux.site>
	 <1116334551.10063.83.camel@pegasus>  <1116359055.8933.6.camel@linux.site>
	 <1116366743.10063.122.camel@pegasus>  <1116403397.13203.4.camel@linux.site>
	 <1116407190.10063.181.camel@pegasus> <1116413370.22668.13.camel@linux.site>
	 <1116414457.10063.216.camel@pegasus>  <1116417991.10287.4.camel@linux.site>
Content-Type: text/plain
Message-Id: <1116418487.10063.236.camel@pegasus>
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
Date: Wed, 18 May 2005 14:14:47 +0200

Hi Tamer,

> However, do you have any idea how SyncML works?! I mean, if the mobile
> phone has a SyncMLCient. Right?! Multisync has either a syncml plugin.
> What I am asking myself is, if the client acts the same way as a server
> does with login and password. That is, what would interist me. If it is
> the case, we could connect the cell phone mac address with a ipaddress
> and sync instead with the SyncML client. 

check out www.syncml.org and look at its transports. You can do it over
TCP/IP and over OBEX. You phone however rejects connections to the
SyncML over OBEX channel and this looks wrong to me.

> I think I will read about it a bit. Writing a SyncML mobile phone plugin
> can't be that big hit. 

Work with OpenSync guys on it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
