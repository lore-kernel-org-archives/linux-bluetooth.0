Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20031009102229.05a801a0@unixmail.qualcomm.com>
To: Steven Singer <steven.singer@csr.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] hciconfig
Cc: Christian Eiselt <c.eiselt@gmx.de>,
   bluez Dev <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3F854DE3.9090001@csr.com>
References: <5.1.0.14.2.20031008175536.0241e658@unixmail.qualcomm.com>
 <5.1.0.14.2.20031008175536.0241e658@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Date: Thu, 09 Oct 2003 10:25:33 -0700

At 05:00 AM 10/9/2003, Steven Singer wrote:
>Max Krasnyansky wrote:
>>In older HCI implementation HCI_Reset used to reset USB transport even
>>though spec clearly states that it shouldn't. This may cases all sorts of problems. Looks like you got one of those dongle with buggy HCI implementation.
>
>I'd like to pick you up on the words "clearly" and "buggy". This is an
>example of how the Bluetooth spec has been tightened to avoid ambiguity.
:)

Thanks for clarification Steven. I didn't know that 1.0b allowed complete
reset and I was referring to 1.1.

Max



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
