Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1384517807-14745-1-git-send-email-szymon.janc@tieto.com>
References: <1384517807-14745-1-git-send-email-szymon.janc@tieto.com>
Date: Fri, 15 Nov 2013 14:53:49 +0200
Message-ID: <CABBYNZLaQeiC6v++H6XJNok49MZdX_PX1MkvVG+sfHHGVHGiZQ@mail.gmail.com>
Subject: Re: [PATCH] android: Fix not storing adapter index in index added event
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Nov 15, 2013 at 2:16 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> If controller was addded after daemon start its index was not stored
> resulting in mgmt commands to be always send to MGMT_INDEX_NONE index.
> ---
>  android/bluetooth.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 39589fa..b7c05e7 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -1356,6 +1356,8 @@ static void mgmt_index_added_event(uint16_t index, uint16_t length,
>                 return;
>         }
>
> +       adapter.index = index;
> +
>         if (mgmt_send(mgmt_if, MGMT_OP_READ_INFO, index, 0, NULL,
>                                 read_info_complete, cb, NULL) == 0) {
>                 cb(-EIO, NULL);
> --
> 1.8.4.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
