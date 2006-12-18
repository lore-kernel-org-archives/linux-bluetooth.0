Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Fernando Unzu <fernando@bluexare.org>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 18 Dec 2006 14:12:11 +0100
MIME-Version: 1.0
Message-Id: <200612181412.12059.fernando@bluexare.org>
Subject: [Bluez-devel] About the process that listen...
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

Hi,
I'm a developper from other project that works with Bluetooth.
We are making a software that can send datas to other devices, like mobiles.

But sometimes, our device does not detect the mobile, what it means, the sent
is not realized.

And we want to do the possibility taht each mobile, by requesting the device
the information, it sends.

We don't know which process works listening the transmissions from other
devices...

If the mobile try to associate the device, what does daemon treat that?
And if the mobile try t send an mage (for example), is another daemon who
treat this?

I hope you understand me.

What we want is when our device detect an incoming transmission (a try to
associate, or to send an image...) from one mobile, it sends what we have
prepared to be send.

Tanks you very much.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
