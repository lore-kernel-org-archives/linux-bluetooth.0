Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1382443438-28452-1-git-send-email-szymon.janc@tieto.com>
References: <1382443438-28452-1-git-send-email-szymon.janc@tieto.com>
Date: Tue, 22 Oct 2013 15:11:17 +0300
Message-ID: <CABBYNZ+PGCi+bY_wVC5cuXp-0TeYJP5yXUw4ZZEk9gGn_=-h-w@mail.gmail.com>
Subject: Re: [PATCH] android/hal: Fix receiving of commands with no response parameter
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Oct 22, 2013 at 3:03 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> This fix receiving of error response in case command has no reply
> parameters.
> ---
>  android/hal-ipc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/android/hal-ipc.c b/android/hal-ipc.c
> index 041441d..b264bfe 100644
> --- a/android/hal-ipc.c
> +++ b/android/hal-ipc.c
> @@ -260,6 +260,7 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
>
>         if (!rsp || rsp_len == 0) {
>                 memset(&err, 0, sizeof(err));
> +               rsp_len = sizeof(err);
>                 rsp = &err;
>         }
>
> --
> 1.8.4

Pushed, thanks.


-- 
Luiz Augusto von Dentz
