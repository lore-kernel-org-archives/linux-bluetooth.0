Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 6680 services....
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4343953D.7070901@ruault.com>
References: <4340F256.3040605@ruault.com> <1128339452.22437.6.camel@blade>
	 <4343953D.7070901@ruault.com>
Content-Type: text/plain
Message-Id: <1128511597.5102.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 05 Oct 2005 13:26:37 +0200

Hi Charles,

> thanks for the reply. In the meantime i had dug into the code and
> figured this out ....
> I'm now trying to use obexftp to tranfer data to/from my phone but it's
> failing ( it used to work fine on my motorola e398 ).
> Here's the log i'm getting:
> 
> obexftp -b 00:xx:xx:xx:xx:xx -l -v
> Browsing 00:xx:xx:xx:xx:xx ...
> No custom transport
> Connecting...bt: 1
> done
> Receiving (null)... failed: (null)
> Disconnecting...done
> 
> However, the device does advertise an obex file transfer profile:
> 
> Service Description: OBEX File Transfer
> Service RecHandle: 0x10005
> Service Class ID List:
> "OBEX File Transfer" (0x1106)
> Protocol Descriptor List:
> "L2CAP" (0x0100)
> "RFCOMM" (0x0003)
> Channel: 10
> "OBEX" (0x0008)
> Language Base Attr List:
> code_ISO639: 0x454e
> encoding: 0x6a
> base_offset: 0x100
> Profile Descriptor List:
> "OBEX File Transfer" (0x1106)
> Version: 0x0100
> 
> 
> Specifying channel 10 to obexftp does not improve things ...

show us the output of "hcidump -X -V" for this transaction.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
