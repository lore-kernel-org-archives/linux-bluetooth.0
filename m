Return-Path: <cyrus@holtmann.org>
Message-ID: <4AD884D7.6020404@start.ca>
Date: Fri, 16 Oct 2009 10:36:07 -0400
From: Colin Beckingham <colbec@start.ca>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Bluetooth signals "Unable to open seid 64"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Using Suse 11.1
Bluez 4.54
Blueman from svn 602
Pulseaudio 0.9.19
Hardware Jabra BT2040 headset and adapter dongle MSI Starkey

Blueman is able to open a link to the headset and start the headset 
service, shortly after this there is a message from pulseaudio that 
something has gone awry with the audio link.

bluetoothd -nd has much output including the following which seems relevant:

bluetoothd[26861]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[26861]: open sco - 
object=/org/bluez/26861/hci0/dev_00_1A_45_32_E7_16 source=ANY 
destination=ANY lock=readwrite
bluetoothd[26861]: Unable to open seid 64
bluetoothd[26861]: sending error Invalid argument(22)
bluetoothd[26861]: Audio API: BT_ERROR -> BT_OPEN
bluetoothd[26861]: Unix client disconnected (fd=31)

Does this mean anything to the bluetooth community? Suggestions welcome.
