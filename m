Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Message-ID: <000a01c31687$c06757a0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: [Bluez-devel] Qualification - L2CA_DisconnectCfm
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 9 May 2003 17:04:39 -0700

Max, Marcel,

In order to pass TP/COS/CED/BV-08 we're supposed to be able to indicate tha=
t
there was a timeout waiting for an L2CAP disconnect confirm from the remote
device. I'm waiting for clarification that this is indeed necessary.

The test works like this:

1. We send a disconnect request
2. The tester ignores it.
3. optionally - we resend the disconnect request following a timeout patter=
n
where each retransmission happens after a delay equal to twice the previous
delay.
4. After 60 seconds the channel must be closed - we indicated to the app
that the channel is indeed closed (even though we didn't get a confirmation
from the remote side) and indicate that a timeout ocurred.

I think there's a standard way of doing that sort of thing by setting a
socket option which causes close() to block until things are closed. Not
sure though.

Can we do this with BlueZ?

-Daryl.



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
