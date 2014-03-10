Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1403072307490.21384@orcas.net>
References: <6E6C1573-4744-486B-B2E6-2D3DC45D024B@warski.org>
	<alpine.DEB.2.02.1403072307490.21384@orcas.net>
Date: Mon, 10 Mar 2014 09:21:51 -0400
Message-ID: <CAJdJm_M=qHZFdGRd0B3DTNCJXyraj4+P4aDG6t7y_w76XCXYdA@mail.gmail.com>
Subject: Re: Passive scanning of iBeacons results in a "Data Buffer Overflow"
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Terry Hardie <terryh@orcas.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Terry,

On Sat, Mar 8, 2014 at 3:19 AM, Terry Hardie <terryh@orcas.net> wrote:
> The problem is when running a lescan (hcitool lescan) with a LE device in
> paring mode, which is transmitting a lot of LE Advertising report packets,
> the HCI drivers eventually loses sync. I've traced it down to a duplicate
> USB fragment.

I think your logs show missing USB packets (not duplicated)... More
details below.

> I added some code to btusb_intr_complete to print each urb as it comes up
> from the USB stack. Here's the output for the above problem. Note the extra
> "00 02 c7" -- Should not be there...
>
> Mar  8 06:32:12 arm kernel: [  122.915094] hci1 urb df4a8540 status 0 count
> 16 flags 768
> Mar  8 06:32:12 arm kernel: [  122.915176] hci1 urb contents:  3e 21 02 01
> 00 01 3c 30 05 7c f9 e1 15 02 01 05
> Mar  8 06:32:12 arm kernel: [  122.916004] hci1 urb df4a8540 status 0 count
> 16 flags 768
> Mar  8 06:32:12 arm kernel: [  122.916085] hci1 urb contents:  0d 09 53 63
> 6f 73 63 68 65 20 50 52 4f 58 03 19
> Mar  8 06:32:12 arm kernel: [  122.916985] hci1 urb df4a8540 status 0 count
> 3 flags 768
> Mar  8 06:32:12 arm kernel: [  122.917018] hci1 urb contents:  00 02 c2
> Mar  8 06:32:12 arm kernel: [  122.942995] hci1 urb df4a8540 status 0 count
> 3 flags 768

There is a missing whole 16 byte USB packet right here.

> Mar  8 06:32:12 arm kernel: [  122.943028] hci1 urb contents:  00 02 c7

The bytes above are part of the Advertising data, plus the RSSI (the
last byte) for the truncated packet.

> I used usbmon to do a "sniff" of the USB traffic. Here's a snippet of a
> correct HCI LE Advertising report event, followed by one where the middle
> fragment is repeated (frame 1300 is a repeat) This is a different capture
> from the above example. I can provide the pcap somewhere if needed
>
> No.     Time                       Source                Destination
> Protocol Length Info
>    1291 2014-03-07 02:40:16.942573 host                  3.1
> USB      64     URB_INTERRUPT in
>    1292 2014-03-07 02:40:16.959480 3.1                   host
> HCI_USB  80     Rcvd Fragment
> 3e21020100013c30057cf9e115020105
>    1293 2014-03-07 02:40:16.959624 host                  3.1
> USB      64     URB_INTERRUPT in
>    1294 2014-03-07 02:40:16.960449 3.1                   host
> HCI_USB  80     Rcvd Fragment
> 0d0953636f736368652050524f580319
>    1295 2014-03-07 02:40:16.960546 host                  3.1
> USB      64     URB_INTERRUPT in
>    1296 2014-03-07 02:40:16.961455 3.1                   host
> HCI_EVT  67     Rcvd LE Meta (LE Advertising Report)
> 0002ae
>    1297 2014-03-07 02:40:16.961560 host                  3.1
> USB      64     URB_INTERRUPT in
>    1298 2014-03-07 02:40:16.981627 3.1                   host
> HCI_USB  80     Rcvd Fragment
> 3e21020100013c30057cf9e115020105
>    1299 2014-03-07 02:40:16.981696 host                  3.1
> USB      64     URB_INTERRUPT in
>    1300 2014-03-07 02:40:17.002651 3.1                   host
> HCI_USB  80     Rcvd Fragment
> 3e21020100013c30057cf9e115020105

There are two missing fragments between right here.

>    1301 2014-03-07 02:40:17.002720 host                  3.1
> USB      64     URB_INTERRUPT in
>    1302 2014-03-07 02:40:17.003560 3.1                   host
> HCI_USB  80     Rcvd Fragment
> 0d0953636f736368652050524f580319
>    1303 2014-03-07 02:40:17.003649 host                  3.1
> USB      64     URB_INTERRUPT in
>    1304 2014-03-07 02:40:17.004567 3.1                   host
> HCI_USB  67     Rcvd Fragment
> 0002b5

In summary, it is expected that for devices that don't change address,
the only byte to change is the RSSI (last byte of the last fragment).
That's why the 2 first fragments are usually the same for all
advertising packets.

-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
