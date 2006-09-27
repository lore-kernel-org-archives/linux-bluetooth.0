Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3f5a9ba20609261815w6acd7ccex7e4d106a21956e75@mail.gmail.com>
References: <3f5a9ba20609252330p3d14854eu7b47acc600c28daf@mail.gmail.com>
	<1159259956.1235.3.camel@localhost>
	<3f5a9ba20609261815w6acd7ccex7e4d106a21956e75@mail.gmail.com>
Date: Wed, 27 Sep 2006 09:42:13 +0200
Message-Id: <1159342933.22162.6.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Can I search two services at the same time?
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

> My test device is Nokia E61 with bluetooth chip which 
> is from Texas Instrument Inc (13) 
> LMP version: 1.2 LMP subversion is 0xdb0

since you have the Nokia E61, can you please run "l2test -z <bdaddr>" as
root from the latest bluez-utils-3.5 package.

And take a "hcidump -X -V" from your application searching for the two
records. It might be possible that we have a bug in the library. How is
the CPS record support to look like. Use "sdptool search ..." with the
--raw switch.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
