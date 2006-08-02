Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44CFEF39.9000604@xmission.com>
Date: Tue, 01 Aug 2006 18:18:01 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <3837d8b10608010954l1cba6660g296de8379b2b8022@mail.gmail.com>
In-Reply-To: <3837d8b10608010954l1cba6660g296de8379b2b8022@mail.gmail.com>
Subject: Re: [Bluez-devel] Bluetooth Headset Error
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

keith

> I have been working to try and get a bluetooth headset to work
> preston@ubuntu:~/bluetooth/btsco$ sudo mpg123 --au - ~/music/throne.mp3
> | ./a2play 00:0D:44:6F:C4:50

you shouldn't have to use sudo fwiw

> Sample Rate:44100
> Channels:1

try something in stereo just in case we don't set things right for mono.

> received signal 8 from set
> unexpected headset directive 8

this is strange. I'm looking around p. 41 of the avdtp spec and this
might mean the headset wants to release or reconfigure the stream. I
can't find exactly which thing the 8 indicates.

> write failed: Connection reset by peer
> error while receiving 2

i'm not very good at reading the dump so i can't help much here. maybe
the set wants us to ack the directive 8 and hangs up on us when we fail
to do it.

brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
