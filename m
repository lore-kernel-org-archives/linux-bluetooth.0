Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Dec 2009 08:04:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: nirav rabara <niravrabara@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: How to auto connect Headset (on power ON)
Message-ID: <20091202060401.GA1862@jh-x301>
References: <912bb79a0912012101k16ac6689s5afcc7135a755ca3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <912bb79a0912012101k16ac6689s5afcc7135a755ca3@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nirav,

On Wed, Dec 02, 2009, nirav rabara wrote:
> I am using simple-agent for pairing.
> Once the pairing has done, If I turn OFF the headset and again turn ON
> it, headset trying to connect with my adapter but cannot connect and
> shows following debug
> 
> bluetoothd[804]: adapter_get_device(00:02:5B:00:AA:A5)
> bluetoothd[804]: adapter_creat_device(00:02:5B:00:AA:A5)
> bluetoothd[804]: creating device /org/bluez/804/hci0/dev_00_02_5B_00_A5_A5
> bluetoothd[804]: btd_device_ref(0x2a06c658): ref=1
> bluetoothd[804]: link_key_request (sba=00:15:83:0C:16:BF, bda=00:02:5B:00:AA:A5)
> bluetoothd[804]: kernel auth requirement = 0x00
> bluetoothd[804]: pin_code_request (sba=00:15:83:0C:16:BF, bda=00:02:5B:00:AA:A5)
> bluetoothd[804]: adapter_get_device(00:02:5B:00:AA:A5)
> bluetoothd[804]: /org/bluez/804/hci0/dev_00_02_5B_00_A5_A5: requesting
> agent authentication
> bluetoothd[804]: No agent available for 0 request
> bluetoothd[804]: Removing temporary device
> /org/bluez/804/hci0/dev_00_02_5B_00_A5_A5
> bluetoothd[804]: Removing device /org/bluez/804/hci0/dev_00_02_5B_00_A5_A5
> bluetoothd[804]: btd_device_unref(0x2a06c658): ref=0
> bluetoothd[804]: device_free(0x2a06c658)
> 
> > "bluetoothd[804]: No agent available for 0 request" Is there any separate agent required ?
> 
> Can anybody suggest me how to auto connect headset with adapter on power on.

It seems that the original pairing was for some reason not stored on
your computer and so there's a new PIN request when the headset connects
to you but no agent to forward that request to. In general it's a good
idea to always keep an agent running in case of unexpected
authentication or authorization requests. If you don't have a GUI you
could e.g. keep simple-agent running (without any parameters) to act in
this kind of passive mode.

Even once the pairing is successfull you'll probably also want to avoid
the authorization part through the agent and you can do that by making
sure the headset is set as trusted (in D-Bus terms you set the Trusted
property to true). From the command line you can do that e.g. with
"test/test-device trusted <bt address> yes".

Johan
