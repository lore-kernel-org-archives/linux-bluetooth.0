Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v6 0/3] Create bneptest tool
Date: Fri, 13 Mar 2015 15:23:41 +0100
Message-ID: <3164272.MDiYys34LN@leonov>
In-Reply-To: <1426250512-4322-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1426250512-4322-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Friday 13 of March 2015 13:41:48 Grzegorz Kolodziejczyk wrote:
> v4:
> - Fix error returning in bnep server add
> - Reorganize bnep service comparing (by uuid, by string),
> - Fixed pointed by Szymon commit message typo,
> - Add support for sending general bnep frames by bneptest,
> - bneptest now require bridge and iface name (it was optional-def. names
> were set)
> - Update PTS results and test instructions.
> v5:
> - Fix converting uuids (16 to 128),
> - Extend bneptest with frames retransmission parameters,
> - Update PTS results and test instructions.
> v6:
> - bneptest style fix,
> - small fixes pointed by szymon,
> - Commit message "Bluez" typo fix.
> 
> Grzegorz Kolodziejczyk (3):
>   tools/bneptest: Add initial support for bneptest tool
>   tools/bneptest: Add generic connect/listen functionality
>   android/pts: Add BNEP PTS 6.0 results for android 5.0
> 
>  .gitignore             |   1 +
>  Makefile.tools         |  12 +-
>  android/Android.mk     |  35 +++
>  android/Makefile.am    |   5 +-
>  android/pics-bnep.txt  |  26 ++
>  android/pixit-bnep.txt |  30 ++
>  android/pts-bnep.txt   |  48 ++++
>  tools/bneptest.c       | 721
> +++++++++++++++++++++++++++++++++++++++++++++++++ 8 files changed, 874
> insertions(+), 4 deletions(-)
>  create mode 100644 android/pics-bnep.txt
>  create mode 100644 android/pixit-bnep.txt
>  create mode 100644 android/pts-bnep.txt
>  create mode 100644 tools/bneptest.c

All patches applied (with small changes discussed offline), thanks.

-- 
BR
Szymon Janc
