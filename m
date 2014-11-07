Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 1/2] android/hardware: Update Anmdroid header to 5.0 API
Date: Fri, 07 Nov 2014 13:03:55 +0100
Message-ID: <1692354.o1VeTAIfWm@uw000953>
In-Reply-To: <1415356921-32320-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415356921-32320-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Friday 07 of November 2014 12:42:00 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Android headers are used for host build.
> ---
>  android/Android.mk                |   4 +-
>  android/Makefile.am               |   2 +-
>  android/hardware/audio.h          | 147 ++++++-
>  android/hardware/audio_effect.h   |   3 +-
>  android/hardware/bluetooth.h      |  82 +++-
>  android/hardware/bt_av.h          |  15 +-
>  android/hardware/bt_gatt_client.h | 134 +++++-
>  android/hardware/bt_gatt_server.h |  19 +-
>  android/hardware/bt_gatt_types.h  |   8 +
>  android/hardware/bt_hf.h          |  63 ++-
>  android/hardware/bt_hf_client.h   |  30 +-
>  android/hardware/bt_hh.h          |  10 +-
>  android/hardware/bt_mce.h         |   5 +-
>  android/hardware/bt_pan.h         |   4 +-
>  android/hardware/bt_rc.h          |  34 +-
>  android/system/audio.h            | 867 +++++++++++++++++++++++++++++++++++---
>  android/tester-a2dp.c             |   2 +-
>  android/tester-gatt.c             |  15 +-
>  android/tester-main.c             |  11 +-
>  19 files changed, 1312 insertions(+), 143 deletions(-)

Both patches applied (after fixing typos in commit message), thanks.

-- 
Best regards, 
Szymon Janc
