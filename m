Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <ac8af0be0904091937w32a4cf47p97a439e46eae59b6@mail.gmail.com>
References: <1239180415-29327-1-git-send-email-forrest.zhao@gmail.com>
	 <20090408122812.GA8827@localhost>
	 <d4d7098f0904091014v74bf03d2ne33245e86fc1599d@mail.gmail.com>
	 <ac8af0be0904091937w32a4cf47p97a439e46eae59b6@mail.gmail.com>
Date: Fri, 10 Apr 2009 11:30:14 +0530
Message-ID: <d4d7098f0904092300t300bce4bw59c78c73247eea3e@mail.gmail.com>
Subject: Re: [PATCH 4/4] IPC integration part for HFP Audio gateway -- take5
From: Rajan Batra <rajan.batra@gmail.com>
To: Zhao Forrest <forrest.zhao@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Did you use the latest version of PA?
    when  i restart my machine. pulseaudio daemon is by default
running. i havent done any setting to use PA for bluez nor loaded any
bluetooth modules in PA.

so this means i am not using PA for bluez rite ?  so  i guess all
should go to ALSA

thanks.
-rajan



On Fri, Apr 10, 2009 at 8:07 AM, Zhao Forrest <forrest.zhao@gmail.com> wrote:
> On Fri, Apr 10, 2009 at 1:14 AM, Rajan Batra <rajan.batra@gmail.com> wrote:
>> Hello,
>>   i used today's git bluez head code for headset gateway. i am able
>> to dial the number. receive the call.
>> but the voice stream is not starting. i have connected headphone to my
>> bluez linux host.
>> i am not able to hear or pass my voice to  other side.
>>
>> do i have to do some setting in PA ?.  or any extra settings.
> Did you use the latest version of PA?
>
>>
>> i do following steps :
>>
>> 1)   dbus-send --system --type=method_call --print-reply
>> --dest=org.bluez /org/bluez/32112/hci0/dev_00_24_04_46_4E_FA
>> org.bluez.HeadsetGateway.Connect
>>
>>
>> 2)  dbus-send --system --type=method_call --print-reply
>> --dest=org.bluez /org/bluez/32112/hci0/dev_00_24_04_46_4E_FA
>> org.bluez.HeadsetGateway.Call string:<number>
>>
>> i changed macro in gateway.c
>>     #define AG_PLACE_CALL "ATD%s\r"
>> to
>>     #define AG_PLACE_CALL "ATD%s;\r"
>>
>>  without semicolon, phone wasnt dialing the number.
>>
> According to HFP spec there should not be semicolon, this might be an
> interoperability issue.
>
> Thanks,
> Forrest
>
