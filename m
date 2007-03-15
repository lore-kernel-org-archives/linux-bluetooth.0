Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <464194a50703150639u7d4869b7h76f5185fef01f2da@mail.gmail.com>
References: <464194a50703150639u7d4869b7h76f5185fef01f2da@mail.gmail.com>
Date: Thu, 15 Mar 2007 15:53:36 +0100
Message-Id: <1173970416.7461.7.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Is LMP implemented in BlueZ?
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

> I am currently doing my bachelor's dissertation about creating an
> alternative Bluetooth authentication and key exchange scheme, using
> public key crypto, and would like to know whether I should build on
> top of the Bluetooth protocol stack or I can actually add code inside
> the LMP.  I have looked thorough the code in the BlueZ kernel module
> and  In bluez -libs package and I'm left with the impression that the
> link manager and the LMP are part of the Bluetooth device's firmware,
> while the HCI asks it to initiate specific LMP transactions. So my
> question is whether LMP is a software component implemented by BlueZ
> on a computer or it's a firmware component on the Bluetooth receiver
> connected to the computer. I'd be thankful if somebody can clarify
> that for me. 

the LMP implementation is part of the firmware inside the Bluetooth
chip.

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
