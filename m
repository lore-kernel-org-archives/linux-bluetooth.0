Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1384869762-3097-1-git-send-email-szymon.janc@tieto.com>
References: <1384869762-3097-1-git-send-email-szymon.janc@tieto.com>
Date: Tue, 19 Nov 2013 16:44:13 +0200
Message-ID: <CABBYNZKoTeqriJREFFk-x+cUbS395M8P-M204Y47YVuEY=wFNQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] android: IPC improvements
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Nov 19, 2013 at 4:02 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> v3:
>  - fixed compilation on android 4.2
>
> Szymon Janc (6):
>   android/hal: Add initial code for IPC message handlers
>   android/hal-bluetooth: Register IPC message handlers
>   android/hal-hidhost: Use generic IPC message handling for events
>   android/hal-pan: Use generic IPC message handling for events
>   android/hal-a2dp: Use generic IPC message handling for events
>   android/hal: Check if command socket was shutdown by peer
>
>  android/hal-a2dp.c      |  41 +++++-----
>  android/hal-bluetooth.c | 208 ++++++++++++++++++++++++++++++------------------
>  android/hal-hidhost.c   |  76 ++++++++++--------
>  android/hal-ipc.c       | 123 +++++++++++++++++++---------
>  android/hal-ipc.h       |  10 +++
>  android/hal-pan.c       |  40 +++++-----
>  android/hal.h           |   4 -
>  7 files changed, 310 insertions(+), 192 deletions(-)
>
> --
> 1.8.4.3

Pushed, thanks.


-- 
Luiz Augusto von Dentz
