Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with multiple PANUs connecting via the
	same Bluetooth USB dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: Sami Nikkarinen <samitius@luukku.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1079743635953.samitius.70713.-NzbxEEFNkxHlpJ_X9rCCw@luukku.com>
References: <1079743635953.samitius.70713.-NzbxEEFNkxHlpJ_X9rCCw@luukku.com>
Content-Type: text/plain
Message-Id: <1079790903.31859.31.camel@pegasus>
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
Date: Sat, 20 Mar 2004 14:55:03 +0100

Hi Sami,

> The only difference I can spot here is the HCI Revision and LMP Subversion fields, but can these explain the different performance of the dongles? Or is the reason somewhere else? At least it shouldn't be in any way related to the PAN profile, since the problems seem to exist in much lower level of Bluetooth.

the problem can be CSR firmwares prior HCI 16.4 and take a look at my
web pages to see how HCI revision fits in to the CSR firmware version.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
