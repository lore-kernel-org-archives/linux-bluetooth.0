Return-Path: <cyrus@holtmann.org>
Message-ID: <4C804F5B.3010108@aircable.net>
Date: Thu, 02 Sep 2010 22:28:59 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Make sure discovery don't interfere with bonding
References: <1283436253-9850-1-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1283436253-9850-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  Luiz,
> In situation where the user application keep a discovery session while
> bonding with a device it may cause a delay, or even timeout, due to the
> number of the inquiry responses that the controller has to process.
>
> Since the discovery can be shared between many applications it may not be
> possible to simple require to each application to stop their discovery
> before trying to pair with a device, so to fix this bluetoothd now
> suspends the discovery while bonding, resuming when completed.
Stupid question but... Any way this is related to my seg faults during 
sdp resolving problems? I haven't tried to fix it in a while, so far I'm 
ok with a stupid cron rule which revives bluetoothd if it crashes, but I 
would prefer a better solution.

Manuel
