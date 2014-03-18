Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1395145447-11205-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1395145447-11205-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 18 Mar 2014 14:43:37 +0200
Message-ID: <CABBYNZ+_QRkS3ffhxJ05ZnFV-Bj9iD0ToUZd9uL=8MrgyCs59Q@mail.gmail.com>
Subject: Re: [PATCH] android/avrcp: Fix possible buffer overflow
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Mar 18, 2014 at 2:24 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> ---
>  android/avrcp-lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
> index 5bbc407..509b6c1 100644
> --- a/android/avrcp-lib.c
> +++ b/android/avrcp-lib.c
> @@ -831,7 +831,7 @@ int avrcp_set_addressed_player(struct avrcp *session, uint16_t player_id,
>  int avrcp_get_capabilities_rsp(struct avrcp *session, uint8_t transaction,
>                                                 uint8_t number, uint8_t *events)
>  {
> -       uint8_t pdu[AVRCP_EVENT_LAST];
> +       uint8_t pdu[AVRCP_EVENT_LAST + 1];
>
>         if (number > AVRCP_EVENT_LAST)
>                 return -EINVAL;
> --
> 1.8.3.2

Applied.


-- 
Luiz Augusto von Dentz
