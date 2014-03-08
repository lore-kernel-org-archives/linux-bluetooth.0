Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Mar 2014 23:19:49 -0800 (PST)
From: Terry Hardie <terryh@orcas.net>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Passive scanning of iBeacons results in a "Data Buffer
 Overflow"
Message-ID: <alpine.DEB.2.02.1403072307490.21384@orcas.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
References: <6E6C1573-4744-486B-B2E6-2D3DC45D024B@warski.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

I'm having something similar to what Adam is reporting. I'm running on a 
BeagleBone Black, which uses a TI MUSB controller (I think it's different 
to the Raspberry Pi USB controller?).

I have 2 vendor's USB bluetooth receivers.

One is a Cambridge Silicon Radio (0a12:0001) and the other is a Broadcom 
BCM20702A1 (0a5c:21e8). The Broadcom needs a RAM patch to behave slightly 
better, but it outside the scope of this problem. BOTH exhibit the same 
problem (so I seriously doubt it's a problem with the Bluetooth receivers)

Both devices are operating in HCI mode. I'm running Ubuntu on my 
BeagleBone Black.

I've also built the latest version of Bluez (5.15)

The problem is when running a lescan (hcitool lescan) with a LE device in 
paring mode, which is transmitting a lot of LE Advertising report packets, 
the HCI drivers eventually loses sync. I've traced it down to a duplicate 
USB fragment.

I've tested these USB receivers under Ubuntu on an Intel machine with the 
same Bluez 5.15, and the problem is not present.

hcidump shows when things go crazy:

2014-03-08 06:32:12.111970 > HCI Event: LE Meta Event (0x3e) plen 33
     LE Advertising Report
       ADV_IND - Connectable undirected advertising (0)
       bdaddr E1:F9:7C:05:30:3C (Random)
       Flags: 0x05
       Complete local name: 'Scosche PROX'
       Unknown type 0x19 with 2 bytes data
       RSSI: -62
2014-03-08 06:32:12.163087 > HCI Event: Unknown (0x00) plen 2
   C7 3E
2014-03-08 06:32:12.163136 > HCI Event: Flow Specification Complete (0x21) 
plen 2
     status 0x01 handle 0x0000 flags 1 incoming
     Error: Unknown HCI Command
2014-03-08 06:32:12.192009 > HCI Event: Inquiry Complete (0x01) plen 60
     status 0x30
     Error: Parameter out of Mandatory Range
     05 7C F9 E1 15 02 01 05 0D 09 53 63 6F 73 63 68 65 20 50 52
     4F 58 03 19 00 02 C5 3E 21 02 01 00 01 3C 30 05 7C F9 E1 15
     02 01 05 0D 09 53 63 6F 73 63 68 65 20 50 52 4F 58 03 19
2014-03-08 06:32:12.218055 > HCI Event: Unknown (0x00) plen 2
   C5 3E

I added some code to btusb_intr_complete to print each urb as it comes up 
from the USB stack. Here's the output for the above problem. Note the 
extra "00 02 c7" -- Should not be there...

Mar  8 06:32:12 arm kernel: [  122.915094] hci1 urb df4a8540 status 0 count 16 flags 768
Mar  8 06:32:12 arm kernel: [  122.915176] hci1 urb contents:  3e 21 02 01 00 01 3c 30 05 7c f9 e1 15 02 01 05
Mar  8 06:32:12 arm kernel: [  122.916004] hci1 urb df4a8540 status 0 count 16 flags 768
Mar  8 06:32:12 arm kernel: [  122.916085] hci1 urb contents:  0d 09 53 63 6f 73 63 68 65 20 50 52 4f 58 03 19
Mar  8 06:32:12 arm kernel: [  122.916985] hci1 urb df4a8540 status 0 count 3 flags 768
Mar  8 06:32:12 arm kernel: [  122.917018] hci1 urb contents:  00 02 c2
Mar  8 06:32:12 arm kernel: [  122.942995] hci1 urb df4a8540 status 0 count 3 flags 768
Mar  8 06:32:12 arm kernel: [  122.943028] hci1 urb contents:  00 02 c7

I used usbmon to do a "sniff" of the USB traffic. Here's a snippet of a 
correct HCI LE Advertising report event, followed by one where the middle 
fragment is repeated (frame 1300 is a repeat) This is a different capture 
from the above example. I can provide the pcap somewhere if needed

No.     Time                       Source                Destination           Protocol Length Info
    1291 2014-03-07 02:40:16.942573 host                  3.1                   USB      64     URB_INTERRUPT in
    1292 2014-03-07 02:40:16.959480 3.1                   host                  HCI_USB  80     Rcvd Fragment
3e21020100013c30057cf9e115020105
    1293 2014-03-07 02:40:16.959624 host                  3.1                   USB      64     URB_INTERRUPT in
    1294 2014-03-07 02:40:16.960449 3.1                   host                  HCI_USB  80     Rcvd Fragment
0d0953636f736368652050524f580319
    1295 2014-03-07 02:40:16.960546 host                  3.1                   USB      64     URB_INTERRUPT in
    1296 2014-03-07 02:40:16.961455 3.1                   host                  HCI_EVT  67     Rcvd LE Meta (LE Advertising Report)
0002ae
    1297 2014-03-07 02:40:16.961560 host                  3.1                   USB      64     URB_INTERRUPT in
    1298 2014-03-07 02:40:16.981627 3.1                   host                  HCI_USB  80     Rcvd Fragment
3e21020100013c30057cf9e115020105
    1299 2014-03-07 02:40:16.981696 host                  3.1                   USB      64     URB_INTERRUPT in
    1300 2014-03-07 02:40:17.002651 3.1                   host                  HCI_USB  80     Rcvd Fragment
3e21020100013c30057cf9e115020105
    1301 2014-03-07 02:40:17.002720 host                  3.1                   USB      64     URB_INTERRUPT in
    1302 2014-03-07 02:40:17.003560 3.1                   host                  HCI_USB  80     Rcvd Fragment
0d0953636f736368652050524f580319
    1303 2014-03-07 02:40:17.003649 host                  3.1                   USB      64     URB_INTERRUPT in
    1304 2014-03-07 02:40:17.004567 3.1                   host                  HCI_USB  67     Rcvd Fragment
0002b5


