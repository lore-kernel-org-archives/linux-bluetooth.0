Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] L2CAP connectionless
From: Marcel Holtmann <marcel@holtmann.org>
To: "Desai, Keyur Rajnikant" <kdesai@mail.smu.edu>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <38F76B90B82C0A4A822651EACE4FF8E9C23322@s31xs2>
References: <38F76B90B82C0A4A822651EACE4FF8E9C23322@s31xs2>
Content-Type: text/plain
Message-Id: <1076922085.2840.46.camel@pegasus>
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
Date: Mon, 16 Feb 2004 10:01:25 +0100

Hi Desai,

> I am  just wondering how L2CAP connectionless mode works
>  
> when i do a ./l2test -s -D BD_ADDR it has to use the connect method.
>  
> Also when the -D option causes the socket to be set to SOCK_DGRAM  I cannot understand what the 
> handler (s) function does
>  
> I tried to single step using xxgdb but it would always skip the handler(s) function.

no comments from me, because I never worked with L2CAP connectionless
sockets. There was some discussion about it on the mailing list, so I
think you should go through the archive.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
