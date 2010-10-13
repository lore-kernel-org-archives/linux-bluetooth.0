Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] gdbus: fix not handling bus disconnects
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1286971606-11790-1-git-send-email-luiz.dentz@gmail.com>
References: <1286971606-11790-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Oct 2010 15:52:56 +0300
Message-ID: <1286974376.3316.8.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> We where not dispatching data when a bus disconnects which cause
> Disconnected signal to not be processed and thus causing the process to
> either not exit or to not trigger callbacks registered with
> g_dbus_set_disconnect_function.
> 
> To fix this now we always schedule a dispatch which will make sure data
> still not processed will make its way to the proper handlers even if
> disconnected.

this looks fine to me. Went ahead and applied to all repositories.

Regards

Marcel


