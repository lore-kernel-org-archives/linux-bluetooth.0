Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Kamil =?UTF-8?Q?Kami=C5=84ski?= <kamilkaminski@1liceum.pl>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200607181639.36560.kamilkaminski@1liceum.pl>
References: <200607171807.03528.kamilkaminski@1liceum.pl>
	<1153220114.4639.19.camel@localhost>
	<200607181639.36560.kamilkaminski@1liceum.pl>
Date: Tue, 18 Jul 2006 19:14:02 +0200
Message-Id: <1153242842.21024.19.camel@localhost>
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

> > > Maybe this question is stupid, but.. how to pair devices using blueZ 3.x
> > > (have latest) and kde 3.5.x (svn)? Since I have installed 3.x I cannot
> > > pair devices anymore. My friend hace the same problem, but he simply
> > > deletes keyfile and other made by hcid and then pairing works (once)... I
> > > cannot :/ Is there my problem or something with kde / blueZ? :>
> >
> > show us the output of "hcidump -X -V" when the pairing fails.
> 
> Here it is :-) :
> --------------------------------------------------------------------------------------------------
> 
> > HCI Event: PIN Code Request (0x16) plen 6
>     bdaddr 00:0F:DE:EB:B6:D4
> < HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
>     bdaddr 00:0F:DE:EB:B6:D4
> > HCI Event: Command Complete (0x0e) plen 10
>     PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
>     status 0x00 bdaddr 00:0F:DE:EB:B6:D4

this means that now passkey agent has been installed. The bluez-utils
source code contains a sample passkey-agent that can be used to provide
the PIN code.

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
