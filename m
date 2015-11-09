Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <563F3739.7030405@gmx.de>
References: <563F3739.7030405@gmx.de>
Date: Mon, 9 Nov 2015 14:11:49 +0200
Message-ID: <CABBYNZJ5GD9PHmruEwcoPbh54r2CzwidV-_-TkRiF3sbh061qg@mail.gmail.com>
Subject: Re: PS3 remote battery drain
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Veit Guna <veit.guna@gmx.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Veit,

On Sun, Nov 8, 2015 at 1:51 PM, Veit Guna <veit.guna@gmx.de> wrote:
> Hi.
>
> I'm currently using the latest OSMC media center (successor of raspbmc)
> on the raspberry pi 2.
> It uses the bluez packages (5.12 AFAIR) for handling the bluetooth
> connections.
>
> Connecting and using the ps3 remote (1st gen) works quite ok with that.
> The problem I have is, that the remote doesn't seem to go to standby and
> batteries drain very quickly (2-3 weeks).
>
> Before OSMC, I used raspbmc. It had the same problems initially. But a
> user named "kitlaan" applied patches
> to the original bluez packages to get standby working. After replacing
> the original bluez packages with the
> patched ones, standby worked and batteries lasted at least 6 months.
>
> One could easily recognize the standby when hitting a button on the
> remote. It lagged a second before the button press
> went through to kodi. After it had woken up, pressing a button worked
> instantly - without a delay.
>
> Back then, the patch used the 4.98 version of bluez. Now I can see that
> the latest official bluez version is 5.36.
> Now I'm wondering, whether the patches have made it somehow into the
> official bluez version.
>
> Testing with 5.12 showed, that standby didn't work as expected. Also
> when using a IdleTimeout of 1 minute within
> the input.conf.
>
> Basically one can get it to work with that (there are the patches
> mentioned):
>
> https://www.mythtv.org/wiki/Sony_PS3_BD_Remote
>
> Does anybody have a clue whether the patches - or some parts of them -
> have made it into bluez?

Check that you have the following patch:

http://www.spinics.net/lists/linux-bluetooth/msg64073.html

This will make sure all the references to the sockets are released
which means the device can be disconnected if nothing else is using
the link.

-- 
Luiz Augusto von Dentz
