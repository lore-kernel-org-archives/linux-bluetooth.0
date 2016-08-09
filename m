Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 9 Aug 2016 17:32:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Kropf Johannes <Johannes.Kropf@ait.ac.at>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: 5.41 - Authentication Failed with kernel 4.2.0
Message-ID: <20160809143212.GA10222@t440s.P-661HNU-F1>
References: <E92610C73D6DE84EB154DC52F5ECCE541D74740E@S0MSMAIL111.arc.local>
 <20160808094255.GA8136@t440s.lan>
 <E92610C73D6DE84EB154DC52F5ECCE541D7479B6@S0MSMAIL111.arc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E92610C73D6DE84EB154DC52F5ECCE541D7479B6@S0MSMAIL111.arc.local>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johannes,

Please don't drop the mailing list from the thread (added it back now).

On Tue, Aug 09, 2016, Kropf Johannes wrote:
> > On Mon, Aug 08, 2016, Kropf Johannes wrote:
> > > we had a problem when attempting to pair low energy devices on Ubuntu
> > with kernel version 4.2.0-42-generic:
> > > After scanning there always occured an "authentication failed" error.
> > > The devices we tried to pair were a A&D UC-352-BLE weighing scale and a
> > A&D UA-651BLE blood pressure monitor.
> > > Both devices can be paired on the same machine with the same setup but
> > with kernel version 3.13.0.92.
> > > Unfortunately the log doesn't give me an idea what the problem is.
> > >
> > > Here is the output using bluetoothctl:
> > > [bluetooth]# pair 5C:31:3E:5E:54:5E
> > > Attempting to pair with 5C:31:3E:5E:54:5E [CHG] Device
> > > 5C:31:3E:5E:54:5E Connected: yes Failed to pair:
> > > org.bluez.Error.AuthenticationFailed
> > > [CHG] Device 5C:31:3E:5E:54:5E Connected: no
> > 
> > Did you also have an agent registered? (e.g. "agent KeyboardDisplay" in
> > bluetoothctl)
> Yes, an agent was registered in bluetoothctl with "agent on"

Ok, good. It shouldn't make a difference for pairings initiated from the
local side, but just in case, did you also issue "default-agent"?

> > What would give an even better view of what's going on is the HCI logs.
> > You can get those with the btmon tool (found under monitor/ in the BlueZ
> > source tree).
> Here is the output of btmon. Does it mean anything to you?
> ....
> < ACL Data TX: Handle 70 flags 0x00 dlen 11                    [hci0] 28.489379
>       ATT: Read By Group Type Request (0x10) len 6
>         Handle range: 0x0018-0xffff
>         Attribute group type: Primary Service (0x2800)
> > HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 28.559451
>         Num handles: 1
>         Handle: 70
>         Count: 1
> > HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 28.560451
>         Num handles: 1
>         Handle: 70
>         Count: 1
> > ACL Data RX: Handle 70 flags 0x02 dlen 6                     [hci0] 28.628456
>       SMP: Pairing Failed (0x05) len 1
>         Reason: Confirm value failed (0x04)
> < HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0] 28.628506
>         Handle: 70
>         Reason: Authentication Failure (0x05)

To me this looks like the remote either rejected the pairing, or
something else went wrong there. It'd help to see the full HCI log,
particularly from the beginning of the SMP session, i.e. including the
Pairing Request and Response PDUs.

Johan
