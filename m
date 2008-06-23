Return-Path: <cyrus@holtmann.org>
Message-ID: <52cf60ee0806230639r6e620b2en4b2a2cc5f060d52f@mail.gmail.com>
Date: Mon, 23 Jun 2008 09:39:21 -0400
From: "Jui-Hao Chiang" <windtracekimo@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Multiple SCO connections
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

Dear All:
I am currently trying to extend a bluetooth channel driver
(chan_mobile) for Asterisk (a VoIP PBX).
Now I have a few questions about SCO in bluez stack.
(1) Does latest Bluez support multiple SCO from one USB dongle to
multiple cell phones (Hands-Free Profile)?
According to this discussion thread
http://thread.gmane.org/gmane.linux.bluez.devel/12893/focus=12903, the
hci_usb.c is not patched to fully support multiple SCO links for a
single USB dongle. (But the weird thing is the original poster gets
things to work by only removing wrong usage in socket setting).

(2) Is there any simple way to test the simultaneous SCO connections
from one dongle to two cell phones? By using socket, I know we can
send data and receive from the remote side. But as for interacting
with cell phone's Hand's Free Profile, is there any simple way? such
as pressing the button on the phone?

(3) Is there any way to check the packet type of baseband controller
of the USB bluetooth dongle (HV2 or HV3..)? since the hci_dump or
hcitool can only retrieve or dump the hci message.

Thanks.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
