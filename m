Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <ext.szymon.janc@tieto.com>
To: Another Sillyname <anothersname@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Multiple dongles...how to prioritise
Date: Thu, 17 Dec 2015 14:43:31 +0100
Message-ID: <20721420.im42bRLFJ9@leonov>
In-Reply-To: <CAOS+5GFM6trQP9o+YrsnZVoy2-KEvYxWRNr074OoXQAsTDd8fQ@mail.gmail.com>
References: <CAOS+5GFM6trQP9o+YrsnZVoy2-KEvYxWRNr074OoXQAsTDd8fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thursday 17 of December 2015 12:55:25 Another Sillyname wrote:
> Firstly can I apologise if this is meant purely as a developer list,
> the bluez website directs end users to this list as the place for
> help.
> 
> I have a PC with an inbuilt Intel AC7260 combo wifi/BT card.  This
> card will NOT support the HID profile and appears as hci0.
> 
> I want to use my BT keyboard and mouse on a multi boot machine and
> have spent the last few days getting this working across different OS
> boots.
> 
> However now adding a DBT-120 dongle flashed to HID firmware works fine
> once linux loads and I logon.....however I cannot enter the password
> to the logon screen unless I remote to the box and hciconfig hci1 up,
> I realise I could script this but would rather the DBT-120 was hci0 so
> it would happen by default.
> 
> Is there a way to 'force' dongles to load in a specific order?

I don't think there is a way to pin USB BT dongle to specific hciX.
 
> Thanks in advance

You may check AutoEnable option in policy section of main.conf file.
Setting it to true should auto enable (any) dongle after it is initialized by 
bluetoothd.


-- 
BR
Szymon Janc
