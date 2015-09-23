Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1442948212-28447-1-git-send-email-szymon.janc@gmail.com>
References: <1442948212-28447-1-git-send-email-szymon.janc@gmail.com>
Date: Wed, 23 Sep 2015 10:56:17 +0300
Message-ID: <CABBYNZJ3q=9gJR6EHgLULcNZ_GgpS7+BEEa6F+KXEZ077WOymg@mail.gmail.com>
Subject: Re: [PATCH] audio/avrcp: Remove not needed null check in
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Sep 22, 2015 at 9:56 PM, Szymon Janc <szymon.janc@gmail.com> wrote:
> Browsing handlers are always getting valid pdu pointer so there is no
> need to double check that. Also pdu pointer is already dereferenced
> before calling handler.
> ---
>  profiles/audio/avrcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 53170ec..24deac5 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -1946,7 +1946,7 @@ static void avrcp_handle_get_folder_items(struct avrcp *session,
>         uint8_t scope;
>         uint8_t status = AVRCP_STATUS_SUCCESS;
>
> -       if (!pdu || ntohs(pdu->param_len) < 10) {
> +       if (ntohs(pdu->param_len) < 10) {
>                 status = AVRCP_STATUS_INVALID_PARAM;
>                 goto failed;
>         }
> --
> 2.5.0

Applied, thanks.


-- 
Luiz Augusto von Dentz
