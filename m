Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1109692593.422490b17bafe@mail.orbitel.bg>
From: Todor Todorov <dr_doom@engineer.bg>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BNEP connection destroing :(
References: <1109664374.42242276c644b@mail.orbitel.bg> <1109691651.42248d0394218@mail.orbitel.bg>
In-Reply-To: <1109691651.42248d0394218@mail.orbitel.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
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
Date: Tue,  1 Mar 2005 17:56:33 +0200

I forgot to say that i sharing my internet connection on windows machine with proxy (CC Proxy 6.0).
Also when i try to transfer one file up to 50MB, and connection was destroyed after nearly 20MB transfer, but when 
i re-plug the dongle and reconnect again the whole 50MB file was transfered. I tried also to ping the desktop PC with 
ping 60k and the connection whas imìediately destroyed. This i fix(i think so) with this "hcitool lst 00:10:60:A6:1C:
30 0"
This is tried also when i use windows on the laptop and desktop, and there isn't problem.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
