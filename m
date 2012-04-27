Return-Path: <cyrus@holtmann.org>
Message-Id: <201204271541.q3RFfVd5006035@imr-da04.mx.aol.com>
Date: Fri, 27 Apr 2012 11:40:58 -0400
From: Kal Torak <chronognosis@aim.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: main.conf issues
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, When I setup the main.conf with the values for Name, Class,
PairableTimeout and DiscoverableTimeout, and restart the bluetoothd,
hciconfig shows that nothing change name still the same, I cant "see"
the device from the outside(iscan is disabled), and the class still
0x000100, and I must re-do hciconfig hci name #### class #### and
hciconfig hci0 piscan by hand to make the device visible and try
streaming support, OTOH I just can't see and/or connect to the device.
a ConWise 6622 Bluetooth dongle.
I'm using bluez-4.99 and linux 3.2.15.Any information will be usefull...

Regards, 
Torak
