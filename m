Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech Cordless Desktop Bluetooth (MX900 +
	Elite keyboard), bthid and a patch
From: Marcel Holtmann <marcel@holtmann.org>
To: Vesa Halttunen <vesuri@jormas.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1087736028.19379.19.camel@pc.vesuri.net>
References: <1087736028.19379.19.camel@pc.vesuri.net>
Content-Type: text/plain
Message-Id: <1087739567.25061.41.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 20 Jun 2004 15:52:48 +0200

Hi Vesa,

> I have a Logitech Cordless Desktop Bluetooth (an MX900 mouse and an
> Elite keyboard). I've been using them in HCI mode by using hid2hci, hcid
> and bthid. This setup has been working somewhat OK but I had a
> problem: if I typed specific character sequences very rapidly - the
> word "sources", for example, some characters got repeated and so that
> "sources" came out as "sourceces". The behaviour was consistent.

may you wanna try the hidd from bluez-utils-2.7 and the hidp kernel
module from the -mh patches.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
