Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3F854DE3.9090001@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Christian Eiselt <c.eiselt@gmx.de>,
   bluez Dev <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hciconfig
References: <5.1.0.14.2.20031008175536.0241e658@unixmail.qualcomm.com>
In-Reply-To: <5.1.0.14.2.20031008175536.0241e658@unixmail.qualcomm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 09 Oct 2003 13:00:35 +0100

Max Krasnyansky wrote:
> In older HCI implementation HCI_Reset used to reset USB transport even
> though spec clearly states that it shouldn't. This may cases all sorts 
> of problems. Looks like you got one of those dongle with buggy HCI 
> implementation.

I'd like to pick you up on the words "clearly" and "buggy". This is an
example of how the Bluetooth spec has been tightened to avoid ambiguity.

The Bluetooth 1.1 spec now reads:

   The Reset command will reset the Host Controller and the Link Manager.
   The reset command should not affect the used HCI transport layer since
   the HCI transport layers have reset mechanisms of their own.

Which is fairly clear. However, previous versions of the spec (up to
and including 1.0B) used to read:

   The Reset command will reset the Bluetooth Host Controller, Link
   Manager, and the radio module.

There are two differences. The 1.1 spec contains a clarification that
the transport "should not" be reset. In contrast, not only does the
earlier spec not contain this line, it also states that the radio
module should be reset.

Reading the earlier spec on its own it can easily be read to mean that
the entire Bluetooth dongle is reset. After all, when we normally talk
about the "host controller" we normally refer to the entire Bluetooth
dongle. For example, if we're talking on this mailing list about the
USB interface I might say "the host controller advertises three USB
endpoints" (or whatever), I would not say "the USB host transport
entity on the host controller advertises three USB endpoints".

I think a device that fully resets on receiving an HCI_Reset is
following a legitimate interpretation of the 1.0B spec.

However, this is not what the spec author intended. Hence the
tightening.

Note that the 1.1 spec is not completely unambiguous. It says that the
reset command "should" not affect the host transport. Not that it
"shall" or "must" not. A pedant might argue that the 1.1 spec still
allows resetting of the host transport. Although this is a possible
interpretation, I do not believe that it is a reasonable
interpretation.

One of the changes in the Bluetooth 1.2 spec (which I can't quote
here as it's not released yet) is that the wording has been
tightened to use IEEE language throughout the entire spec (a mammoth
job). Consequently, the word "should" shouldn't appear anywhere in
the spec. It should all be "shall" or "may".

So, after that historical diversion, some more concrete advice. Early
CSR dongles (up to, and including version 11 firmware) followed the
interpretation of the earlier spec that allowed HCI_Reset to reset the
host transport. All modern CSR devices (version 12 firmware and later)
do not reset the transport. If you have one of our old devices you have
two options:

   1) The proper solution: upgrade your CSR firmware to a more recent
      version (generally a good thing).

   2) The quick hack: set the PS key PSKEY_HCI_RESET_STUB (0x00F1)
      to 1. This causes the HCI_Reset command to be a no-operation.
      We still emit the command_complete but we do not reset any
      active links. This hack is a useful workround if your host
      stack always issues an HCI_Reset as the first command to any
      new device it finds.

Nowadays I would not recommend option 2, I would recommend only
option 1.

If you're using a Bluetooth dongle from another manufacturer, then
you'll need to contact them to find out what to do.

	- Steven
-- 



**********************************************************************
The information transmitted is intended only for the person or
entity to which it is addressed and may contain confidential 
and/or privileged material. 
Any review, retransmission, dissemination or other use of, or
taking of any action in reliance upon, this information by 
persons or entities other than the intended recipient is 
prohibited.  
If you received this in error, please contact the sender and 
delete the material from any computer.
**********************************************************************



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
