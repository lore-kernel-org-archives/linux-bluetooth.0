Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] android/A2DP: Add retry logic to Audio IPC
Date: Tue, 21 Jan 2014 16:24:29 +0100
Message-ID: <12198760.CxVh8o9kqd@uw000953>
In-Reply-To: <1390312859-27349-1-git-send-email-luiz.dentz@gmail.com>
References: <1390312859-27349-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tuesday 21 of January 2014 16:00:58 Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> In case the audio HAL disconnects without cleaning up its endpoints treat
> it as unclean disconnection and attempt to reconnect.
> ---
>  android/a2dp.c      | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>  android/audio-ipc.c | 13 +++++++---
>  android/audio-ipc.h |  2 +-
>  android/ipc.c       |  9 +++----
>  android/ipc.h       |  3 ++-
>  5 files changed, 83 insertions(+), 12 deletions(-)

Both patches applied, thanks.

-- 
Best regards, 
Szymon Janc
