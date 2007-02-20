Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45DA6241.8030507@xmission.com>
Date: Mon, 19 Feb 2007 19:51:45 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <5b9417770702181902v287f5d44uc513b4d8bc8f1a79@mail.gmail.com>	<45D91EC2.5000201@xmission.com>
	<5b9417770702191013x63a8ebfdu7cefaf3e781b0f86@mail.gmail.com>
In-Reply-To: <5b9417770702191013x63a8ebfdu7cefaf3e781b0f86@mail.gmail.com>
Subject: Re: [Bluez-devel] if using bluetooth DUN,
	how to get best performance?
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

John

> well, when using pdanet's software in xp and usb connection, i got over 800kb/s
> when using bt dun in XP, i got 160kb/s
> 
> I am assuming it was roughly the same speed in linux DUN.  I don't see
> them fixing their software itself to run on linux any time soon, so i
> am probably stuck with BT DUN as opposed to USB dun in linux, so i was
> wondering if there was anything i could do.

which phone are you using? do you use pdanet for bt dun or a native dun
service?

in my experience, pocketpc runs bt dun nowhere near the bluetooth
bandwidth ceiling. It probably doesn't make any difference if you find a
phone with bt2.0+edr. Their performance just stinks. The numbers you
mention are not surprising.

sometimes it crosses the line from poor performance to simply buggy. I
was consistently locking up the sprint 6700 when using a linux dun
client. I'm not sure if there's anything we can do from bluez to help
the situation. I took the phone back.

brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
