Return-Path: <cyrus@holtmann.org>
Message-ID: <1357626738.1806.27.camel@aeonflux>
Subject: Re: [PATCH BlueZ v1] audio: Replace g_hash_table_contains() with
 g_hash_table_lookup()
From: Marcel Holtmann <marcel@holtmann.org>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 07 Jan 2013 22:32:18 -0800
In-Reply-To: <1357622748-3051-1-git-send-email-jaganath.k@samsung.com>
References: <1357622748-3051-1-git-send-email-jaganath.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> g_hash_table_contains() is supported only from GLib 2.32. If BlueZ has to
> build against GLib 2.28 this patch replaces g_hash_table_contains() to
> g_hash_table_lookup()
> ---
>  profiles/audio/player.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

patch has been applied.

Regards

Marcel


