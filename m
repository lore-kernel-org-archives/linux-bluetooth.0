Return-Path: <cyrus@holtmann.org>
Message-ID: <1343137097.24426.52.camel@aeonflux>
Subject: Re: [PATCH 3/3] build: Require GLib 2.32 or later when building
 with gstreamer support
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 24 Jul 2012 15:38:17 +0200
In-Reply-To: <1343131482-17629-3-git-send-email-szymon.janc@tieto.com>
References: <1343131482-17629-1-git-send-email-szymon.janc@tieto.com>
	 <1343131482-17629-3-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> gstreamer code now uses g_mutex_init() and related functions only
> available in GLib >= 2.32.
> ---
>  acinclude.m4 |    2 ++
>  1 file changed, 2 insertions(+)

since we are planning to move SBC to a separate project and GStreamer
Bluetooth support then into GStreamer upstream, this is a NACK.

Regards

Marcel


