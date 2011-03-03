Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4D6FD0E9.1020602@csr.com>
References: <4D6FD0E9.1020602@csr.com>
Date: Thu, 3 Mar 2011 13:51:54 -0400
Message-ID: <AANLkTimitfowt25Ncih8Hh=TH-i3NNRhAsxyeQief9CO@mail.gmail.com>
Subject: Re: D-Bus for LE
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marco Sinigaglia <marco.sinigaglia@csr.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Mar 3, 2011 at 1:33 PM, Marco Sinigaglia
<marco.sinigaglia@csr.com> wrote:
> Hi All,
>
> I am looking the D-Bus API for low energy and I cannot find a way to run a
> discover for LE devices and connect to them.
> Are these API implemented? if not, are they going to be?
>
>
> Looking the attribute-api it should be possible to do some stuff on the
> local device but, on my box, it looks like not working.
> I am sure that the blutoothd is kicking off the attribute server (sdptool is
> showing the le profiles), nevertheless the test-attrib is showing nothing:
>
>>sudo ./test-attrib  -i hci0
> [nothing]

Did you connect to the remote first using "test-device create" ? Also
make sure the remote is advertising with Flags = 0x06 (bits "BR/EDR
not supported" and "general discoverable mode") if the remove is dual
mode, otherwise it will attempt a BR/EDR connection.

In summary:

1) On the remote device enable advertising and (if a dual mode) set
flags to 0x06:

hcitool -i hciX cmd 0x08 0x0008 03 02 01 06
hciconfig hciX leadv

2) on the local side, start discovery (so the adv data is saved by
bluez) followed by test-device create:

test-discovery (wait for it to finish or at least show the device you
will connect to)
test-device create <bdaddr>

3) not the tricky part: you need to reenable advertising on the remote
side (see step #1) for test-attrib to work. This is because remote
disabled advertising after the LE connection during test-device create
was done, and IIRC test-device create does not keep connection open.
test-attrib will them open a new connection which only works with
advertising enabled on remote side.

3) you can now run test-attrib:

./test-attrib -i hciX

Note this API is ongoing some changes and most of the steps above will
be automatic. See the "TODO" file on BlueZ source for the planned
changes.

HTH,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
