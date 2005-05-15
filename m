Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42876108.7040106@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <20050515145042.70745815.tobias-lang@gmx.de>
In-Reply-To: <20050515145042.70745815.tobias-lang@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: [Bluez-users] Hama BT1000 Headset Problems
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
Date: Sun, 15 May 2005 08:47:36 -0600

Tobias

>>: hciconfig hci0 revision
> 
> 	hci0:   Type: USB
>  	       BD Address: 00:0B:0D:04:BB:98 ACL MTU: 120:20 SCO MTU: 64:0
>   	      Unsupported manufacturer

the docs now state that if you don't see SCO mapping info at all, you 
may need a different (CSR) adapter.

the fact that the adapter can pass data to your phone doesn't 
necessarily mean it's able to pass SCO audio properly.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
