Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] AMD64 HID pairing
From: Marcel Holtmann <marcel@holtmann.org>
To: Kyle Rose <krose+bluez@krose.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <87ekk82ar4.fsf@nausicaa.krose.org>
References: <khnacuya23u.fsf@hunter-killer.kendall.corp.akamai.com>
	 <1097185188.7325.75.camel@pegasus>
	 <khnr7oa8ah1.fsf@hunter-killer.kendall.corp.akamai.com>
	 <1097186322.7325.79.camel@pegasus>
	 <khnk6u289o5.fsf@hunter-killer.kendall.corp.akamai.com>
	 <87ekk82ar4.fsf@nausicaa.krose.org>
Content-Type: text/plain
Message-Id: <1097342518.12972.3.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 09 Oct 2004 19:21:59 +0200

Hi Kyle,

> OK, so I'm now using 2.6.9-rc3-bk8, and I get the following when
> moving the mouse around after the connection times out:
> 
> > HCI Event: Connect Request (0x04) plen 10
>   19 C4 14 61 07 00 80 25 00 01 
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>   19 C4 14 61 07 00 00 
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 09 04 
> > HCI Event: Link Key Request (0x17) plen 6
>   19 C4 14 61 07 00 
> < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
>   19 C4 14 61 07 00 
> > HCI Event: Role Change (0x12) plen 8
>   00 19 C4 14 61 07 00 00 
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0C 04 00 19 C4 14 61 07 00 
> > HCI Event: PIN Code Request (0x16) plen 6
>   19 C4 14 61 07 00 
> < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
>   19 C4 14 61 07 00 04 36 30 35 38 00 00 00 00 00 00 00 00 00 
>   00 00 00 
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0D 04 00 19 C4 14 61 07 00 
> > HCI Event: Connect Complete (0x03) plen 11
>   18 2A 00 19 C4 14 61 07 00 01 00 
> > HCI Event: Connect Request (0x04) plen 10
>   19 C4 14 61 07 00 80 25 00 01 
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>   19 C4 14 61 07 00 00 
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 09 04 
> > HCI Event: Role Change (0x12) plen 8
>   00 19 C4 14 61 07 00 00 
> > HCI Event: Connect Complete (0x03) plen 11
>   17 2B 00 19 C4 14 61 07 00 01 00 
> > HCI Event: Connect Request (0x04) plen 10
>   19 C4 14 61 07 00 80 25 00 01 
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>   19 C4 14 61 07 00 00 
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 09 04 
> > HCI Event: Link Key Request (0x17) plen 6
>   19 C4 14 61 07 00 
> < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
>   19 C4 14 61 07 00 
> > HCI Event: Role Change (0x12) plen 8
>   00 19 C4 14 61 07 00 00 
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0C 04 00 19 C4 14 61 07 00 
> > HCI Event: PIN Code Request (0x16) plen 6
>   19 C4 14 61 07 00 
> < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
>   19 C4 14 61 07 00 04 36 30 35 38 00 00 00 00 00 00 00 00 00 
>   00 00 00 
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0D 04 00 19 C4 14 61 07 00 
> > HCI Event: Connect Complete (0x03) plen 11
>   18 2C 00 19 C4 14 61 07 00 01 00 
> > HCI Event: Connect Request (0x04) plen 10
>   19 C4 14 61 07 00 80 25 00 01 
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>   19 C4 14 61 07 00 00 
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 09 04 
> > HCI Event: Role Change (0x12) plen 8
>   00 19 C4 14 61 07 00 00 
> > HCI Event: Connect Complete (0x03) plen 11
>   17 2D 00 19 C4 14 61 07 00 01 00 
> > HCI Event: Connect Request (0x04) plen 10
>   19 C4 14 61 07 00 80 25 00 01 
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>   19 C4 14 61 07 00 00 
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 09 04 
> > HCI Event: Role Change (0x12) plen 8
>   00 19 C4 14 61 07 00 00 
> > HCI Event: Connect Complete (0x03) plen 11
>   17 2E 00 19 C4 14 61 07 00 01 00 

are you sure that your settings are the same on both machine. Show us
the output of "hciconfig -a".

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
