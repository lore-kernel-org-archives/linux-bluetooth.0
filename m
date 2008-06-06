Return-Path: <cyrus@holtmann.org>
Date: Fri, 06 Jun 2008 14:31:06 +0200
From: Jan Lana <Jan.Lana@Sun.COM>
To: bluez-devel@lists.sourceforge.net
Message-id: <20080606123106.GE14966@czech.sun.com>
MIME-version: 1.0
Subject: [Bluez-devel] headset and headsetAG profile
Reply-To: Jan Lana <Jan.Lana@Sun.COM>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi,

I would like to make a gateway bt phone <-> skype. One way is to
implement H[SF]P profile on computer side and have an alsa device for
autio stream.

Please correct me if I am wrong:
 - utils/audio/headset.c implements H[SF]P:AG - it simulate audio
   gateway (phone) and try to connect to a headset (H[SF]P:HF) (sdptool
   add HFAG)
 - HFP:HF is supported by sdptool but not implemented yet (sdptool add
   HF)

I would like to participate on H[SF]P:HF implementation - does anybody
works on H[SF]P:HF implementation? I have found that lot of things are
already prepared ...

- jan

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
