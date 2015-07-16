Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACsJT9NNM2FvBRkP_DWD3Om6RC_xx3MBH2Er5dbUSyOmPcoyHg@mail.gmail.com>
References: <CACsJT9N+saPgDKjXFGkr7fn=M=8s_h2fTSmPCznwahC7f6eeOQ@mail.gmail.com>
	<CACsJT9NNM2FvBRkP_DWD3Om6RC_xx3MBH2Er5dbUSyOmPcoyHg@mail.gmail.com>
Date: Thu, 16 Jul 2015 15:47:10 +0300
Message-ID: <CABBYNZJv2_ZcShhMXusCBW+9CE4o371jUrV2TEfFJF46XHDUkA@mail.gmail.com>
Subject: Re: UsermodeHID uncertainty
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mike Purvis <mpurvis@clearpathrobotics.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

On Wed, Jul 15, 2015 at 6:10 PM, Mike Purvis
<mpurvis@clearpathrobotics.com> wrote:
>> - What is the usermode process? Do I have to start it somehow, or does
>> it start on its own? Is it an already running daemon?

bluetoothd will be in charge since after all UserspaceHID (not
UsermodeHID) is part of its input.conf.

>> - What is the communication channel between the kernel and user
>> process, and how can I listen in on the traffic?

It communicates using uhid/uhid2, check Linux Documentation for more
details. You can listen the L2CAP traffic using btmon, hcidump or
wireshark, but they probably wont decode the HID protocol

>> - Is the usermode process directly managing things like devfs nodes
>> (eg, /dev/input/js0), or does it communicate back to the kernel for
>> that?

Nope, uhid does that in the kernel, bluetoothd only forward the
descriptors it gets over L2CAP.

>> - As a user, what are my options for swapping out the usermode process
>> if I want to modify its behaviour? For example, handling disconnects
>> or pairing in a different manner than the default?

bluetoothd will take care of paring, etc, of course you can change the
logic by changing BlueZ's source code, but be aware things like paring
is subject of Bluetooth Qualification which is something BlueZ has
passed many times.




-- 
Luiz Augusto von Dentz
