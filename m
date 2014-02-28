Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5310BFEF.8010405@gmx.net>
References: <530FBB6B.8080300@gmx.net>
	<CAJdJm_P9FD+NwSAfG=1bWg0Ep2Ku7eTqwpLN2aX6p5-+rc=3sA@mail.gmail.com>
	<5310BFEF.8010405@gmx.net>
Date: Fri, 28 Feb 2014 13:11:10 -0400
Message-ID: <CAJdJm_PVX=97RPVUJ5qx9k-OFNt=xidLrwgL6qK9QTTRBJHd+Q@mail.gmail.com>
Subject: Re: [bluez-5.14] connect fails with 'org.bluez.Error.NotAvailable'
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Tobias Jakobi <liquid.acid@gmx.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tobias,

On Fri, Feb 28, 2014 at 12:57 PM, Tobias Jakobi <liquid.acid@gmx.net> wrote:
> Anderson Lizardo wrote:
>> Looks like you are missing a "power on" on the server side. Notice
>> that the client side shows "Powered: yes" on the info command.
>>
>> Best Regards,
>>
> Hello Anderson!
>
> Sadly this doesn't solve the issue. The BT device on the server side is
> already powered on. Otherwise I wouldn't be able to establish the
> connection with the Android smartphone in the first place.

I misunderstood the first output, it was actually the "info" command
for the server from the client side. I thought it was the "show"
command on the server side. That explains the missing "Powered"
property :)

-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
