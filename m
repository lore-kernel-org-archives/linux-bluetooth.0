Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Kamil =?UTF-8?Q?Kami=C5=84ski?= <kamilkaminski@1liceum.pl>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200607171807.03528.kamilkaminski@1liceum.pl>
References: <200607171807.03528.kamilkaminski@1liceum.pl>
Date: Tue, 18 Jul 2006 12:55:14 +0200
Message-Id: <1153220114.4639.19.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Bluex 3.x pairing devices
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

Hi Kamil,

> Maybe this question is stupid, but.. how to pair devices using blueZ 3.x (have 
> latest) and kde 3.5.x (svn)? Since I have installed 3.x I cannot pair devices 
> anymore. My friend hace the same problem, but he simply deletes keyfile and 
> other made by hcid and then pairing works (once)... I cannot :/ Is there my 
> problem or something with kde / blueZ? :>

show us the output of "hcidump -X -V" when the pairing fails.

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
