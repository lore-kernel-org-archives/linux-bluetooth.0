Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Feb 2014 11:57:41 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/11] Socket HAL updates
Message-ID: <20140212095739.GA25950@aemeltch-MOBL1>
References: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tue, Feb 11, 2014 at 05:58:10PM +0100, Andrzej Kaczmarek wrote:
> Hi,
> 
> Current socket HAL implementation is missing major feature which is
> ability to register RFCOMM server from application (so use some UUID
> and assign channel number dynamically). This corresponds to
> BluetoothAdapter::listenUsing(insecure)RfcommWithServiceRecord APIs
> in Android.

Support dynamic RFCOMM sockets looks god though I do not know why renaming
of socket names is really needed.

Best regards 
Andrei Emeltchenko 

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
>  android/socket.c         | 658 +++++++++++++++++++++++------------------------
>  4 files changed, 349 insertions(+), 375 deletions(-)
> 
> -- 
> 1.8.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
