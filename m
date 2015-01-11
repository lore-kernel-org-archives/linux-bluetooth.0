Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: Replacement for rfcomm.conf
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <54B272A8.4000105@farce.de>
Date: Sun, 11 Jan 2015 14:41:09 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <61857A98-EF57-4478-83B8-74DD691164ED@holtmann.org>
References: <54B272A8.4000105@farce.de>
To: Stefan Wiehler <sephalon@farce.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

> I recently added a Bluetooth dongle to a RS232 device to get readouts
> from a remote location. This is working fine as long as I execute
> "rfcomm bind" after each restart.
> 
> However, when I wanted to automate this process by using a rfcomm.conf
> file as suggested by several guides on the web [1], I realized that the
> corresponding code has been removed from the rfcomm tool several years
> ago [2].
> 
> I tried to use udev as a replacement by writing a rule which executes
> rfcomm after pairing, but it seems like sysfs does not expose
> information about coupled devices (udevadm info -a -p
> /sys/class/bluetooth/hci0).
> 
> Is it possible to solve that problem using udev? Or are there any other
> best practices? Thank you for your consideration.

just create an init script of systemd service file and run the rfcomm bind command manually. As long as you know the remote BD_ADDR of the device you want to connect to and the RFCOMM channel of the SSP service on that device, you can create a binding. No local controller has to be present to create a RFCOMM binding.

Regards

Marcel

