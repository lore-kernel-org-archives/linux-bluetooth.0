Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Dec 2013 14:16:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/5] android: Permanent storage support
Message-ID: <20131220121611.GA20962@x220.p-661hnu-f1>
References: <1387456713-12794-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387456713-12794-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Dec 19, 2013, Szymon Janc wrote:
> V2:
>  - removed file creation with open, it is up to init to set proper
>    umask while staring bluetoothd
>  - make system-emulator set proper umask
> 
> Szymon Janc (5):
>   android/bluetooth: Add initial support for permanent storage
>   android/bluetooth: Add initial support for storing device info
>   android/bluetooth: Add support for storing link keys
>   android/bluetooth: Add support for restoring devices from storage
>   android: Set umask in system-emulator
> 
>  android/Android.mk        |   3 +-
>  android/bluetooth.c       | 310 ++++++++++++++++++++++++++++++++++++++++++++--
>  android/system-emulator.c |   4 +
>  configure.ac              |   3 +
>  4 files changed, 308 insertions(+), 12 deletions(-)

All patches have been applied. Thanks.

Johan
