Return-Path: <cyrus@holtmann.org>
From: "Caleb Reinhold" <creinhold@lampreynetworks.com>
To: <linux-bluetooth@vger.kernel.org>
References: 
In-Reply-To: 
Subject: possible bug in blueZ 5.8 gatt tool or library
Date: Tue, 4 Feb 2014 16:08:27 -0500
Message-ID: <000001cf21ed$47f52e50$d7df8af0$@lampreynetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,

I am participating in an effort to make use of the BlueZ libraries to pull
data from Bluetooth Low Energy health devices. 
We are working with the 5.8 version of the library, kernel version 3.12.9,
bluetoothctl, and gatttool when we encountered a possible error.
We expected on the reconnection of two bonded devices, one of which had
stored measurements, that data would transfer. When running gatt tool in
medium security the first measurement to be indicated was lost.
First we used Bluetooth control to pair with the simulated agent device (a
thermometer). Then we disconnected with bluetoothctl and connected with
gatttool in order to write to the C3D (client characteristic configuration
descriptors). After setting the C3D to indicate, we transferred a
measurement successfully.  Up until this point we saw no unexpected
difference in behavior between low and medium security on the gatttool.
However upon attempting to reconnect to the simulated agent device with
medium security two unexpected behaviors occurred. First, and more
immediately apparent was that the simulated agent did not receive a
confirmation of the indication. A slightly closer look using the hcidump,
trying to find what had happened, showed that the indication had arrived at
the hci layer but was not received at events_handler.  While the indication
is sent very swiftly upon the reconnection of the devices we understand this
to be the manner in which low energy devices are supposed to behave given
stored measurements and a bonded device.
Records of hcidumps are attached.

Caleb Reinhold

