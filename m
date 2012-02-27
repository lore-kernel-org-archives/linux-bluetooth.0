Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <747C1E83C744F44E9ACFB89FAEEC2C7B21A747F38A@EXDCVYMBSTM005.EQ1STM.local>
References: <747C1E83C744F44E9ACFB89FAEEC2C7B21A747F38A@EXDCVYMBSTM005.EQ1STM.local>
Date: Mon, 27 Feb 2012 13:00:54 +0200
Message-ID: <CABBYNZ+jxW7zt3+37cx9MyjatDZYyGn00ZsF4dYybDtm1YOG1A@mail.gmail.com>
Subject: Re: [RFC : PATCH] - AVRCP 1.4 AbsoluteVolume
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vani-dineshbhai PATEL X <vani.patel@stericsson.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Anurag GUPTA-1 <anurag.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Feb 27, 2012 at 12:01 PM, Vani-dineshbhai PATEL X
<vani.patel@stericsson.com> wrote:
> Hi All,
>
> I would like to propose this patch for the implementation of Absolute Volume functionality.
> When CT sends SetAbsoluteVolume request, a DBus call is made to the player to change the value of its property - volume.
> This value is saved in the media_player instance so that it can be sent for Interim response for VolumeChanged Notification.
> Your comments shall be appreciated.

Please split the patch, if possible first introduce the handling on
avrcp.c and make it check if cb->set_volume != NULL then in a separate
patch you can add the changes to media.c. When sending patches to
userspace BlueZ please use the subject prefix e.g. PATCH BlueZ, you
can also make it permanent by editing .git/config in your local tree.

IMO the volume handling should be in MediaTransport not in
MediaPlayer, otherwise it is quite possible that the player will
change the stream volume and not just indicate which is what is
recommended, in that case you would have to find what transport(s)
matches the device and emit PropertyChanged on them.

Our architecture is a bit different than what AVRCP suggests, because
the A2DP stream may not be directly controlled by the player, it is
controlled by the MediaTransport, so in case of PulseAudio multiple
processes may be streaming and naturally the volume gain applies to
everyone of them not just the MediaPlayer owner.

-- 
Luiz Augusto von Dentz
