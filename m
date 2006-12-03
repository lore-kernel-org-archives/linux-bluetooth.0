Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0612011423030.9177@redbean.intranet.gw-instruments.de>
References: <BAY108-F9E1C2886FA8EB91A3A20384DA0@phx.gbl>
	<Pine.LNX.4.63.0612011423030.9177@redbean.intranet.gw-instruments.de>
Date: Sun, 03 Dec 2006 14:38:43 +0100
Message-Id: <1165153123.19590.18.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] packet type
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

Hi Peter,

> > is it possible to force bluez to use a self chosen packet type like DH5? or 
> > will it automatically switch to the best packet type?
> 
> You can set a Mask which packets types the baseband is allowed to use (see 
> hcid.conf). However, from the allowed packet types the baseband chooses 
> which one it actually uses . Further, some basenband implementations seems 
> to interpret this "mask" differently (e.g. when you set the mask to DH5 
> the baseband also uses all smaller packet types). 

that is clearly a bug in the firmware, but please remember that packet
type DM1 is always selected.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
