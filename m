Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Strange problem with sdp and Motorola E398
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050420102807.86485.qmail@web41305.mail.yahoo.com>
References: <20050420102807.86485.qmail@web41305.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1113993877.2469.116.camel@pegasus>
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
Date: Wed, 20 Apr 2005 12:44:37 +0200

Hi Alex,

> I have a Motorola E398 bt enabled device (with 7
> languages pack installed). The problem is as
> following: attribute 0x100 (service description) bears
> encoding 'ar' (and it is really in arabic). There is
> also a 7-entry internationalization table for each
> service (with attributes 0xd800, 0xd803, etc for other
> languages, including 'en'). Yet all my attempts to dig
> these strings out with sdp_data_get were in vain. Fred
> Schaettgen, whom I asked for help (as I saw a problem
> in his kbluetoothd problem first), advised me to go to
> this list for help.
> I would like to attach a short sdptool dump to this
> message, for illustration.
> I've tried my chances with hcidump - it seems like
> attributes 0xd800 and such are never fetched or not present.

see my answer to Fred's email.

However this device seems to be qualified:

http://qualweb.bluetooth.org/Template2.cfm?LinkQualified=QualifiedProducts&Details=Yes&ProductID=1409

This actually should mean that the SDP records should have been verified
to match the Bluetooth specification.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
