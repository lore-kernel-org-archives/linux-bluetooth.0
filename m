Return-Path: <krose@nausicaa.valley-of-wind.krose.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] AMD64 HID pairing
References: <khnacuya23u.fsf@hunter-killer.kendall.corp.akamai.com>
	<1097185188.7325.75.camel@pegasus>
	<khnr7oa8ah1.fsf@hunter-killer.kendall.corp.akamai.com>
	<1097186322.7325.79.camel@pegasus>
	<khnk6u289o5.fsf@hunter-killer.kendall.corp.akamai.com>
From: Kyle Rose <krose+bluez@krose.org>
Date: Sat, 09 Oct 2004 11:04:47 -0400
In-Reply-To: <khnk6u289o5.fsf@hunter-killer.kendall.corp.akamai.com> (Kyle
	Rose's message of "Thu, 07 Oct 2004 18:07:06 -0400")
Message-ID: <87ekk82ar4.fsf@nausicaa.krose.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Kyle Rose <krose@nausicaa.valley-of-wind.krose.org>
List-ID: <bluez-users.lists.sourceforge.net>

>> Then use "-x". I think the "-X" option was introduced with 1.11 or so
>> and the Debian packages are a little bit behind.
>
> I'll have to do this when I get home, so I can move the mouse around
> and see what I get.

OK, so I'm now using 2.6.9-rc3-bk8, and I get the following when
moving the mouse around after the connection times out:

> HCI Event: Connect Request (0x04) plen 10
  19 C4 14 61 07 00 80 25 00 01 
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  19 C4 14 61 07 00 00 
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04 
> HCI Event: Link Key Request (0x17) plen 6
  19 C4 14 61 07 00 
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
  19 C4 14 61 07 00 
> HCI Event: Role Change (0x12) plen 8
  00 19 C4 14 61 07 00 00 
> HCI Event: Command Complete (0x0e) plen 10
  01 0C 04 00 19 C4 14 61 07 00 
> HCI Event: PIN Code Request (0x16) plen 6
  19 C4 14 61 07 00 
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
  19 C4 14 61 07 00 04 36 30 35 38 00 00 00 00 00 00 00 00 00 
  00 00 00 
> HCI Event: Command Complete (0x0e) plen 10
  01 0D 04 00 19 C4 14 61 07 00 
> HCI Event: Connect Complete (0x03) plen 11
  18 2A 00 19 C4 14 61 07 00 01 00 
> HCI Event: Connect Request (0x04) plen 10
  19 C4 14 61 07 00 80 25 00 01 
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  19 C4 14 61 07 00 00 
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04 
> HCI Event: Role Change (0x12) plen 8
  00 19 C4 14 61 07 00 00 
> HCI Event: Connect Complete (0x03) plen 11
  17 2B 00 19 C4 14 61 07 00 01 00 
> HCI Event: Connect Request (0x04) plen 10
  19 C4 14 61 07 00 80 25 00 01 
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  19 C4 14 61 07 00 00 
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04 
> HCI Event: Link Key Request (0x17) plen 6
  19 C4 14 61 07 00 
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
  19 C4 14 61 07 00 
> HCI Event: Role Change (0x12) plen 8
  00 19 C4 14 61 07 00 00 
> HCI Event: Command Complete (0x0e) plen 10
  01 0C 04 00 19 C4 14 61 07 00 
> HCI Event: PIN Code Request (0x16) plen 6
  19 C4 14 61 07 00 
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
  19 C4 14 61 07 00 04 36 30 35 38 00 00 00 00 00 00 00 00 00 
  00 00 00 
> HCI Event: Command Complete (0x0e) plen 10
  01 0D 04 00 19 C4 14 61 07 00 
> HCI Event: Connect Complete (0x03) plen 11
  18 2C 00 19 C4 14 61 07 00 01 00 
> HCI Event: Connect Request (0x04) plen 10
  19 C4 14 61 07 00 80 25 00 01 
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  19 C4 14 61 07 00 00 
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04 
> HCI Event: Role Change (0x12) plen 8
  00 19 C4 14 61 07 00 00 
> HCI Event: Connect Complete (0x03) plen 11
  17 2D 00 19 C4 14 61 07 00 01 00 
> HCI Event: Connect Request (0x04) plen 10
  19 C4 14 61 07 00 80 25 00 01 
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  19 C4 14 61 07 00 00 
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04 
> HCI Event: Role Change (0x12) plen 8
  00 19 C4 14 61 07 00 00 
> HCI Event: Connect Complete (0x03) plen 11
  17 2E 00 19 C4 14 61 07 00 01 00 

Cheers,
Kyle
