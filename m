Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <55C3D220.1040803@ubnt.com>
References: <55C3D220.1040803@ubnt.com>
Date: Sun, 9 Aug 2015 18:13:10 +0300
Message-ID: <CABBYNZK5y4Kt+NaJ7cm4rhJE8dMyUEJo6ca5iFyrnocviL_dEg@mail.gmail.com>
Subject: Re: Notifications and CCC descriptor handling for Gatt server
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrejs Hanins <andrejs.hanins@ubnt.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrejs,

On Fri, Aug 7, 2015 at 12:31 AM, Andrejs Hanins <andrejs.hanins@ubnt.com> wrote:
> Hi,
>
>         I have a Gatt server over D-Bus with "notify" characteristic exported and I listen to Start/StopNotify methods. But I can't get my head around the logic of Start/StopNotify methods in case of multiple Gatt clients connecting to the service (not in the same time, of course):
>         1. Client A connects and enables notifications, StartNotify is called - this is fine.
>         2. Client B connects and enables notifications, then StartNotify is called again - is it expected? Does it mean notifications state is per-client and external Gatt server needs to know the currently connected client and associate some state with it?

This is probably a bug, bluetoothd shall only call StartNotification
once, it shall also call StopNotification if there no client
connected.

>         3. Client A connects again and disables notifications, StopNotify is not called. This is strange and goes against the logic in item 2.

It shall only call StopNotify if it is the last client, otherwise this is ok.

>         4. Client B connects and disables notifications, StopNotify is called.

That is probably fine, it both StartNotify and StopNotify shall only
be called once.

>         So, how is it supposed to work? Maybe there is a bug somewhere?
>         BlueZ 5.32 used.
>
> BR, Andrey
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
