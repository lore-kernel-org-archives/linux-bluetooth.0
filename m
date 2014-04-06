Return-Path: <cyrus@holtmann.org>
Message-ID: <534179D4.4040607@gmx.net>
Date: Sun, 06 Apr 2014 17:59:16 +0200
From: Tobias Jakobi <liquid.acid@gmx.net>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [bluez-5.14] connect fails with 'org.bluez.Error.NotAvailable'
References: <530FBB6B.8080300@gmx.net>	<CAJdJm_P9FD+NwSAfG=1bWg0Ep2Ku7eTqwpLN2aX6p5-+rc=3sA@mail.gmail.com>	<5310BFEF.8010405@gmx.net> <CAJdJm_PVX=97RPVUJ5qx9k-OFNt=xidLrwgL6qK9QTTRBJHd+Q@mail.gmail.com> <53137E6E.7080305@gmx.net>
In-Reply-To: <53137E6E.7080305@gmx.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Tobias Jakobi wrote:
> Anderson Lizardo wrote:
>> I misunderstood the first output, it was actually the "info" command
>> for the server from the client side. I thought it was the "show"
>> command on the server side. That explains the missing "Powered"
>> property :)
>>
> I see. Any idea how to isolate where the NotAvailable error origins from?
> 
> With best wishes,
> Tobias
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Just a small note that I updated the bluez stacks (both on the server
and the client) to 5.17. However the issue remains.

I've also created log from the debug output of bluetoothd on both sides:
http://www.math.uni-bielefeld.de/~tjakobi/bt-client.log
http://www.math.uni-bielefeld.de/~tjakobi/bt-server.log

Has anyone here actually managed to get a working TCP/IP network with
recent bluez stack?

Greets,
Tobias

