Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <456234FB.4020506@xmission.com>
References: <455392B6.5060209@free.fr> <45622D23.7070105@vasmac.com>
	<456234FB.4020506@xmission.com>
Date: Tue, 21 Nov 2006 08:35:00 +0100
Message-Id: <1164094500.28429.9.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] New bluetooth-headset release 20061109 :	nickname
	'dogfood' ; -)
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

Hi Brad,

> > Regarding the kernel patches, you know I've taken a different
> > approach. I believe that what I posted is simpler and more reliable
> > as it doesn't depend timers. The flow control approach avoids the
> > possibility of getting out of sync with the dongle.
> 
> fyi, I talked to Marcel about this and he likes solving it at a higher
> level so the transports (usb/uart/sdio) don't have to each have their
> own solution. Maybe he could articulate it better...

I am not against using flow control, but we must be really careful if it
supported or not. While for ACL it is mandatory, the SCO channel can be
used without it. However even the use of flow control on SCO is a job
for the Bluetooth core and no driver specific one. All Bluetooth drivers
are transport drivers. They have no intelligence whatsoever and they are
not interfering the HCI data. If they need to know some specific details
about changes in the core then the notify() callback is the right place
and if they need a special setup, then a quirk should be used. Other
than that, they are plain stupid and only moving HCI packets to the
hardware and back.

So from my understanding the high resolution timer are a good choice to
submit SCO packets to the hardware. In addition we can enable the flow
control for SCO to have more control over the hardware. However please
keep in mind that the enabling flow control means for traffic on the ACL
links and so you might see a downgrade in bandwidth. So from my current
point of view, the flow control stuff must be optional.

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
