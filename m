Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <456BCB6C.60908@xmission.com>
Date: Mon, 27 Nov 2006 22:38:52 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <456937F3.7090107@xmission.com>	<Pine.LNX.4.63.0611261450220.22808@redbean.intranet.gw-instruments.de>	<4569FD44.8050906@xmission.com>	<Pine.LNX.4.63.0611271115040.25903@redbean.intranet.gw-instruments.de>
	<456B1D40.8040703@xmission.com>
In-Reply-To: <456B1D40.8040703@xmission.com>
Subject: Re: [Bluez-devel] bccmd and usb/uart switching
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Guys

>> Because you can realy damage your device (if you don't have SPI access) 
>> Marcel implemented bccmd "save". You realy should know what you're doing 
>> when using bccmd to change ps-keys on CSR chips.  
> 
> thanks for your help! I've decided it is too easy to get things wrong. I
> am going to rewire things so I can have both usb and uart connected,
> then make the pskey change in ram and softboot into uart mode.

fwiw, it worked great to try pskey values out in ram before making them 
permanent.

http://bluetooth-alsa.sourceforge.net/embed.html

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
