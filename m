Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 16 Sep 2014 20:30:07 -0700
Message-ID: <CAD0=r8yozB8eMdJOuffUeQZVFVf5xEXnP5tCt+k3m0e9wzMxiA@mail.gmail.com>
Subject: [RFC] need for new scan api for bluetooth low energy.
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Scott James Remnant <keybuk@google.com>,
	Arman Uguray <armansito@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The way MGMT_OP_START_DISCOVERY work right now is:
- it return information about each device only once by sending
MGMT_EV_DEVICE_FOUND
- it allows only for active scanning
- After DISCOV_LE_TIMEOUT or DISCOV_INTERLEAVED_TIMEOUT the discovery
is automatically stopped
- If you restart discovery, you will again get MGMT_EV_DEVICE_FOUND
for each found device.

This is not good for Bluetooth Low Energy because:
- there is a wide range of connectionless devices that sends data in
advertisement, and there is no way to get each advertisement using
Management api right now, - for LE devices that you aren't connected
to you get RSSI value only once every DISCOV_LE_TIMEOUT, that is once
every 10 seconds, which is too infrequently to be useful for many use
cases, - for many LE applications passive scanning is enough, and it
uses less energy

I want to propose changing existing or creating new API that will
allow to start passive or active low energy scanning, and receive
event for each advertisement packet including its content and RSSI
value.
