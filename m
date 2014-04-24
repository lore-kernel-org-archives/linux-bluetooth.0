Return-Path: <cyrus@holtmann.org>
Message-ID: <5358C55F.1090101@linux.intel.com>
Date: Thu, 24 Apr 2014 11:03:43 +0300
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@tieto.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/11] Add health profile support for haltest
References: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com> <4760270.XzpdEKGsOk@leonov>
In-Reply-To: <4760270.XzpdEKGsOk@leonov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 04/23/2014 11:02 PM, Szymon Janc wrote:
>   android/hal-health.c     |  14 ++-
>   android/hal-msg.h        |   7 ++
>   android/health.c         |  13 +-
>   8 files changed, 334 insertions(+), 8 deletions(-)
>   create mode 100644 android/client/if-hl.c
> I've pushed all patches, thanks. But I had to fix compilation for Android
> and some bugs in register application (which I also simplified a bit).
>
    Changes looks simpler, thanks.

- Ravi.
