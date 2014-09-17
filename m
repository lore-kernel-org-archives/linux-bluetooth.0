Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RFC] need for new scan api for bluetooth low energy.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD0=r8yozB8eMdJOuffUeQZVFVf5xEXnP5tCt+k3m0e9wzMxiA@mail.gmail.com>
Date: Tue, 16 Sep 2014 21:39:52 -0700
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Scott James Remnant <keybuk@google.com>,
	Arman Uguray <armansito@google.com>
Message-Id: <735FD32E-BD15-4CE1-8D9C-44B8EC56DF7A@holtmann.org>
References: <CAD0=r8yozB8eMdJOuffUeQZVFVf5xEXnP5tCt+k3m0e9wzMxiA@mail.gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> The way MGMT_OP_START_DISCOVERY work right now is:
> - it return information about each device only once by sending
> MGMT_EV_DEVICE_FOUND
> - it allows only for active scanning
> - After DISCOV_LE_TIMEOUT or DISCOV_INTERLEAVED_TIMEOUT the discovery
> is automatically stopped
> - If you restart discovery, you will again get MGMT_EV_DEVICE_FOUND
> for each found device.
> 
> This is not good for Bluetooth Low Energy because:
> - there is a wide range of connectionless devices that sends data in
> advertisement, and there is no way to get each advertisement using
> Management api right now, - for LE devices that you aren't connected
> to you get RSSI value only once every DISCOV_LE_TIMEOUT, that is once
> every 10 seconds, which is too infrequently to be useful for many use
> cases, - for many LE applications passive scanning is enough, and it
> uses less energy
> 
> I want to propose changing existing or creating new API that will
> allow to start passive or active low energy scanning, and receive
> event for each advertisement packet including its content and RSSI
> value.

have you looked at the the Add Device management command with the 0x00 Action. That will just send out Device Found events for devices in range and uses passive scanning.

In addition if you are paired with a device and actually want to connect to it, you can use Action 0x02 to allow for background connection. This is currently in use for LE HID devices.

Regards

Marcel

