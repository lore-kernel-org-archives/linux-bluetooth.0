Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCC8DB06@dnce01.ent.ti.com>
References: <CAJdJm_NUjsuytSrKzQ=vsSp7oyPdogxSww+r15dX9Mv==TaRNQ@mail.gmail.com>
	<4EB1B1D6.9060806@codeaurora.org>
	<7769C83744F2C34A841232EF77AEA20C01DCC8DB06@dnce01.ent.ti.com>
Date: Thu, 3 Nov 2011 11:47:18 +0200
Message-ID: <CABBYNZLxDe75tsSVfsR3Tm=ifRQm9TXFmxMWyWTSJBTSAOv=3g@mail.gmail.com>
Subject: Re: Designing a GATT write D-Bus API (was: Re: GATT Dbus API on BlueZ
 - attirbute-api.txt modifications)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: Brian Gix <bgix@codeaurora.org>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Ajay Pillai <Ajay.Pillai@csr.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Thu, Nov 3, 2011 at 10:37 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> Since ReadValue and WriteValue should be non-blocking, as far as I understand from what has been discussed so far. This means that we need to notify the D-BUS clients of write or read results.

You seem to be confusing things here, Read/Write can and probably
should return the value in case of success and anyway we need to
return errors so bluetoothd cannot return until the server respond,
but note that doesn't mean the clients should be using pseudo blocking
calls for this methods nor bluetoothd should block while processing
them. You can take a look at CreatePairedDevice as a reference since
it also connects and return a value synchronously but the client don't
have to block while waiting for it (see test/agent.c).

> One option is to use D-BUS events, but I would rather not use those, since it is broadcasted on the bus for everyone, and we already have registered watchers for this purpose.

We can use unicast signals if we don't want them to be broadcasted,
but the client requesting the read should receive the value as return
so I don't see the problem here.

> The other option is to use the currently registered watchers, and use the ValueChanged message, which contains the path and value, both for read (if the read value is different from the cached one) and for write command (always sent after the write command) and write request (called only when the write response is received, with status success). However, I do see some problems with this convention :
> 1. If read returns with the same value, and the watcher is not called, the D-BUS client has no idea whether the value was read or not.

Just return the value on read.

> 2. On write command, we have no idea if the server has updated the value or not. We can not call the ValueChanged in this case for sure.

If write did not return an error then the value should have been
updated otherwise an error should be return.

> 3. Current implementation sends the property changed event on "Connected" from the device, once the ACL is up and running. However, this may not indicate that the connection is ready for data, as we have SMP in progress. We need to find a better way to let the user know that the connection is really up, or fix the SMP issue and queue up requests when SMP is in progress.

Thats is a bug in SMP we should be able to fix, as for
ACL/Device.Connected we can always create a different interface to
notify when a profile status.

> I would suggest the following for solving this :
> 1. The user MUST register a watcher for the service, if he wants to be notified of read/write results.
> 2. Add ValueWritten and ValueRead messages to the watcher interface, to allow better reporting of read/write procedures.
> 3. Read and Write commends sent to an offline client should not result in automatic reconnection procedure. A client must implement timeouts to figure out if a server will be available for write/read commands or not, and manage it's states accordingly. Something needs to be changed here somehow - I'm not so comfortable with the existing implementation.In addition, we got for the buffering/caching of the written value in bluez, while the connection is offline. What happens if a client writes a new value to the offline server? This will trigger a connection procedure, which may take anywhere from 1 second to infinity. What happens if in this gap, the d-bus client requests the properties? What should the value be ? The old one or the new one?

Nope, clients should be using D-Bus pending calls with a proper
timeout set and perhaps we should even consider having the timeout as
parameter for read/write so that bluetoothd can abort if that expires,
in addition if the client exit the bus while an operation is in
progress bluetoothd should also abort the operation. IMO cached value
only changes upon successful write/read.

> What do you guys think ?

Too much talk but no code actually being produced, how about creating
a python test script for watchers and one for read/write
characteristics, implement ReadValue/WriteValue and actually try
things before we over engineer too much?

-- 
Luiz Augusto von Dentz
