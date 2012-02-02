Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Feb 2012 15:58:19 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix GLib assertion failure in media.c get_setting()
Message-ID: <20120202235819.GB8153@x220>
References: <1328221279-26319-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328221279-26319-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Feb 02, 2012, Szymon Janc wrote:
> If get_setting is called before set_setting, mp->settings would be
> NULL resulting in GLib assertion. Hashmap is now allocated in
> media_player_create instead of on-demand allocation in set_setting.
> 
> external/bluetooth/bluez/audio/media.c:get_setting() Equalizer
> CRITICAL **: g_hash_table_lookup: assertion `hash_table != NULL' failed
> ---
>  audio/media.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
