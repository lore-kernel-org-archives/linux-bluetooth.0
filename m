Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <458AA46B.5060201@pracucci.com>
Date: Thu, 21 Dec 2006 15:12:43 +0000
From: Marco Pracucci <development@pracucci.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45896C24.2070106@pracucci.com>	<1166631806.17802.10.camel@violet>
	<458A2914.1060800@idlum.be> <1166705598.9307.7.camel@violet>
In-Reply-To: <1166705598.9307.7.camel@violet>
Subject: Re: [Bluez-devel] Inquiry cache management (clock offset)
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

Hi Marcel,
> with Bluetooth 1.2 you can even read the local clock and do your
> computation from there. However I doubt that this will give any real
> improvement. Feel free to prove me otherwise, but please make sure that
> your testing is done with real life scenarios. Meaning moving targets.
>   
I have just done some simple tests and I have *not* noticed any
significant differences in performance, as you say.

Marco Pracucci


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
