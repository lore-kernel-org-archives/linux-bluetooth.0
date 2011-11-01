Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCC8D347@dnce01.ent.ti.com>
References: <7769C83744F2C34A841232EF77AEA20C01DCC8D2B7@dnce01.ent.ti.com>
	<AC090B9732AB2B4DB7FF476E907FE660013BAEC903@dnce02.ent.ti.com>
	<20111101134757.GA13263@fusion.localdomain>
	<20111101135225.GA13355@fusion.localdomain>
	<AC090B9732AB2B4DB7FF476E907FE660013BAEC932@dnce02.ent.ti.com>
	<7769C83744F2C34A841232EF77AEA20C01DCC8D347@dnce01.ent.ti.com>
Date: Tue, 1 Nov 2011 17:15:26 +0200
Message-ID: <CABBYNZKC2PEDAqZ0beKWvga=_5N-9eHbHX3NSJZOtn9K-gUy4w@mail.gmail.com>
Subject: Re: Implementation of name-resolve procedures in mgmtops
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: "Ilia, Kolominsky" <iliak@ti.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

On Tue, Nov 1, 2011 at 4:11 PM, Ganir, Chen <chen.ganir@ti.com> wrote:
> Ilia, Johan,
>
>> >
>> > Actually there are two more context switches involved which probably
>> > introduce the most latency into the whole procedure: each time
>> > bluetoothd gets a device_found event with confirm_name set to 1 it'll
>> > need to access the file-system in /var/lib/bluetooth to check if the
>> > name is stored there.
>>
>> Alright then, to be on the safe, let's do it 2 sec, my idea was
>> to finish the whole process asap. But since io is involved, 2 sec
>> seems to be a reasonable balance.
>> >
>> > Johan
>>
>
> Please keep in mind that if you do it 2 seconds, that will cause a problem. In interleaved scanning, we need to scan for BR/EDR devices for ~5 seconds ( T_GAP_100/2), and then LE devices for 5 seconds. If we wait 2 seconds for timeout, this means 2 seconds in which we do nothing. This will mean that we need to scan for BR/EDR for 1 second, wait 2 seconds for ack, and then we will have about 2 more seconds for name requests for legacy devices. We need to think of a better solution here, which will coexist with interleaved device discovery.

I guess we can tweak the page timeout as someone suggested in the
meeting, anyway I have a feeling interleaved might change in the
future, IMO the interval is big enough to annoy people.

> What if we start name requests immediately after the inquiry is complete, according to what is already pending for name request (what the user has already confirmed for name request), and allow the user to confirm the name request for more devices up until we complete the name request process and return the SCAN_COMPLETE event ? The SCAN_COMPLETE event will be sent once the pending names list is clear, or any other limit we decide.

You mean in parallel with LE scan? I don't think this is possible
since name request involve paging so the baseband should be busy.

-- 
Luiz Augusto von Dentz
