Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Background scanning and white list usage
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140228064422.GA28466@localhost.P-661HNU-F1>
Date: Thu, 27 Feb 2014 22:51:52 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B2E73B9C-3787-4B4B-802B-0C76302BF8F9@holtmann.org>
References: <BFAEE1C5-E74F-40F0-A1A4-8F4907FBDCF4@holtmann.org> <20140228064422.GA28466@localhost.P-661HNU-F1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> The complicated part comes into play when we have devices with LE
>> Privacy enabled and when they are using resolvable private addresses.
>> Meaning when our IRK list is populated with identity addresses and
>> their IRKs. The only way to make this work with the current available
>> controller features is if we program the RPA into the white list.
>> Since that RPA is going to change over time, we need to stop scanning
>> with the white list filter every now and then, scan for all devices
>> and resolve the RPA. If we see a new RPA for a know IRK, we have to
>> replace the old RPA in the white list with the new RPA. And then we go
>> back to scanning with the white list filter policy.
>> 
>> Now the important question is what are good enough intervals to make
>> this work smoothly. Devices using LE Privacy will take a hit in their
>> re-connection time, but that is what we have to trade in for compared
>> to waking up the host for every single advertising packet.
>> 
>> My initial idea is to scan 5 minutes using the white list, then scan
>> 10 seconds without the white list, then back to 5 minutes using the
>> white list and so on.
>> 
>> The default value for the PRA lifetime according to the specification
>> is 15 minutes. I timed recent iOS devices which seem to be using 9
>> minutes intervals. So we have to play a little bit with this and see
>> what are good values.
>> 
>> Maybe 3 minutes white list scan and 5 seconds without white list is
>> better. Things to try out.
> 
> I don't think this is a good idea at all. With LE starting advertising
> is typically seen as the initiating action of connection creation
> (unlike with BR/EDR where HCI_Create_Connection is the initiating
> action). Typically peripherals mean "connect to me now!" when they start
> connectable advertising.
> 
> Let's stay you switch on your peripheral device, or it comes into range
> you haven't used it for some time (hours or even days). If it's using
> RPAs it's pretty much guaranteed to have a different one than what we
> know of and even if we're using 3 minutes white list scanning the user
> is on average going to have to wait for 1.5 minutes for the device to
> get connected which is not acceptable behavior (the extreme example
> would be if this is a keyboard or a mouse which you start using for the
> first time in the morning - moving the mouse or pressing a key on the
> keyboard should certainly get you a connection in less than 1 second).

HID devices would suffer the most here. Fully agree here.

However since neither Microsoft Windows nor OS X can deal with RPAs at the moment, I do not think we are entering a dangerous zone here from an interoperability point of view. Actually Windows 8.1 is not able to connect to any random address for that matter.

My point is that we certainly not make it worse.

> I fully understand the desire to use the white list as it's a very nice
> power saving feature, but I don't think we can win here as long as we
> don't have a way to have the controller do the resolving for us.
> 
> One thing we could potentially try to do (but which I doubt is really
> worth it in the end) is to track the age of resolved RPAs. If we have an
> RPA which was resolved say less than 5 minutes ago we consider it
> appropriate to place into the white list. Otherwise we skip using the
> white list.

I was thinking about this as well. Over time we could learn the age of a RPA and thus schedule the scanning without white list times most efficient. Frankly, I want to get the white list usage going first. As long as you only have public or static addresses, it is the way to go. And then we optimize it when we have to deal with RPAs.

We can not close our eyes to iOS devices using RPAs and I am not willing to take the power hit of getting flooded with advertising reports.

Regards

Marcel

