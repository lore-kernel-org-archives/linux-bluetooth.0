Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415664656-36676-1-git-send-email-jamuraa@chromium.org>
References: <1415664656-36676-1-git-send-email-jamuraa@chromium.org>
Date: Tue, 11 Nov 2014 14:41:01 +0200
Message-ID: <CABBYNZJgwjDFtYY-iSwqzqpyVgE8_0qN=4ZrY4PCsABF4BP-Ow@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/att: bugfix for BT_ATT_ALL_REQUESTS
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Tue, Nov 11, 2014 at 2:10 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> opcode can now be zero, since that is BT_ATT_ALL_REQUESTS
>
> ---
>  src/shared/att.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index aa80cef..48c36ac 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -1115,7 +1115,7 @@ unsigned int bt_att_register(struct bt_att *att, uint8_t opcode,
>  {
>         struct att_notify *notify;
>
> -       if (!att || !opcode || !callback || !att->io)
> +       if (!att || !callback || !att->io)
>                 return 0;
>
>         notify = new0(struct att_notify, 1);
> --
> 2.1.0.rc2.206.gedb03e5

Applied, thanks.


-- 
Luiz Augusto von Dentz
