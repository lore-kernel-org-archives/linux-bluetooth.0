Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MS Optical Desktop for bluetooth - Stops working
	after a time
From: Marcel Holtmann <marcel@holtmann.org>
To: Paul Hedderly <bulkpaul@mjr.org>
Cc: Daniel Scott <danieljamesscott@gmail.com>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040920104135.GU26469@wacka.mjr.org>
References: <6835906b04091701465c5e3c7c@mail.gmail.com>
	 <20040920104135.GU26469@wacka.mjr.org>
Content-Type: text/plain
Message-Id: <1095678031.5731.14.camel@pegasus>
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
Date: Mon, 20 Sep 2004 13:00:31 +0200

Hi Paul,

> I have an Ericsson K700i. In the bluetooth menu there is an option
> "remote control" and when you sdptool brose the phone you get:
> 
> Service Name: Mouse & Keyboard
> Service Description: K700
> Service Provider: Sony Ericsson
> Service RecHandle: 0x1001c
> Service Class ID List:
>   "Human Interface Device" (0x1124)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>     PSM: 17
>   "HIDP" (0x0011)
> Language Base Attr List:
>   code_ISO639: 0x656e
>   encoding:    0x6a
>   base_offset: 0x100
> Profile Descriptor List:
>   "Human Interface Device" (0x1124)
>     Version: 0x0100

please do a "hcitool info <k700i>" as root for me and use the sdptest
program from the libs2 CVS repository to get me the full SDP records.

You don't need to install the libs2 stuff. Only check it out and compile
it with "./bootstrap && ./configure && make". After that you should call

	./test/sdptest records k700i-bdaddr > sdp_records.txt

and then send me the sdp_records.txt file. The output from "hcitool inq"
will also be nice to see what kind of class of device they are using.

> So I tried "hidd -c 00:..." with hidd --server runnning of course.
> 
> Now the phone wakes up and says "Start remote control? Yes/No" And I say
> yes... it goes into remote control mode for a moment then quits saying
> "No more files".
> 
> Anybody got their k700 to work as a mouse/keybd? What file is it
> expecting?

>>From the hcidump I see a problem with connecting to the SDP PSM. It
seems that this is disabled when HID is in use and this phone has a
stupid L2CAP implementation that reacts weird and we do the same. But
for you it responds with "Connection refused - no resources available"
and this is great. They offer HID support and can't have three L2CAP
connections at the same time. That is totally stupid.

I need such a phone to tweak around the L2CAP problem and get the hidd
working without retrieving the SDP record. Any sponsor out there?

And btw do you enabled auth and encrypt in hcid.conf? Don't do so unless
you really wanna use security mode 3.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
