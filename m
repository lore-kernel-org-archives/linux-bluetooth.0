Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <04f801c5a869$711dfbb0$6c01a8c0@Vijayakumar>
From: "Vijayakumar" <vijayakumar@isofttech.com>
To: <bluez-devel@lists.sourceforge.net>
References: <032b01c5a7ae$fd98ba00$6c01a8c0@Vijayakumar> <1124780679.23599.119.camel@pegasus>
Subject: Re: [Bluez-devel] pand problem
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
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
Date: Wed, 24 Aug 2005 10:35:26 +0530

Hi Marcel,
>> My linux kernel version is 2.4.20-8
>> Applied 2.4.18 mh patch

Sorry for the incorrect information, my kernel is 2.4.18.

> this kernel is quite old and the -mh patch for 2.4.18 can't be applied
> to a 2.4.20 kernel. Why don't you switch to the latest 2.6 kernel?
>
Upgrading to a latest kernel is not possible right now, it is beyond my 
control

> Run "hcidump -X -V" and see why the connection gets terminated.
>
I got the following on my board side (2.4.18 kernel)

< ACL data: handle 42 flags 0x02 dlen 192
< ACL data: handle 42 flags 0x02 dlen 192
< ACL data: handle 42 flags 0x01 dlen 192
> ACL data: handle 42 flags 0x02 dlen 512
> ACL data: handle 42 flags 0x01 dlen 512
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x08
    Reason: Connection Timeout

and on the pc side (running redhat linux )

> ACL data: handle 41 flags 0x01 dlen 192
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x08
    Reason: Connection Timeout

Can you give some clues?
Regards,
Vijayakumar.




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
