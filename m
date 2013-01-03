Return-Path: <cyrus@holtmann.org>
Message-ID: <1357246815.19248.117.camel@aeonflux>
Subject: Re: [PATCH 1/2] core: Replace calls to g_queue_free_full function
From: Marcel Holtmann <marcel@holtmann.org>
To: Giovanni Gherdovich <g.gherdovich@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 03 Jan 2013 13:00:15 -0800
In-Reply-To: <1357241822-4825-1-git-send-email-g.gherdovich@gmail.com>
References: <1357241822-4825-1-git-send-email-g.gherdovich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Giovanni,

> The function g_queue_free_full is available only from GLib 2.32.
> If BlueZ has to build against GLib 2.28, as stated in the configure.ac,
> this patch replaces the calls to g_queue_free_full in the "core" BlueZ module
> with its body, taken from the sources of GLib 2.32.
> ---
>  src/adapter.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)

patch has been applied.

Regards

Marcel


