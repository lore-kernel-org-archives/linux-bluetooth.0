Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez PAN (bnep) Supports IP Multicast ?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
Cc: Heejune AHN <heejune@snut.ac.kr>
In-Reply-To: <001901c5ac8b$7bf71870$650ba8c0@heejune>
References: <4dfd570904122402134ec2fd32@mail.gmail.com>
	 <BAY104-F28B10D34C6CA29EC4D37E9C1A70@phx.gbl>
	 <4dfd5709041225041648e1f356@mail.gmail.com>
	 <1103980205.8758.22.camel@pegasus>
	 <4dfd570904122505192221bf97@mail.gmail.com>
	 <001201c5ac65$73bba980$0107a8c0@heejune> <1125308614.25073.8.camel@blade>
	 <001901c5ac8b$7bf71870$650ba8c0@heejune>
Content-Type: text/plain
Message-Id: <1125315052.17698.11.camel@pegasus>
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
Date: Mon, 29 Aug 2005 13:30:52 +0200

Hi Heejune,

> Then you mean  no one can use multicast ip address with kernel 2.4.20-8 and lib-2.3?
> Is it not my fault of using bluez utilities?
> 
> And kernel 2.6 supports multicast stuff? I have to check it.

you should at least check. I remember some patches for the BNEP filter
stuff that only were applied to the 2.6 kernels. The Bluetooth support
for 2.4 kernels is deprecated. However there can be still a bug hidden
somewhere.

> BTW, the reason why I am using old ones is because my chip maker still provides their evaluation board with kernel 2.4.x instead of 2.6.x since so many drivers still works more smoothly with 2.4.x 

Don't get me started on the stupid chip manufactures. They are simply
too lazy to move to 2.6 even if most of their chips will work out of the
box. The Linux 2.4 series is way outdated and so no excuse.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
