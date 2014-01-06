Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Jan 2014 21:26:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/socket: Make channel int32_t in IPC
 specification
Message-ID: <20140106192658.GA25443@x220.p-661hnu-f1>
References: <1388866574-20158-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388866574-20158-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sat, Jan 04, 2014, Szymon Janc wrote:
> This match IPC type with type in socket HAL API. This allows to pass
> data directly from HAL library and will allow to reduce logic in it.
> ---
>  android/hal-msg.h | 20 ++++++++++----------
>  android/socket.c  |  2 +-
>  2 files changed, 11 insertions(+), 11 deletions(-)

All three patches have been applied. Thanks.

Johan
