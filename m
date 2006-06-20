Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44969304.1020502@ibmt.fraunhofer.de>
References: <448D6723.4050107@ibmt.fraunhofer.de>
	<1150540961.17539.40.camel@aeonflux.holtmann.net>
	<44969304.1020502@ibmt.fraunhofer.de>
Date: Tue, 20 Jun 2006 11:41:05 +0200
Message-Id: <1150796465.18381.29.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Problem connecting Bluetooth device
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

Hi Harald,

> here are 2 different outputs of "hcidump -X -V" (i apologize for the length)

is the device a security mode 3 device or did you enabled auth and
encrypt in hcid.conf?

So the PIN code of this device is "111111". What does the manual state
about Bluetooth pairing etc.

The link key you get from the pairing is different from the link key you
actually use for authentication in the second try. Please check what has
been stored in /var/lib/bluetooth/<bdaddr>/linkkeys.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
