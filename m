Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45884188.1020000@gmail.com>
Date: Tue, 19 Dec 2006 16:46:16 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <be976db60612191123s62dfa67egc3c937e63ae2031@mail.gmail.com>
	<E34033EC-19D4-4112-A964-C656CA724290@gmail.com>
In-Reply-To: <E34033EC-19D4-4112-A964-C656CA724290@gmail.com>
Subject: Re: [Bluez-users] minicom over /dev/rfcomm0
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


>
> You sure can.
>
> You can of course use the code provided by Manuel too but then your  
> code won't work without rfcomm/bluetooth. The nice thing is that if  
> you keep it generic you can test your application using any old  
> serial connection. Or use a pipe in the filesystem etc..
>   
The idea with mine is that I needed to measure RSSI and wanted some 
control over the BlueZ Stack :D
> Caveat: I can't get mgetty to work by feeding it /dev/rfcommX though : 
> ( It should work, must be one of those things ;)
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>   


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
