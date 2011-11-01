Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: "Ilia, Kolominsky" <iliak@ti.com>,
	Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 1 Nov 2011 15:11:33 +0100
Subject: RE: Implementation of name-resolve procedures in mgmtops
Message-ID: <7769C83744F2C34A841232EF77AEA20C01DCC8D347@dnce01.ent.ti.com>
References: <7769C83744F2C34A841232EF77AEA20C01DCC8D2B7@dnce01.ent.ti.com>
 <AC090B9732AB2B4DB7FF476E907FE660013BAEC903@dnce02.ent.ti.com>
 <20111101134757.GA13263@fusion.localdomain>
 <20111101135225.GA13355@fusion.localdomain>
 <AC090B9732AB2B4DB7FF476E907FE660013BAEC932@dnce02.ent.ti.com>
In-Reply-To: <AC090B9732AB2B4DB7FF476E907FE660013BAEC932@dnce02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ilia, Johan,

> >
> > Actually there are two more context switches involved which probably
> > introduce the most latency into the whole procedure: each time
> > bluetoothd gets a device_found event with confirm_name set to 1 it'll
> > need to access the file-system in /var/lib/bluetooth to check if the
> > name is stored there.
> 
> Alright then, to be on the safe, let's do it 2 sec, my idea was
> to finish the whole process asap. But since io is involved, 2 sec
> seems to be a reasonable balance.
> >
> > Johan
> 

Please keep in mind that if you do it 2 seconds, that will cause a problem. In interleaved scanning, we need to scan for BR/EDR devices for ~5 seconds ( T_GAP_100/2), and then LE devices for 5 seconds. If we wait 2 seconds for timeout, this means 2 seconds in which we do nothing. This will mean that we need to scan for BR/EDR for 1 second, wait 2 seconds for ack, and then we will have about 2 more seconds for name requests for legacy devices. We need to think of a better solution here, which will coexist with interleaved device discovery.

What if we start name requests immediately after the inquiry is complete, according to what is already pending for name request (what the user has already confirmed for name request), and allow the user to confirm the name request for more devices up until we complete the name request process and return the SCAN_COMPLETE event ? The SCAN_COMPLETE event will be sent once the pending names list is clear, or any other limit we decide.

Chen Ganir.

