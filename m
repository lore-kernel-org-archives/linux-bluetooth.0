Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41f42627.4a25d8c3.46ed7733.d4785@o2.pl>
References: <41f42627.4a25d8c3.46ed7733.d4785@o2.pl>
Date: Sun, 16 Sep 2007 22:49:31 +0200
Message-Id: <1189975771.7541.49.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Problem with A2DP & HHB-750
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Konrad,

> Hi. I've got Siemens HHB-750 bluetooth headphones and Dell Latitude X1 laptop with dell BT card:
> Bus 002 Device 003: ID 413c:8103 Dell Computer Corp. Wireless 350 Bluetooth
> 
> Pairing is ok, connecting too, but it still skips (like buffering?). It depends on 'sbcbitpool' in config. For example for sbcbitpool=4 it skips every ~9 seconds. For sbcbitpool=32 it's about 300-500ms :(
> I'm using Feodra 7 with kernel 2.6.22 (2.6.22.1-41.fc7).

please test the audio service from bluez-utils-3.19. The installation
details can be found at wiki.bluez.org.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
