Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1341955486-11189-1-git-send-email-jprvita@openbossa.org>
References: <1341947825-14789-2-git-send-email-jprvita@openbossa.org>
	<1341955486-11189-1-git-send-email-jprvita@openbossa.org>
Date: Tue, 10 Jul 2012 18:26:51 -0300
Message-ID: <CAAngNMaVGiAw-QJ0t46vH5K312uj56uhXafrn3p9a6dfKiH0rQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] hog: HID I/O driver
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 10, 2012 at 6:24 PM, João Paulo Rechi Vita
<jprvita@openbossa.org> wrote:
> uHID is HID I/O driver that makes possible to implement HID I/O drivers in
> user-space. It works similar to the uinput but it is initialized with a HID
> descriptor and deals with raw HID reports.
>
> This commit uses uHID to create a HID device for the remote HoG device and
> to tranfers HID reports to HID subsystem.
> ---
>  profiles/input/hog_device.c |   89 ++++++++++++++++++++++++++++--------
>  profiles/input/uhid-copy.h  |  104 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 174 insertions(+), 19 deletions(-)
>  create mode 100644 profiles/input/uhid-copy.h

This revision address the comments that Marcel and Johan made in
person on the BlueZ meeting.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
