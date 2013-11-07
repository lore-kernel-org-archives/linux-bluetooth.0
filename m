Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Nov 2013 17:06:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android: Make IPC helpers accept file descriptor
Message-ID: <20131107150648.GA23283@x220.p-661hnu-f1>
References: <1383815437-521-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383815437-521-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Nov 07, 2013, Szymon Janc wrote:
> There is no need to pass GIOChannel as writes are done immediately.
> ---
>  android/a2dp.c    |  3 ++-
>  android/adapter.c | 71 ++++++++++++++++++++++++++++++++-----------------------
>  android/hid.c     | 15 ++++++++----
>  android/ipc.c     | 10 ++++----
>  android/ipc.h     |  4 ++--
>  android/main.c    | 20 +++++++++-------
>  android/pan.c     |  3 ++-
>  android/socket.c  |  7 +++---
>  8 files changed, 77 insertions(+), 56 deletions(-)

All four patches have been applied. Thanks.

Johan
