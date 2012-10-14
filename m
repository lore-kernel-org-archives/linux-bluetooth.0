Return-Path: <cyrus@holtmann.org>
Message-ID: <1350230390.30695.22.camel@x230>
Subject: Re: [pulseaudio-discuss] how to troubleshoot bluetooth audio issues?
From: Tanu Kaskinen <tanuk@iki.fi>
To: Oleksij Rempel <bug-track@fisher-privat.net>
Cc: pulseaudio-discuss@lists.freedesktop.org,
	linux-bluetooth@vger.kernel.org
Date: Sun, 14 Oct 2012 18:59:50 +0300
In-Reply-To: <507ADA75.9040204@fisher-privat.net>
References: <507ADA75.9040204@fisher-privat.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 2012-10-14 at 17:29 +0200, Oleksij Rempel wrote:
> Hallo all, (Pulseaudio and Bluetooth devs)
> 
> i have Samsung HS3000 bluetooth headset. Mostly it works but there are 
> different issue with it:
> 
> - volume level seems to be set to max (at really uncomfortable level)
> - at the moment i trying to change volume with pavucontrol or after it i 
> get bad sound. Some times sort of cracky or trashy sound, some times 
> just white noise.
> - play/stop key do not works with linux (not pulse issue)
> 
> how to troubleshoot this issues? what tools should i use and where 
> should it start?

Regarding the broken audio: I would suspect that the headset is buggy,
because the volume handling code should be pretty well tested in
pulseaudio, and I don't think bluetoothd touches the audio signal at
all. To confirm that, I think it's somehow possible to capture the audio
that is sent to the headset, but I don't know how. Maybe the bluez
people can answer that (I'm a pulseaudio guy myself).

Are you using the headset in the HSP or A2DP mode, btw? If A2DP, then
that would suggest a pulseaudio bug, since I don't think the headset
will get any notification via A2DP when you change the volume in
pavucontrol.

-- 
Tanu

