Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45FF1879.4000108@xmission.com>
Date: Mon, 19 Mar 2007 17:10:49 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45FF1D5B.7030403@sportlaan.adsl.utwente.nl>
	<1174344724.30217.6.camel@cronus.homenet>
In-Reply-To: <1174344724.30217.6.camel@cronus.homenet>
Subject: Re: [Bluez-devel] Use SCO links to a phone
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

David

> I may be barking down the wrong tree, so to speak, but I think all the
> functionality you need is present in gammu, and whenever I've used gammu
> over rfcomm, it's been fine on channel 1.

fwiw, the spec says to use sdp and look up the gateway service to
determine the channel number. the old btsco does something similar when
finding the headset service.

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
