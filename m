Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 0/6] 1st serie of Android Lollipop BlueZ code
Date: Tue, 04 Nov 2014 15:03:45 +0100
Message-ID: <2069232.SV8JtI5hNT@uw000953>
In-Reply-To: <1415103890-24375-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415103890-24375-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tuesday 04 of November 2014 14:24:44 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Adaptation of bluetooth.h HAL to BlueZ
> 
> Andrei Emeltchenko (6):
>   android/hal-bluetooth: Add parameter to create_bond
>   android/hardware: Update bluetooth.h header from Android 5.0
>   android/hal-bluetooth: Add missing functions
>   android/client: Add new API argument for create_bond()
>   android/tester: Use dummy parameter in create_bond()
>   android/client: Add energy_info_callback print
> 
>  android/bluetooth.c          |  2 ++
>  android/client/if-bt.c       | 21 +++++++++++-
>  android/hal-bluetooth.c      | 53 +++++++++++++++++++++++++++-
>  android/hal-ipc-api.txt      |  1 +
>  android/hal-msg.h            |  5 +++
>  android/hardware/bluetooth.h | 82 ++++++++++++++++++++++++++++++++++++++++++--
>  android/tester-main.c        |  6 +++-
>  7 files changed, 165 insertions(+), 5 deletions(-)
> 

Patches 1,3,4 and 6 are now applied. Thanks.

I've made few changes to them:
- lets check against >=5.0.0 for new API
- I've fixed missing checks for new API in 6/6
- moved parameter validation to daemon in 1/6

-- 
Best regards, 
Szymon Janc
