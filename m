Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Nov 2013 15:18:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] android: Improve IPC helper to not send invalid
 status response
Message-ID: <20131118131848.GA11568@x220.p-661hnu-f1>
References: <1384779520-2104-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384779520-2104-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Nov 18, 2013, Szymon Janc wrote:
> This fix issue with sending invalid success response from several
> places where ipc_send_rsp was used for reporting success. Instead of
> using using ipc_send for success response, make helper handle that.
> ---
> V2: fixed hardcoded service id in ipc_send_rsp
> 
>  android/a2dp.c      |  2 +-
>  android/bluetooth.c |  2 +-
>  android/hidhost.c   |  2 +-
>  android/ipc.c       |  7 ++++++-
>  android/ipc.h       |  2 +-
>  android/main.c      | 12 ++++++++----
>  android/pan.c       |  2 +-
>  android/socket.c    |  2 +-
>  8 files changed, 20 insertions(+), 11 deletions(-)

Both patches have been applied. Thanks.

Johan
