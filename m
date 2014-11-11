Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415628309-7384-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1415628309-7384-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Date: Tue, 11 Nov 2014 11:24:46 +0200
Message-ID: <CABBYNZLm3vT9VkX_0C-tLMuo2jgvvFo4=gQXuCOULhOy40V7pQ@mail.gmail.com>
Subject: Re: [PATCH_v2 0/5] Add support for new AVRCP ctrl interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Mon, Nov 10, 2014 at 4:05 PM, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> v2: Fixed Luiz's comments (added new interface at bottom in
>     hal-ipc-txt and ID in hal-msg.h).
>
> v1: Android Lollipop has new interface for AVRCP controller. It has
>     one command and two callbacks. Patchset updates support for IPC
>     doc, hal-msg, HAL part and client part.
>
> Ravi kumar Veeramally (5):
>   android/hal-ipc-txt: Add support for new AVRCP CTRL interface
>   android/hal-msg: Add support for new AVRCP CTRL interface
>   android/hal-avrcp: Add suuport for new AVRCP ctrl interface
>   android/client: Add support for new AVRCP CTRL interface
>   android/avrcp: Add initial support for new AVRCP CTRL interface
>
>  android/avrcp.c          |  72 ++++++++++++++++++++++------
>  android/avrcp.h          |   4 ++
>  android/client/if-bt.c   |   2 +
>  android/client/if-main.h |   2 +
>  android/client/if-rc.c   |  88 ++++++++++++++++++++++++++++++++++
>  android/hal-avrcp.c      | 122 +++++++++++++++++++++++++++++++++++++++++++++++
>  android/hal-bluetooth.c  |   3 ++
>  android/hal-ipc-api.txt  |  45 ++++++++++++++++-
>  android/hal-msg.h        |  24 +++++++++-
>  android/hal.h            |   1 +
>  android/main.c           |  11 +++++
>  11 files changed, 356 insertions(+), 18 deletions(-)
>
> --
> 2.1.0

Patches 1-4 have been applied, patch 5/5 need some work see my comments to it.



-- 
Luiz Augusto von Dentz
