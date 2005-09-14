Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43280B35.1070303@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SCO & btsco
References: <4327D66A.1030304@cefriel.it>
In-Reply-To: <4327D66A.1030304@cefriel.it>
Content-Type: text/plain; charset="us-ascii"
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
Date: Wed, 14 Sep 2005 12:36:21 +0100

Luca Pizzamiglio wrote:
> bt specification says that bluetooth supports three audio formats:
> - CVSD
> - u-law
> - a-law

That's not what the BT spec says, you need to read it more carefully.

BT supports 3 *air* formats: u-law, A-law and CVSD, however, that's
irrelevant as far as interfacing with the chip is concerned as the
chip will transcode to and from those formats from and to the HCI
format (aka the input format).

BT supports the following HCI formats:

  2's complement linear
  1's complement linear
  sign-magnitude
  unsigned (some devices only)
  u-law
  A-law

The linear formats can be 8 bit, 16 bit or 9..15 bit right aligned
in a 16 bit word.

The default format - 0x0060 - is CVSD on the air and 16 bit 2's
complement linear signed on the wire as the output of hciconfig
clearly states.

Always keep the air format set to CVSD (as the two sides need to agree
on the air format in order to be able to make a connection and most,
if not all, Bluetooth devices are set up for CVSD). Make the HCI
format whatever your program supports.

	- Steven
-- 


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

**********************************************************************



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
