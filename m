Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANyK0S=Yr8TD+db7k4Yr2rRYAYofhDnZajYr6jZt+zzzLBwSxw@mail.gmail.com>
References: <CANyK0Sk1y1Sv=RCh+Zp3dRWtSi3AXc=_63PYU_nSOqD3bJ=2Jg@mail.gmail.com>
	<CABBYNZKhFZbjP9Ybnj79RTuKKf+1NXH9xJxmAQNDwuZOKPgi0A@mail.gmail.com>
	<CANyK0S=Yr8TD+db7k4Yr2rRYAYofhDnZajYr6jZt+zzzLBwSxw@mail.gmail.com>
Date: Thu, 21 Jan 2016 13:29:03 +0200
Message-ID: <CABBYNZKXTeHxwThOmZgadMo6JEB0GRYKCs3LV9LpiQH6yPRbdA@mail.gmail.com>
Subject: Re: Question about AVRCP and MediaPlayer API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Hsin-yu Chao <hychao@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hsin-yu,

On Thu, Jan 21, 2016 at 9:52 AM, Hsin-yu Chao <hychao@chromium.org> wrote:
> Hi Luiz,
> Thanks for the comments. I am testing with this UE-mini Boom speaker.
> http://the-gadgeteer.com/2013/11/22/ue-mini-boom-portable-bluetooth-speaker-review/
>
> This BT speaker has two buttons 'Volume Up' and 'Volume Down', but
> lack of player related buttons, like next/prev track,
> shuffle/play/pause.  I think that is why it advertised to support only
> category 2 feature.

Yep, this might explain why we haven't seem this before.

> Looking at audio/avrcp.c, set_volume is one of the avrcp_player_cb
> callback functions, plus that avrcp_volume_changed() checks for the
> existence of an avrcp_player struct before handling the event. Seems
> that avrcp_player structure is designed to cover both category 1 and
> category 2 features. Maybe we should change the condition to if
> (!(controller->features & (AVRCP_FEATURE_CATEGORY_1 |
> AVRCP_FEATURE_CATEGORY_2))) instead?  So that the set volume cmd and
> volume change event can work correctly on those peripherals who has
> volume button only.

Yep, this might work, we could also create the player object but not
the D-Bus interface which I think for the original idea so application
would not have the false impression there is a player in the other end
so something like this should work:

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 7b60012..076766d 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3843,12 +3843,11 @@ static void controller_init(struct avrcp *session)
        btd_service_connecting_complete(service, 0);

        /* Only create player if category 1 is supported */
-       if (!(controller->features & AVRCP_FEATURE_CATEGORY_1))
-               return;
-
-       player = create_ct_player(session, 0);
-       if (player == NULL)
-               return;
+       if (controller->features & AVRCP_FEATURE_CATEGORY_1) {
+               player = create_ct_player(session, 0);
+               if (player == NULL)
+                       return;
+       }

        if (controller->version < 0x0103)
                return;
