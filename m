Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <307f591f0710312056r5f3f62ak42bc3cd3b8f01942@mail.gmail.com>
References: <307f591f0710312056r5f3f62ak42bc3cd3b8f01942@mail.gmail.com>
Date: Thu, 01 Nov 2007 06:20:55 +0100
Message-Id: <1193894455.32459.130.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] multi-frequency scanning & US $2,000 'bounty'
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Paul,

> First, regarding the concerns previously stated in the thread: Don't
> worry about 'spamming'; the customer has to explicitly sign up online
> first.  There's also no concern about getting the Bluetooth logo on
> the box; this is a closed system for a particular retail customer.
> It's a black box solution.  Also, there's no concern about needing to
> actually 'pair' with the device that fast and transmit data; we just
> need to quickly detect the phones as they pass through.  And any mods
> to bluez will be released under GPL. 

since the system is using Bluetooth, you have to get the Bluetooth logo
on your box. Otherwise you are not allowed to sell it. You really wanna
look into the Bluetooth IP license stuff that comes along with the
Bluetooth logo. You should not ignore this matter.

And just to be clear. Not only the modifications to BlueZ, all programs
liking in libbluetooth must be made GPL. The Bluetooth library itself is
GPL and thus your programs must be licensed under GPL, too.

> 2)  Code the software: I need a piece of software that can detect a
> mobile phone and report the bluetooth id and the mac address of the
> phone reliably in 2 seconds or less when that phone is passing under
> the antenna at a speed of up to 2.5 meters per second (ie a brisk
> walk) so that each phone will always be detected every time as it
> passes through the coverage area.

If you mean class of device with the bluetooth id, then the D-Bus signal
RemoteDeviceUpdated gives you exactly that information.

> The software app can just write the mac + bluetooth id to stdout as
> the phones are detected.  That is sufficient for this, and I can do
> the rest.  I'd like the software to be in C or C++.  Ideally I'll
> probably use the 2.4 kernel for this since it seems lighter weight.
> But I'd need you to confirm that the bluetooth stuff works
> sufficiently well on 2.4, and we can go to 2.6 if needed.  It has to
> be reliable and accurate and detect a standard bluetooth phone that is
> not obscured by anything except perhaps fabric (ie in a pocket) 99% of
> the time. 

I don't know who comes up with this crap that a 2.4 kernel is more
lightweight. Because the source code is smaller? Yeah, that is a pretty
bad indicator. The kernel to use is 2.6.23 and there is no real reason
to use any older kernel.

> The deliverables are: 1) specify what usb dongle and antenna to use
> (make/model/supplier), 2) code that compiles with 'make' and runs and
> performs the tasks described.  I'd like to have the finished solution
> within about 4 weeks. 
> 
> If someone thinks that the requirements are doable in the time frame,
> I'll get the client to provide the contract confirming payment when
> the deliverables are met.  If it's not doable or will require more
> time/money, let me know, and I'll try to get the client to approve
> more.  I told them I thought $2k was reasonable, even though I don't
> really know all that's involved.  If you e-mail me privately, I'll
> give you a phone number too so you can call if you'd like to discuss. 

Just a small piece of advise for everybody who is thinking about taking
this bounty. Don't post to the mailing list a request on how to do this
and expect us to write the code for you. Get it done by yourself since
it is actually pretty simple.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
