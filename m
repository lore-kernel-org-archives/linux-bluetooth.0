Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Translated strings in SDP records
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200504201221.17999.bluez-devel@schaettgen.de>
References: <200504201221.17999.bluez-devel@schaettgen.de>
Content-Type: text/plain
Message-Id: <1113993624.2469.111.camel@pegasus>
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
Date: Wed, 20 Apr 2005 12:40:24 +0200

Hi Fred,

> A few days ago I have been asked to support translated strings in the SDP 
> related parts of kdebluetooth, so that service names are displayed in an 
> appropriate language in the user interface.
> All my devices use English only for the SDP records, so I asked Alex Dubov, 
> who sent the feature request, to show me his sdp records. 
> The output of sdptool browse --tree is attached. His device claims to support 
> various languages in the LanguageBaseAttributeIDList, but the services names 
> themselves are only returned in one language. Shouldn't the names be returned 
> in all suported languages at once? Or do I have to request the desired 
> languages explicitly somehow? 

I must admit that I never used this stupid multi language thing, but the
general idea is that you can specify offsets for the strings. The base
offset is 0x100 and thus the attributes 0x100, 0x101 and 0x102 gives you
the correct strings.

So looking at the DUN record the extra strings must be at 0xd800 + 0,
0xd800 + 1, 0xd800 + 2, 0xd803 + 0, 0xd803 + 1 etc. But I don't see any
attributes there and this means that this SDP record is incomplete. I
looked at the sdptool code to verify that we request all attributes and
indeed I saw the range 0x0000 - 0xffff which should include the 0xd8xx
attributes.

What kind of broken device is this? Maybe you wanna give sdptest from
libs2 a try.

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
