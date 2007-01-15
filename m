Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Robert Huitl <bluez-devel@huitl.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Mon, 15 Jan 2007 19:09:38 +0100
References: <200701150257.21542.bluez-devel@huitl.de>
	<45AB5679.8050606@palmsource.com>
In-Reply-To: <45AB5679.8050606@palmsource.com>
MIME-Version: 1.0
Message-Id: <200701151909.39305.bluez-devel@huitl.de>
Subject: Re: [Bluez-devel] a2dpd: audio connection breaks every 300 seconds
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Fr=E9d=E9ric,

> Do you have another program using BlueZ?

That's it! Some program is periodically scanning for bluetooth devices. Whe=
n I =

run "hcitool scan" manually, I immediately get the choking sound and the =

write() call fails.

I will have to investigate what program is the culprit here. hcid and =

kde-bluetooth come to my mind.

On the other hand, why is a scan able to interfere with communication? Is t=
his =

behavior by design (because the hardware can only either scan or send/recei=
ve =

data)?

Regards,
  Robert

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
