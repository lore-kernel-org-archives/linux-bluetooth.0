Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/11] Socket HAL updates
Date: Wed, 12 Feb 2014 13:54:08 +0100
Message-ID: <3646292.iBuS7jY2Rq@leonov>
In-Reply-To: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tuesday 11 of February 2014 17:58:10 Andrzej Kaczmarek wrote:
> Hi,
> 
> Current socket HAL implementation is missing major feature which is
> ability to register RFCOMM server from application (so use some UUID
> and assign channel number dynamically). This corresponds to
> BluetoothAdapter::listenUsing(insecure)RfcommWithServiceRecord APIs
> in Android.
> 
> This series of patches adds this feature with other required fixes
> and also some does some minor refactoring.
> 
> Andrzej Kaczmarek (11):
>   android/bluetooth: Handle 128-bit UUIDs
>   android/socket: Refactor socket related symbol names
>   android/socket: Improve logging
>   android/socket: Simplify SDP records handling
>   android/socket: Make servers list as static array
>   android/tester: Update test data
>   android/socket: Add support for dynamic channel numbers
>   android/socket: Register SDP record for application service
>   android/socket: Include HF AG in built-in profiles
>   android/socket: Update channel numbers
>   android/socket: Fix sockets security
> 
>  android/android-tester.c |   2 +-
>  android/bluetooth.c      |  61 ++---
>  android/hal-msg.h        |   3 +
>  android/socket.c         | 658
> +++++++++++++++++++++++------------------------ 4 files changed, 349
> insertions(+), 375 deletions(-)

All patches in this set are now upstream, thanks a lot.

-- 
BR
Szymon Janc
