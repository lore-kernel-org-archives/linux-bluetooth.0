Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKhFZbjP9Ybnj79RTuKKf+1NXH9xJxmAQNDwuZOKPgi0A@mail.gmail.com>
References: <CANyK0Sk1y1Sv=RCh+Zp3dRWtSi3AXc=_63PYU_nSOqD3bJ=2Jg@mail.gmail.com>
	<CABBYNZKhFZbjP9Ybnj79RTuKKf+1NXH9xJxmAQNDwuZOKPgi0A@mail.gmail.com>
Date: Thu, 21 Jan 2016 15:52:52 +0800
Message-ID: <CANyK0S=Yr8TD+db7k4Yr2rRYAYofhDnZajYr6jZt+zzzLBwSxw@mail.gmail.com>
Subject: Re: Question about AVRCP and MediaPlayer API
From: Hsin-yu Chao <hychao@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,
Thanks for the comments. I am testing with this UE-mini Boom speaker.
http://the-gadgeteer.com/2013/11/22/ue-mini-boom-portable-bluetooth-speaker-review/

This BT speaker has two buttons 'Volume Up' and 'Volume Down', but
lack of player related buttons, like next/prev track,
shuffle/play/pause.  I think that is why it advertised to support only
category 2 feature.
Looking at audio/avrcp.c, set_volume is one of the avrcp_player_cb
callback functions, plus that avrcp_volume_changed() checks for the
existence of an avrcp_player struct before handling the event. Seems
that avrcp_player structure is designed to cover both category 1 and
category 2 features. Maybe we should change the condition to if
(!(controller->features & (AVRCP_FEATURE_CATEGORY_1 |
AVRCP_FEATURE_CATEGORY_2))) instead?  So that the set volume cmd and
volume change event can work correctly on those peripherals who has
volume button only.

I will send a patch for that later.

Hsin-yu

On Wed, Jan 20, 2016 at 11:59 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Hsin-yu,
>
> On Tue, Jan 19, 2016 at 2:06 PM, Hsin-yu Chao <hychao@chromium.org> wrote:
>> Hi,
>> I am working on AVRCP for Chromium OS using MediaPlayer dbus API and
>> noticed a problem while testing the media buttons on various BT
>> speaker/headsets. In profile/audio/avrcp.c there is a check for
>> supported feature before an avrcp_player is created:
>>
>> /* Only create player if category 1 is supported */
>> if (!(controller->features & AVRCP_FEATURE_CATEGORY_1))
>>         return;
>
> Category 1 is player category thus why we check it.
>
>> The SDP record of my BT speaker has feature ==
>> AVRCP_FEATURE_CATEGORY_2 (monitor/amplifier). My understanding is that
>> this feature is associated with volume changed event and
>> SetAbsoluteVolume command.
>
> And GetCapabilities as well since otherwise we cannot subscribe to
> volume changes.
>
>> But with this check, volume changed events are unable to pass up to
>> registered player app in my case. I tried commented out these few
>> lines and rebuild bluetoothd, after that volume change events works
>> perfect.
>>
>> What is the reason to create player only when it supports category 1 feature?
>
> I don't recall now but I guess all the headset we encountered had this
> feature bit set, note that this is the category of a target record but
> perhaps it is valid after all. Btw, is this a BT Speaker of yours a
> device on the market already?
>
>
> --
> Luiz Augusto von Dentz
