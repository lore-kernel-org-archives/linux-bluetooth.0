Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Detecting presence and connecting headset when not in pairing mode
From: Jon Nordby <jon@sqhead.com>
In-Reply-To: <CABBYNZ+FqzdtEOHKxHfP5cCcOtMn5GSsiRvG3pzsbN2V6GzeFA@mail.gmail.com>
Date: Tue, 29 Apr 2014 13:37:46 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <7F93D51C-98BC-4DB3-B438-E3B7ECE1160D@sqhead.com>
References: <63DE85F1-67DB-4FF4-94FF-0DEE1EC710FC@sqhead.com> <CABBYNZ+FqzdtEOHKxHfP5cCcOtMn5GSsiRvG3pzsbN2V6GzeFA@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On 29 Apr 2014, at 09:56, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:

> Hi Jon,

Hi Luiz,

> 
> On Mon, Apr 28, 2014 at 11:37 PM, Jon Nordby <jon@sqhead.com> wrote:
>> Hi,
>> 
>> I’m using BlueZ 4.98 with Ubuntu 12.04 on an embedded device.
>> When I power up a BT headset* (A2DP) in pairing mode, the DBus signal DeviceFound is emitted on /org/bluez/PID/hci0
>> But, when I power it up in normal modus, I do not see any signals firing on DBus. However, if I use “bt-audio -c MAC” it connects successfully.
>> 
>> How am I supposed to programatically detect that the headset is present and automatically establish a connection with it?
>> 
>> * Testing with a Sony DR-BT200 right now.
> 
> You don't, the headset is to one that should reconnect if it doesn't
> there might have been some problem when you paired with it.

Ok. Does this require having a bluez agent running in addition to bluetoothd? If so, which should I use on an embedded system (no UI/session)?
