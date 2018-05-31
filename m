Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH] Allow bluetoothd to call methods on dbus' system bus
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <8ae38491-75b4-b230-2232-fd12a4bd7b7a@interia.pl>
 <CABBYNZKBMp_6EPAH8D50w99NMYg9tGySuyHTJrB3+pqdSagBag@mail.gmail.com>
From: =?UTF-8?Q?Rafa=c5=82_Bilski?= <rafalbilski@interia.pl>
Message-ID: <60cc1f5d-032b-2c54-a90f-a7efd84ffa0a@interia.pl>
Date: Thu, 31 May 2018 18:02:02 +0100
MIME-Version: 1.0
In-Reply-To: <CABBYNZKBMp_6EPAH8D50w99NMYg9tGySuyHTJrB3+pqdSagBag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> Hi Rafal,
>
> On Thu, May 31, 2018 at 1:26 AM, Rafał Bilski <rafalbilski@interia.pl> wrote:
>> Default dbus configuration doesn't allow calling methods on system bus. Only
>> sending signals is allowed.
>> If "mpris-proxy" isn't running "/usr/lib/gsd-media-keys" translates
>> keystrokes from "profiles/audio/avctp.c:handle_panel_passthrough()"
>> to dbus method calls on session bus. This is allowed on dbus by default.
>> If "mpris-proxy" is running "bluetoothd" executes dbus' method calls on
>> system bus.  These apparently are rejected by default.
>>
>> diff --git a/src/bluetooth.conf b/src/bluetooth.conf
>> index 0c0b221bb..1cafab631 100644
>> --- a/src/bluetooth.conf
>> +++ b/src/bluetooth.conf
>> @@ -8,6 +8,7 @@
>>     <!-- ../system.conf have denied everything, so we just punch some holes
>> -->
>>      <policy user="root">
>> +    <allow send_type="method_call"/>
>>       <allow own="org.bluez"/>
>>       <allow send_destination="org.bluez"/>
>>       <allow send_interface="org.bluez.Agent1"/>
>>
> I think the correct fix would be to add the interface
> (org.mpris.MediaPlayer2.Player) we are using to communicate with the
> player.
>
Hi,

You're right. Your approach works fine.


Thank you

Rafal Bilski


