Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4614C6B7.9040008@free2move.net>
References: <4614A31C.4010806@free2move.net>
	<1175765486.5815.598.camel@violet>  <4614C6B7.9040008@free2move.net>
Date: Thu, 05 Apr 2007 11:56:18 +0200
Message-Id: <1175766978.5815.622.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] How to set packet-type and role from source-code?
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

Hi Markus,

> Thanx for your response, I thought I had to set HV1 packets as I need
> to have 2 (hopefully even 3...) SCO connections simultaneously in a
> pico-net (this relates to the  conversation "Troubles with mulitple
> SCO connections" I posted yesterday) where it turned out that the USB
> dongle was the cause which is why I'm noe going directly for the
> embedded platform using serial hci connection...
> 
> But anyhow - to cut to the chase; 
> If I connect multiple SCO connections from my embedded platform, will
> the packet-types dynamically adjust when I add a second and even third
> SCO connection? This is why I though I had to specifically set
> packet-type to HV1... Could you (or someone that feel for it) just
> confirm my thoughts? ;)

the link manager in the chips firmware is taking care of this. So don't
worry. However when using USB as transport driver you need to adjust the
USB ISOC interface settings, but that is not support at the moment.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
