Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <63DE85F1-67DB-4FF4-94FF-0DEE1EC710FC@sqhead.com>
References: <63DE85F1-67DB-4FF4-94FF-0DEE1EC710FC@sqhead.com>
Date: Tue, 29 Apr 2014 10:56:43 +0300
Message-ID: <CABBYNZ+FqzdtEOHKxHfP5cCcOtMn5GSsiRvG3pzsbN2V6GzeFA@mail.gmail.com>
Subject: Re: Detecting presence and connecting headset when not in pairing mode
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jon Nordby <jon@sqhead.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jon,

On Mon, Apr 28, 2014 at 11:37 PM, Jon Nordby <jon@sqhead.com> wrote:
> Hi,
>
> I’m using BlueZ 4.98 with Ubuntu 12.04 on an embedded device.
> When I power up a BT headset* (A2DP) in pairing mode, the DBus signal DeviceFound is emitted on /org/bluez/PID/hci0
> But, when I power it up in normal modus, I do not see any signals firing on DBus. However, if I use “bt-audio -c MAC” it connects successfully.
>
> How am I supposed to programatically detect that the headset is present and automatically establish a connection with it?
>
> * Testing with a Sony DR-BT200 right now.

You don't, the headset is to one that should reconnect if it doesn't
there might have been some problem when you paired with it.


-- 
Luiz Augusto von Dentz
