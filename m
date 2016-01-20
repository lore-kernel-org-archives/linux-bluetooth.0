Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANyK0Sk1y1Sv=RCh+Zp3dRWtSi3AXc=_63PYU_nSOqD3bJ=2Jg@mail.gmail.com>
References: <CANyK0Sk1y1Sv=RCh+Zp3dRWtSi3AXc=_63PYU_nSOqD3bJ=2Jg@mail.gmail.com>
Date: Wed, 20 Jan 2016 17:59:12 +0200
Message-ID: <CABBYNZKhFZbjP9Ybnj79RTuKKf+1NXH9xJxmAQNDwuZOKPgi0A@mail.gmail.com>
Subject: Re: Question about AVRCP and MediaPlayer API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Hsin-yu Chao <hychao@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hsin-yu,

On Tue, Jan 19, 2016 at 2:06 PM, Hsin-yu Chao <hychao@chromium.org> wrote:
> Hi,
> I am working on AVRCP for Chromium OS using MediaPlayer dbus API and
> noticed a problem while testing the media buttons on various BT
> speaker/headsets. In profile/audio/avrcp.c there is a check for
> supported feature before an avrcp_player is created:
>
> /* Only create player if category 1 is supported */
> if (!(controller->features & AVRCP_FEATURE_CATEGORY_1))
>         return;

Category 1 is player category thus why we check it.

> The SDP record of my BT speaker has feature ==
> AVRCP_FEATURE_CATEGORY_2 (monitor/amplifier). My understanding is that
> this feature is associated with volume changed event and
> SetAbsoluteVolume command.

And GetCapabilities as well since otherwise we cannot subscribe to
volume changes.

> But with this check, volume changed events are unable to pass up to
> registered player app in my case. I tried commented out these few
> lines and rebuild bluetoothd, after that volume change events works
> perfect.
>
> What is the reason to create player only when it supports category 1 feature?

I don't recall now but I guess all the headset we encountered had this
feature bit set, note that this is the category of a target record but
perhaps it is valid after all. Btw, is this a BT Speaker of yours a
device on the market already?


-- 
Luiz Augusto von Dentz
