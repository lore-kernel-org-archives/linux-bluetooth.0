Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Can't Connect RFCOMM Socket. Too many links.
From: Marcel Holtmann <marcel@holtmann.org>
To: Ramon A Reveron <ramon@us.ibm.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <OF6234E0FF.802EEC59-ON85256EE7.0053B1A7-85256EE7.0055FA76@us.ibm.com>
References: 
	 <OF6234E0FF.802EEC59-ON85256EE7.0053B1A7-85256EE7.0055FA76@us.ibm.com>
Content-Type: text/plain
Message-Id: <1091738294.20839.51.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 05 Aug 2004 22:38:14 +0200

Hi Ramon,

> Here are the two files:

your second connection creation results in this:

	< HCI Command: Create Connection(0x01|0x0005) plen 13
	  C2 46 0A 96 A0 00 18 CC 02 00 00 00 01 
	> HCI Event: Command Status(0x0f) plen 4
	  00 01 05 04 
	> HCI Event: Connect Complete(0x03) plen 11
	  09 00 00 C2 46 0A 96 A0 00 01 00 

The error code 0x09 actually means: CONNECTION LIMIT EXCEEDED (0X09)

	The Connection Limit Exceeded error code indicates that an
	attempt to create another connection failed because the
	controller is already at its limit of the number of connections
	it can support. The number of connections a device can support
	is implementation dependent.

Maybe this is a problem of your GPS unit, because the Bluetooth dongle
you are using is build id 0x33c and that is a HCI 16.14 firmware.

And I saw that you are using security mode 3 in one of your devices.
Disable it. Maybe this causes the trouble.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
