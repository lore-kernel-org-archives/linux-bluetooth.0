Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Jul 2011 11:44:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "W.P." <laurentp@wp.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: pairing device in text mode
Message-ID: <20110701084439.GA6461@dell.ger.corp.intel.com>
References: <4E0D82DA.7090501@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E0D82DA.7090501@wp.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jul 01, 2011, W.P. wrote:
> How can I do this in text mode?

You can pair with "simple-agent hci0 <remote address>". To simply create
a new device object without pairing you can use "test-device create
<remote address>". Once you've created the object you can connect HID to
the device with "test-input connect <remote address". To make it
possible for the remote device to connect back to you later without user
interaction do "test-device trusted <remote address> yes". simple-agent,
test-input and test-device can be found under the test subdirectory in
the source tree.

> (mouse does not require PIN)

That doesn't make any sense. A PIN is a mandatory input parameter to the
pairing process with any Bluetooth 2.0 or older device. Or do you mean
to say that the mouse doesn't require pairing at all?

Johan
