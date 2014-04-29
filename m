Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Detecting presence and connecting headset when not in pairing mode
From: Jon Nordby <jon@sqhead.com>
In-Reply-To: <CABBYNZ+apmq_Py+GezpkbUUth8fVaNiqhX49HVEzHJ=LreRKwQ@mail.gmail.com>
Date: Tue, 29 Apr 2014 14:27:04 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <3BC57795-9846-44D0-9E8F-03F61900B14D@sqhead.com>
References: <63DE85F1-67DB-4FF4-94FF-0DEE1EC710FC@sqhead.com> <CABBYNZ+FqzdtEOHKxHfP5cCcOtMn5GSsiRvG3pzsbN2V6GzeFA@mail.gmail.com> <7F93D51C-98BC-4DB3-B438-E3B7ECE1160D@sqhead.com> <CABBYNZ+apmq_Py+GezpkbUUth8fVaNiqhX49HVEzHJ=LreRKwQ@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On 29 Apr 2014, at 14:15, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:

> Hi Jon,
> 
> On Tue, Apr 29, 2014 at 2:37 PM, Jon Nordby <jon@sqhead.com> wrote:
>> 
>> On 29 Apr 2014, at 09:56, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>> 
>>> Hi Jon,
>> 
>> Hi Luiz,
>> 
>>> 
>>> On Mon, Apr 28, 2014 at 11:37 PM, Jon Nordby <jon@sqhead.com> wrote:
>>>> Hi,
>>>> 
>>>> I’m using BlueZ 4.98 with Ubuntu 12.04 on an embedded device.
>>>> When I power up a BT headset* (A2DP) in pairing mode, the DBus signal DeviceFound is emitted on /org/bluez/PID/hci0
>>>> But, when I power it up in normal modus, I do not see any signals firing on DBus. However, if I use “bt-audio -c MAC” it connects successfully.
>>>> 
>>>> How am I supposed to programatically detect that the headset is present and automatically establish a connection with it?
>>>> 
>>>> * Testing with a Sony DR-BT200 right now.
>>> 
>>> You don't, the headset is to one that should reconnect if it doesn't
>>> there might have been some problem when you paired with it.
>> 
>> Ok. Does this require having a bluez agent running in addition to bluetoothd? If so, which should I use on an embedded system (no UI/session)?
> 
> Yes, the agent is required for pairing since the user has to
> authenticate, you can however automate the process by registering an
> agent with NoInputNoOutput (e.g. simple-agent -c NoInputNoOutput) this
> will cause just works paring if supported (requires Bluetooth 2.1 >).

And is the agent required to be running when the device is already paired (to automatically connect)?