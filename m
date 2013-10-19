Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/5] Initial Android IPC
Date: Sat, 19 Oct 2013 15:28:53 +0200
Message-ID: <4903006.DicA8W53b6@athlon>
In-Reply-To: <1382137302-17237-1-git-send-email-szymon.janc@gmail.com>
References: <1382137302-17237-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> This adds initial code for Android IPC
> - only connection establishment
> - connecting ipc from daemon to HAL after adapter is initialized
> - daemon track HAL lib lifetime and shutdown if socket is closed
> - HAL library starts daemon (via android init) and wait for it to
>   connect
> - HAL library is *not* yet tracking lifetime of daemon

One more note I forgot to mention: this is not yet runtime tested on Android.
(build was verified though)

-- 
Szymon K. Janc
szymon.janc@gmail.com
