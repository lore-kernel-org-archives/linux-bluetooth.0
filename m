Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth MIME types and URIs
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb050708092343073205@mail.gmail.com>
References: <1120747365.18553.15.camel@pegasus>
	 <200507071900.33313.bluez-devel@schaettgen.de>
	 <1120759981.18553.52.camel@pegasus>
	 <200507080315.50686.bluez-devel@schaettgen.de>
	 <1120804711.18553.100.camel@pegasus>
	 <e1effdeb05070805454b8960b6@mail.gmail.com>
	 <1120834052.18553.123.camel@pegasus>
	 <e1effdeb050708092343073205@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1120849847.7444.5.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 08 Jul 2005 21:10:47 +0200

Hi Claudio,

> I see a new repository in the CVS(Bluehood).  I think that this
> daemon will be the metaserver, is that correct?

actually that is quite old and has nothing to do with it. The new
bluetoothd will be inside utils/daemon/.

> > The new InquiryResult and RemoteName signals are implemented in hcid for
> > testing. Start "dbus-monitor --system" and call "hcitool scan".
> I didn't find  this code in the bluez-utils-2.18 code. Where is it? Could
> you send me the CVS branch or the code?
> I found references in the kbluetoothd(neighbourmonitor.cpp), but there is no 
> D-Bus messages involved.

You are mixing things here. The KDE Bluetooth stuff has nothing to do
with it at the moment. The code is inside the CVS and will be part of
the 2.19 release.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
