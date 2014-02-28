Return-Path: <cyrus@holtmann.org>
Message-ID: <5310AD83.9030208@gmx.net>
Date: Fri, 28 Feb 2014 15:38:43 +0000
From: Benjamin Adler <benadler@gmx.net>
MIME-Version: 1.0
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Receiving data in BLE non-connectable undirected advertisements
References: <5310A4A9.2000907@gmx.net> <00B030ED-78C3-4C48-B738-4161348CD6E8@warski.org>
In-Reply-To: <00B030ED-78C3-4C48-B738-4161348CD6E8@warski.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adam,

thanks for your answer!

On 28.02.2014 15:13, Adam Warski wrote:
> If you want to see the raw advertisement packets, run:
> 1st terminal: hcidump -R
> 2nd terminal: hcitool lescan
> The raw dump will contain the advertisement data.

# hcidump -R
HCI sniffer - Bluetooth packet analyzer ver 5.14
device: hci0 snap_len: 1500 filter: 0xffffffffffffffff

### start "hcitool lescan"

< 01 0B 20 07 01 10 00 10 00 00 00
 > 04 0E 04 01 0B 20 00
< 01 0C 20 02 01 01
 > 04 0E 04 01 0C 20 00

### power-on sensortag

 > 04 3E 14 02 01 03 00 7D 8A 0B AF 59 90 08 02 01 04 04 FF 01
   02 03 B7

### power-cycle sensortag

<nothing>

So it seems like hcitool must first tell bluez to listen for 
advertisement packets. Is there documentation/samples on how to do this 
with python or C? Any other programs that do this, so I can read their 
source?

Also, only the first advertisement of the SensorTag is shown. While that 
probably makes sense for traditional advertisements, my use case 
requires that all advertisements are shown, as I'm trying to transmit 
low-rate data from the tag's sensors in the advertisements.

Do you have some hints concerning the easiest way to receive and process 
those advertisements, preferably without the hassle of user-interaction 
and multiple terminals?

Cheers,
ben
