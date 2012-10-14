Return-Path: <cyrus@holtmann.org>
Message-ID: <507AF555.7080400@fisher-privat.net>
Date: Sun, 14 Oct 2012 19:24:37 +0200
From: Oleksij Rempel <bug-track@fisher-privat.net>
MIME-Version: 1.0
To: Tanu Kaskinen <tanuk@iki.fi>
CC: pulseaudio-discuss@lists.freedesktop.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [pulseaudio-discuss] how to troubleshoot bluetooth audio issues?
References: <507ADA75.9040204@fisher-privat.net> <1350230390.30695.22.camel@x230>
In-Reply-To: <1350230390.30695.22.camel@x230>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 14.10.2012 17:59, schrieb Tanu Kaskinen:
> On Sun, 2012-10-14 at 17:29 +0200, Oleksij Rempel wrote:
>> Hallo all, (Pulseaudio and Bluetooth devs)
>>
>> i have Samsung HS3000 bluetooth headset. Mostly it works but there are
>> different issue with it:
>>
>> - volume level seems to be set to max (at really uncomfortable level)
>> - at the moment i trying to change volume with pavucontrol or after it i
>> get bad sound. Some times sort of cracky or trashy sound, some times
>> just white noise.
>> - play/stop key do not works with linux (not pulse issue)
>>
>> how to troubleshoot this issues? what tools should i use and where
>> should it start?
>
> Regarding the broken audio: I would suspect that the headset is buggy,

hehe, nice try :) This headset works perfectly with my 
smartphone/cyanogenmod.

> because the volume handling code should be pretty well tested in
> pulseaudio,  and I don't think bluetoothd touches the audio signal at
> all. To confirm that, I think it's somehow possible to capture the audio
> that is sent to the headset, but I don't know how. Maybe the bluez
> people can answer that (I'm a pulseaudio guy myself).
>
> Are you using the headset in the HSP or A2DP mode, btw? If A2DP, then
> that would suggest a pulseaudio bug, since I don't think the headset
> will get any notification via A2DP when you change the volume in
> pavucontrol.

You right, i played with different profiles. HSP controls volume on 
pulse, but minimal volume is still too loud. A2DP use internal volume 
control and i can set it as silent as i need.


I made some more tests with different kernels. It looks more like kernel 
issue. I get different oopses and it looks like 3.5.0 sounds better then 
current master git.

-- 
Regards,
Oleksij
