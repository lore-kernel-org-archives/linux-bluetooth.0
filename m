Return-Path: <h.frydrych@gmx.de>
Message-ID: <40EFE1DA.4070709@gmx.de>
Date: Sat, 10 Jul 2004 14:32:26 +0200
From: Holger Frydrych <h.frydrych@gmx.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech diNovo hub not recognized?
References: <40EEC9CD.8030003@gmx.de> <1089396942.22528.10.camel@pegasus>	 <40EF0F10.8050302@gmx.de> <1089413516.13519.16.camel@pegasus>	 <40EFABCE.7000503@gmx.de> <1089449283.13519.35.camel@pegasus>	 <40EFB4C7.3040509@gmx.de> <1089451515.13519.49.camel@pegasus>
In-Reply-To: <1089451515.13519.49.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi,


> actually I thought that you enabled auth and encrypt ;)
> 
> Setting auth and encrypt in hcid.conf or with hciconfig sets your device
> into security mode 3 and this is not what you want. The basic security
> mode should be 2 which means service level security. I explained this
> some times, so check the mailing list archive or the Bluetooth spec. for
> more details.

So it really was my fault then, eh? Well, thanks for your time then, and 
I'll go read the archives :)

Just two last questions for clarification:
1. What's the status on hid2hci now? Is it still needed or should it be 
obsolete by now? Because I've read in this mailing list that others do 
not need it anymore, but I can't get it to work without, as described.
2. The usual procedure (as I understand, I'm not much into that 
bluetooth stuff, as may be obvious ;) ) to connect a new bluetooth 
device would be to press its connect button and then the one on the hub, 
right? Well, this does not work, simply because the hub (after hid2hci) 
does no longer react to a press on 'Connect', so I have to manually 
search for new devices via hidd. The diNovo devices seem to 
automatically reconnect when I use them, though, so if that's the way 
it's meant to be currently, then this is ok, I only rarely connect an 
additional device (a cell phone). Just wanted to know.

Ok, so far from my end, I hope I did not pose questions that you already 
had answered more or less recently :)


Best regards

Holger
