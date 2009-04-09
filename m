Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090408122812.GA8827@localhost>
References: <1239180415-29327-1-git-send-email-forrest.zhao@gmail.com>
	 <20090408122812.GA8827@localhost>
Date: Thu, 9 Apr 2009 22:44:01 +0530
Message-ID: <d4d7098f0904091014v74bf03d2ne33245e86fc1599d@mail.gmail.com>
Subject: Re: [PATCH 4/4] IPC integration part for HFP Audio gateway -- take5
From: Rajan Batra <rajan.batra@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Forrest Zhao <forrest.zhao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
   i used today's git bluez head code for headset gateway. i am able
to dial the number. receive the call.
but the voice stream is not starting. i have connected headphone to my
bluez linux host.
i am not able to hear or pass my voice to  other side.

do i have to do some setting in PA ?.  or any extra settings.

i do following steps :

1)   dbus-send --system --type=method_call --print-reply
--dest=org.bluez /org/bluez/32112/hci0/dev_00_24_04_46_4E_FA
org.bluez.HeadsetGateway.Connect


2)  dbus-send --system --type=method_call --print-reply
--dest=org.bluez /org/bluez/32112/hci0/dev_00_24_04_46_4E_FA
org.bluez.HeadsetGateway.Call string:<number>

i changed macro in gateway.c
     #define AG_PLACE_CALL "ATD%s\r"
to
     #define AG_PLACE_CALL "ATD%s;\r"

 without semicolon, phone wasnt dialing the number.


-thanks and regards,
-rajan batra




On Wed, Apr 8, 2009 at 5:58 PM, Johan Hedberg <johan.hedberg@nokia.com> wrote:
> Hi Forrest,
>
> On Wed, Apr 08, 2009, Forrest Zhao wrote:
>> From: Forrest Zhao <forrest.zhao@gmail.com>
>>
>> ---
>>  audio/gateway.c |   77 +++++++++++++++++++++++++++++++++++++
>>  audio/gateway.h |    7 +++
>>  audio/unix.c    |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>>  3 files changed, 192 insertions(+), 7 deletions(-)
>
> Thanks! The patch has now been pushed upstream with some minor coding
> style fixes.
>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
