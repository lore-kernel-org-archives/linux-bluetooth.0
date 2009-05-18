Return-Path: <cyrus@holtmann.org>
Message-ID: <4A10D66E.2040604@aircable.net>
Date: Mon, 18 May 2009 00:30:54 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: Jaikumar Ganesh <jaikumar@google.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Emit device_found when RSSI changes.
References: <1241505159-12795-1-git-send-email-jaikumar@google.com> 	<4A10C797.4080803@aircable.net> <e8892a6a0905172014h798119c4m3b36e7e6efed8bb4@mail.gmail.com>
In-Reply-To: <e8892a6a0905172014h798119c4m3b36e7e6efed8bb4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Jaikumar
> Hi Manuel,
>   This fix got implemented as part of bunch of changed made by Luiz in 
> the DeviceFound code namely,
>
> http://git.kernel.org/?p=bluetooth/bluez.git;a=commit;h=66ef7864f7820f41d7331942bcb6256ff68d7614
>
> Thanks
> Jaikumar
Oops sorry I missed it. So it will send a result each time there's an 
inquriry result no matter if RSSI changes or not. That's why I missed it.

Manuel
