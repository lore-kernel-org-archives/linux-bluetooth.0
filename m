Return-Path: <cyrus@holtmann.org>
Message-ID: <1357861916.1806.74.camel@aeonflux>
Subject: Re: [PATCH BlueZ v2] build: Fix using DBusBasicValue
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 10 Jan 2013 15:51:56 -0800
In-Reply-To: <1357837193-10092-1-git-send-email-luiz.dentz@gmail.com>
References: <1357837193-10092-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> DBusBasicValue needs a more recent libdbus so use const void * instead
> ---
> v2: Fix all places
> 
>  tools/mpris-player.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

I changed the subject to tools: prefix since this is not build system
details. Otherwise, patch has been applied.

Regards

Marcel


