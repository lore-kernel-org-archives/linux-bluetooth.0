Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <een2ub$f0l$1@sea.gmane.org>
References: <een2ub$f0l$1@sea.gmane.org>
Date: Thu, 21 Sep 2006 18:07:49 +0200
Message-Id: <1158854869.11194.48.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Browsing Anycom GP-600 GPS Receiver fails
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

Hi Michael,

> I own an Anycom GP-600 GPS Receiver. This receiver might have a broken 
> SDP stack. I use SuSE Linux 9.3.
> 
> When browsing the device using the sdptool browse command, it fails. 
> However when using Konqueror to browse the SDP-record on the same 
> distribution it works fine.
> 
> The difference between kde and sdptool browse seems to be, that kde uses 
> a 32 bit UUID, while the sdptool uses a 16 bit UUID.
> 
> Is there any chance that bluez could handle such trouble more gracefully 
> and issue a waring? I remember prior Bluez versions had been working 
> slightly better.

it simply means that this device has no public browse group. That is not
a bug. Try "sdptool browse --l2cap <bdaddr>" and see if this works.

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
