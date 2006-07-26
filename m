Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <78338BC4EB35DC488A56F870C94161F1331D92@si-cmn1.coind.dom>
References: <78338BC4EB35DC488A56F870C94161F1331D92@si-cmn1.coind.dom>
Date: Wed, 26 Jul 2006 09:25:32 +0200
Message-Id: <1153898732.746.13.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] ARM-linux and multiple USB dongles
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

Hi Francesco,

> I'm facing this problem on ARM-linux (2.4.26) and 2 USB dongles on a
> TS-7200 SBC by technologic systems.
>  
> When I plug the 1st dongle, it is correctly initialized and it works
> okay.
> When I plug the 2nd one, it is regognized but I can't get it working:
> hciconfig hc1 up returns timeout(110).
>  
> If I unplug hci0 (the first dongle) then hci1 starts working.
>  
> I have been trying this with different dongles & different chipsets
> but I still get the same results.
> On the development machine (i86 with same Kernel version) everything
> works ok.
>  
> At the beginning I thought this might be some problem with USB support
> on the board. But I have been able to operate up to 7 simultaneous USB
> devices on the board (not bluetooth) and they work ok.
>  
> Are there any known issues about multiple devices and ARM? 

no, they are working perfectly. Why don't you try to use a recent 2.6
kernel on your system. Sticking to 2.4 is not a good idea at all.

Regards

Marcel




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
