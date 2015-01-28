Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25Qfr9bRYad0scysHMcUD+SY651y4qZLk4EAWk-ym+970Q@mail.gmail.com>
References: <CAHrH25Qfr9bRYad0scysHMcUD+SY651y4qZLk4EAWk-ym+970Q@mail.gmail.com>
Date: Wed, 28 Jan 2015 11:21:32 +0200
Message-ID: <CABBYNZLb4jHBuKLqyEaMTMBNzCBzFea=bRLgnkafWWyA8LqSNQ@mail.gmail.com>
Subject: Re: GATT D-Bus API handling notifications
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Jan 28, 2015 at 4:11 AM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Luiz,
>
> Earlier I chatted with Marcel on IRC about how we can resolve the
> notification subscription issue that you were concerned about
> (basically a server connecting and immediately sending a
> notification). I think our consensus was that this mainly applies when
> the two devices are bonded. In that case, we could make it so that the
> exported GattService1 hierarchy stays around over disconnections if
> there is a bond between the two devices. We would keep
> StartNotify/StopNotify and keep around the data on external clients
> that subscribed to notifications. Upon reconnection we would then
> immediately register for notifications based on all the external
> clients that subscribed.
>
> Would this address the case? I think this case really applies when the
> remote CCC has been configured so the peripheral remembers the
> configuration between disconnections, which should only happen when
> the devices are bonded but I'm not sure.
>
> Let me know if that makes sense! Thanks!


Yep, I guess it makes sense to keep the whole attribute tree around
for devices bonded as you said we can just resync the CCC upon
connection, note that there are cases where the applications may
disconnect or call StopNotify this would mean that we would write to
CCC as soon as it reconnect thus it can still cause some traffic, at
least at Bluetooth level, but that seems the cost of having the
ability to dynamically trigger notifications.


-- 
Luiz Augusto von Dentz
