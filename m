Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: DBUS API error "Not paired" when attempting to read GATT
 characteristic
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <5728C5DA.7000703@gmail.com>
 <CABBYNZLiv7uY-i3W+TcieskEQqrxC6Y0pUkFatDSqL_wrsnHpg@mail.gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Joe Glancy <joe.t.glancy@gmail.com>
Message-ID: <572B7FC7.7020502@gmail.com>
Date: Thu, 5 May 2016 18:15:51 +0100
MIME-Version: 1.0
In-Reply-To: <CABBYNZLiv7uY-i3W+TcieskEQqrxC6Y0pUkFatDSqL_wrsnHpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz,

> How you are actually testing this, perhaps you should try using bluetoothctl:
>
>> agent on
>> default-agent
>> pair <address>

Unfortunately, with the above `agent` commands the device does not pair, 
and instead hangs. The btmon logs for the following three scenarios are 
available at 
https://gist.github.com/JoeGlancy/a5486660f2f59c627b6da32c810927f9:

  - pairing the device through Ubuntu's default Bluetooth manager
  - pairing the device through bluetoothctl without issuing the above 
`agent on`/`default-agent` commands
  - pairing the device through bluetoothctl, issuing the above `agent 
on`/`default-agent` commands before issuing the pair command.
