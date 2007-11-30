Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <474FD67D.2070504@gmail.com>
Date: Fri, 30 Nov 2007 10:23:09 +0100
From: Isabel <st10900@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <474EA586.5010602@student.uib.no>
	<B340381F-12D7-44F6-8B6D-02918336E55E@holtmann.org>
In-Reply-To: <B340381F-12D7-44F6-8B6D-02918336E55E@holtmann.org>
Subject: Re: [Bluez-devel] Is it posible to generate passkey on some
 external device, and then update the BT-device (without MMi) automatically?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel Holtmann skrev:
> Hi Isabel,
> =

>> Useally a BT device without MMI uses a fixed passkey. If this device  =

>> is
>> a public device, so that a group of people can connect to it, each
>> person should have a unique passkey with the public device.
>>
>> I wonder if it is possible with BlueZ to let some other external
>> controll/system generate a unique passkey for each person that  =

>> wishes to
>> connect to this public device in the future.
>>
>> The external controll/system updates the public device and sends the  =

>> new
>> passkey through a secure channel.
>>
>> Is there some function in BLueZ for this? Is this be possible?
> =

> not really, but you can create a passkey agent that hands out  =

> different pin codes based on the remote device address.
> =

> Regards
> =

> Marcel
> =

> =

> -------------------------------------------------------------------------
> SF.Net email is sponsored by: The Future of Linux Business White Paper
> from Novell.  From the desktop to the data center, Linux is going
> mainstream.  Let it simplify your IT future.
> http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

I was thinking of setting up a couple of public BT-devices far away from
each other. And hoping that a person could have the same passkey with
all the public BT-devices. witch has no input og output capabilities)

This passkey agent that you talk about, was to be placed in the public
device i suppose. Since a person has to use the same passkey with all
the public BT-devices, I need some sentralized passkey agent.

I=B4ll have to think of some other idea of doing this...


-- Tripas










-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
