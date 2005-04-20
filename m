Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Strange problem with sdp and Motorola E398
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050420105952.90278.qmail@web41311.mail.yahoo.com>
References: <20050420105952.90278.qmail@web41311.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1113995272.2469.119.camel@pegasus>
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
Date: Wed, 20 Apr 2005 13:07:52 +0200

Hi Alex,

> I've checked out libs2 from sf cvs and ran sdptest -
> I've attached the results, though they are not
> exciting (no other strings - only arabic).

please redo it with "sdptest records" and also include the output of
"hcitool info" (as root) for this phone.

> Does it
> means that I have to write to motorola people - this
> seems as a firmware bug after all. 

Check again with "hcidump -X -V" and post the dump, but I really think
that these attributes are missing.

Write to the Motorola people and see what they tell you about it.

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
