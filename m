Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth ethereal dissector
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Paul Ionescu <paul@acorp.ro>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3F9F8062.90209@superbug.demon.co.uk>
References: <1067379074.2419.24.camel@paul>
	<3F9F8062.90209@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1067426275.24041.235.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 29 Oct 2003 12:17:49 +0100

Hi James,

> The affix,"http://affix.sourceforge.net/", bluetooth stack for linux 
> already has an interface to ethereal, so it might be worth using the 
> same api as affix has with ethereal, thus sharing the amount of 
> development work needed to be done.

what kind of API are you talking about? You can hack the code for Affix
dumps to read the output of BlueZ hcidump and hope everything works.

Actually I would start from scratch to make sure that the HCI traffic
and higher protocol decoding is working correctly. If you want to write
a real good decoder you also must cache the SDP information from
previous requests, because this can contain data about PSM numbers,
RFCOMM channels, HID descriptors etc.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
