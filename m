Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 9 Jun 2016 20:18:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Tom Harada <tomharada@lnihealth.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Privacy mode breaking BLE reconnects
Message-ID: <20160609171845.GA19799@t440s.P-661HNU-F1>
References: <2cd3f83d-6057-c813-4eaf-50a39d4e85a7@lnihealth.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2cd3f83d-6057-c813-4eaf-50a39d4e85a7@lnihealth.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom,

On Thu, Jun 09, 2016, Tom Harada wrote:
> I have a particular device that requires an IRK from BlueZ during pairing.
> To my limited understanding this is wrong since my Bluetooth adapter uses a
> public address by default, but I have to live with it in any case. I've
> found that turning on privacy mode using `btmgmt privacy on` allows BlueZ to
> pair with the device. However, it also prevents reconnecting to any
> already-paired BLE device, even if privacy mode was enabled when I paired
> with it.
> 
> This is the sequence of events:
> 1. Pair with a BLE device.
> 2. Power off the adapter, run `btmgmt privacy on`, and power the adapter
> back on.
> 3. Connect to the device. The connection fails with the status "Connection
> Failed to be Established" in the LE Read Remote Used Features HCI event.

First of all, btmgmt is mainly intended for testing. Its privacy command
creates a new random IRK every time so you can't really use it to create
persistent pairings. You could get a little bit better behavior by
giving the command a third parameter which btmgmt will interpret as a
hex encoded IRK value. This is still just a "testing" style solution
however.

Secondly, the IRK is distributed during pairing, so pairing first and
only then setting the IRK (with btmgmt) wont work, since the remote
device wont then have your IRK and will be unable to authenticate you
when you connect using a random address.

Right now we're missing proper privacy support in BlueZ in the sense
that bluetoothd would manage it. The way it should work is that
bluetoothd maintains a persistently stored IRK on the file system and
reloads it to the kernel when started. If you're interested to
contribute something like that patches are welcome :)

Johan
