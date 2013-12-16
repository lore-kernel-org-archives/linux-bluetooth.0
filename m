Return-Path: <cyrus@holtmann.org>
Message-ID: <52AF228D.1000608@thus.ch>
Date: Mon, 16 Dec 2013 16:55:57 +0100
From: Patrick Valsecchi <patrick@thus.ch>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: RFCOMM connection failing
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm trying to connect my PC:
     Linux ... 3.11.0-14-generic #21-Ubuntu SMP ... x86_64 x86_64 x86_64 
GNU/Linux
     0a5c:2198 Broadcom Corp. Bluetooth 3.0 Device

To connect with my bluetooth dive computer:
     Shearwater Petrel

It fails with a "Transport endpoint is not connected (107)" most of the 
time or go further but seem to have corrupted RFCOMM payload.

If I pass the USB device to a W7 VM (virtualbox) and try from them, the 
communication works like charm.

So I went ahead and sniffed the USB communication in both cases using 
wireshark. The two dumps () can be found here (UsbDumpFrom*.pcapng, can 
be open using wireshark):
https://cloud.thus.ch/public.php?service=files&t=de2eabf30c82efa08cf546ff5045e585

Basically the Linux one is just stopping at frame 203 where it sends a 
RFCOMM SABM, gets the answer and reports an error to the user. The 
windows dump show the same RFCOMM SABM command in frame 191 and gets the 
same answer but continues and everything works.

On IRC aholler told me you guys would prefer to get a btmon dump with 
bluez v5. So I went ahead, installed bluez 5.12 and generated a dump 
(yes, the comm still fails the same way) that you can find in the same 
location as the dumps.

I'm stuck there. Can somebody help me go further?

Thanks
