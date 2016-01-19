Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 Jan 2016 20:06:46 +0800
Message-ID: <CANyK0Sk1y1Sv=RCh+Zp3dRWtSi3AXc=_63PYU_nSOqD3bJ=2Jg@mail.gmail.com>
Subject: Question about AVRCP and MediaPlayer API
From: Hsin-yu Chao <hychao@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I am working on AVRCP for Chromium OS using MediaPlayer dbus API and
noticed a problem while testing the media buttons on various BT
speaker/headsets. In profile/audio/avrcp.c there is a check for
supported feature before an avrcp_player is created:

/* Only create player if category 1 is supported */
if (!(controller->features & AVRCP_FEATURE_CATEGORY_1))
        return;

The SDP record of my BT speaker has feature ==
AVRCP_FEATURE_CATEGORY_2 (monitor/amplifier). My understanding is that
this feature is associated with volume changed event and
SetAbsoluteVolume command.
But with this check, volume changed events are unable to pass up to
registered player app in my case. I tried commented out these few
lines and rebuild bluetoothd, after that volume change events works
perfect.

What is the reason to create player only when it supports category 1 feature?

Thanks,
Hsin-yu
