Return-Path: <cyrus@holtmann.org>
Message-ID: <1358797179.7365.0.camel@aeonflux>
Subject: Re: [PATCH] monitor: Fix possible crash on unknown command
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 21 Jan 2013 11:39:39 -0800
In-Reply-To: <1358781467-32172-1-git-send-email-szymon.janc@tieto.com>
References: <1358781467-32172-1-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> If uknown command is received monitor would crash due to dereference
> of NULL opcode_data pointer.
> ---
>  monitor/packet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

good catch. Patch has been applied.

Regards

Marcel


