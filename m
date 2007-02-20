Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45DB87B6.60100@xmission.com>
Date: Tue, 20 Feb 2007 16:43:50 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <5b9417770702181902v287f5d44uc513b4d8bc8f1a79@mail.gmail.com>	<45D91EC2.5000201@xmission.com>	<5b9417770702191013x63a8ebfdu7cefaf3e781b0f86@mail.gmail.com>	<45DA6241.8030507@xmission.com>
	<5b9417770702200044k290111f0m880d009c17f6f577@mail.gmail.com>
In-Reply-To: <5b9417770702200044k290111f0m880d009c17f6f577@mail.gmail.com>
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

> I am using the moto Q with sprint, and pdanet.  It doesn't work
> without pdanet, and pdanet also lets me use it without using the modem
> plan.  Is it the pdanet software that may be limiting bandwidth?

>>>well, when using pdanet's software in xp and usb connection, i got over 800kb/s
>>>when using bt dun in XP, i got 160kb/s

With the experiment with xp, you've basically isolated the bt dun
problem to be in the pocketpc stack. So you should start posting on the
pocketpc forums to see where that problem is.

On the linux side, you could try out PAN if you have a way for the Q to
serve internet using pan. I am very interested to know if this works any
better.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
