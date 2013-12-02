Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1385986848-8023-1-git-send-email-szymon.janc@tieto.com>
References: <1385986848-8023-1-git-send-email-szymon.janc@tieto.com>
Date: Mon, 2 Dec 2013 16:53:01 +0200
Message-ID: <CABBYNZKM-thtNmK3d4k4eWC6AyEUvtSKEGF=xP_fGfeZJo2Ftg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] android: IPC improvements - daemon part
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Dec 2, 2013 at 2:20 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> v3:
>  - rebased againt latest pan changes
>
> v2:
>  - rebased against latest IPC helpers improvements
>  - more compact command handlers table format
>  - error handling path in command handlers improved according to Johan comments
>  - randmon small fixes
>  - patches not directly related to refactor removed from serie, will
>    be send after this is merged
>
> v1:
> This serie implements IPC message handling iprovments in daemon similar
> to what is already done in HAL part.
>
> Szymon Janc (9):
>   android: Add initial code for IPC message handlers
>   android/main: Use generic IPC message handling for core service
>   android/main: Use common exit path in core service functions
>   android/bluetooth: Use generic IPC msg handling for commands
>   android/bluetooth: Make property handling function return HAL status
>   android/hidhost: Use generic IPC message handling for commands
>   android/pan: Use generic IPC message handling for commands
>   android/a2dp: Use generic IPC message handling for commands
>   android/socket: Use generic IPC message handling for commands
>
>  android/a2dp.c      |  69 ++++----
>  android/a2dp.h      |   2 -
>  android/bluetooth.c | 477 ++++++++++++++++++++++++++++++++++------------------
>  android/hidhost.c   | 309 ++++++++++++++++++++--------------
>  android/hidhost.h   |   2 -
>  android/ipc.c       |  78 +++++++++
>  android/ipc.h       |  10 ++
>  android/main.c      | 123 +++++---------
>  android/pan.c       |  87 +++++-----
>  android/pan.h       |   2 -
>  android/socket.c    | 102 ++++++-----
>  11 files changed, 754 insertions(+), 507 deletions(-)
>
> --
> 1.8.3.2

Pushed, thanks.


-- 
Luiz Augusto von Dentz
