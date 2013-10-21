Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Oct 2013 22:58:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 01/11] android/hal: Move IPC and sockets related code
 to separate file
Message-ID: <20131021195804.GB19575@x220.p-661hnu-f1>
References: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Oct 21, 2013, Szymon Janc wrote:
> hal-ipc will provide functionality related to IPC initialization and
> sockets handling (including upcoming callbacks thread).
> 
> This allow to remove code from bluetooth HAL not related to adapter.
> ---
>  Makefile.android        |   3 +-
>  android/Android.mk      |   1 +
>  android/hal-bluetooth.c | 118 ++---------------------------------------
>  android/hal-ipc.c       | 137 ++++++++++++++++++++++++++++++++++++++++++++++++
>  android/hal-ipc.h       |  19 +++++++
>  5 files changed, 163 insertions(+), 115 deletions(-)
>  create mode 100644 android/hal-ipc.c
>  create mode 100644 android/hal-ipc.h

All patches, except 5/11 (which was unnecessary) have been applied along
with minor fixes. Thanks.

Johan
