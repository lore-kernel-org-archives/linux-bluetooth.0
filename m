Return-Path: <cyrus@holtmann.org>
Message-ID: <5310A4A9.2000907@gmx.net>
Date: Fri, 28 Feb 2014 15:00:57 +0000
From: Benjamin Adler <benadler@gmx.net>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Receiving data in BLE non-connectable undirected advertisements
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello bluez,

as the subject notes, I'm trying to receive non-connectable undirected 
advertisements from a bluetooth low energy device, namely TI's 
SensorTag. Their SDK contains a sample app named SimpleBLEBroadcaster, 
that, supposedly, sends those advertisements including some data. There 
is an overview of TI's understanding of this mechanism for download at

http://e2e.ti.com/support/low_power_rf/m/videos__files/653593/download.aspx

Is it possible to receive/display the *data* (up to 31 bytes, I believe) 
that can be contained in those advertisements using bluez? I currently 
don't care whether it's a commandline tool, C-based API, python, DBUS, 
anything.

When I start SimpleBLEBroadcaster, btmon alone doesn't show anything, 
but "hcitool lescan" says.

	LE Scan ...
	90:59:AF:0B:8A:7D (unknown)

The complete output of a btmon during lescan is attached below.

https://github.com/bmpm/bcast-observer-demos and a script named 
"test-bluetooth-observer" made me believe that there should be an 
org.bluez.Observer interface for this, which I couldn't find using 
qdbusviewer.

I asked on #bluez before, but it seems noone knew.

Thanks!
ben

###################################################################

####### start "btmon"

Bluetooth monitor ver 5.14
= New Index: 00:02:72:33:29:55 (BR/EDR,USB,hci0)             [hci0] 0.377191

####### start "hcitool lescan" in another shell

< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7   [hci0] 4.457403
         Type: Active (0x01)
         Interval: 10.000 msec (0x0010)
         Window: 10.000 msec (0x0010)
         Own address type: Public (0x00)
         Filter policy: Accept all advertisement (0x00)
 > HCI Event: Command Complete (0x0e) plen 4                  [hci0] 
4.458949
       LE Set Scan Parameters (0x08|0x000b) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2       [hci0] 4.459094
         Scanning: Enabled (0x01)
         Filter duplicates: Enabled (0x01)
 > HCI Event: Command Complete (0x0e) plen 4                  [hci0] 
4.459957
       LE Set Scan Enable (0x08|0x000c) ncmd 1
         Status: Success (0x00)

####### Power-on the SensorTag

 > HCI Event: LE Meta Event (0x3e) plen 20                    [hci0] 
9.481376
       LE Advertising Report (0x02)
         Num reports: 1
         Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
         Address type: Public (0x00)
         Address: 90:59:AF:0B:8A:7D (Texas Instruments)
         Data length: 8
         Flags: 0x04
           BR/EDR Not Supported
         Company: not assigned (513)
           Data: 03
         RSSI: -80 dBm (0xb0)

####### Quit hcitool

< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2      [hci0] 20.647504
         Scanning: Disabled (0x00)
         Filter duplicates: Enabled (0x01)
 > HCI Event: Command Complete (0x0e) plen 4                 [hci0] 
20.650124
       LE Set Scan Enable (0x08|0x000c) ncmd 1
         Status: Success (0x00)

#

