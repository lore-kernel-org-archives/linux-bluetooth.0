Return-Path: <jsantos_pt@hotmail.com>
From: "João Santos" <jsantos_pt@hotmail.com>
To: marcel@holtmann.org
Cc: bluez-users@lists.sourceforge.net
Subject: Re: hci goes down
Date: Tue, 02 Mar 2004 16:53:42 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F4627YoYkdh0cX00047c34@hotmail.com>
List-ID: <bluez-users.lists.sourceforge.net>

Hi marcel,

>SCO data: handle 0x002c dlen 144
>SCO data: handle 0x002c dlen 144
>SCO data: handle 0x002c dlen 144
>SCO data: handle 0x002c dlen 144
>SCO data: handle 0x002c dlen 144
>SCO data: handle 0x002c dlen 144
>SCO data: handle 0x002c dlen 144
>SCO data: handle 0x002c dlen 144
>SCO data: handle 0x002c dlen 144
>SCO data: handle 0x002c dlen 144
>SCO data: handle 0x002c dlen 144
Receive failed: Broken pipe


>can be a bad USB host controller (some VIA or SIS had problems) or it is
>the wrong host controller driver (try the other one). And of course the
>disconnect came from the phone, so maybe only listening on the RFCOMM
>channel is not enough and you must fulfill all AT commands for the
>Headset or Handsfree profile.

Using the hstest i had record some speech from the phone, but after that the 
hci goes down. Could the problem be caused by the software.
I couldn't send any at commands after i made a rfcomm to channel 12, because 
i start receving sco data, and after a while hci goes down.

Sorry about the stupid question, but host controller driver is the hci, 
right?
When i start using the bluez i remember that when i use hciconfig it appears 
hci0 and hci1, but now it only appears hci0.

Thanks

João Santos

_________________________________________________________________
Fast. Reliable. Get MSN 9 Dial-up - 1 month FREE! (Limited-time Offer) 
http://click.atdmt.com/AVE/go/onm00200361ave/direct/01/
