Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1395149479-14180-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1395149479-14180-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 18 Mar 2014 17:10:05 +0200
Message-ID: <CABBYNZLKYToTagmUN=RhANVUTsK74EmHQxoSSsd0V+9Rf_Zdeg@mail.gmail.com>
Subject: Re: [PATCH] unit/avrcp: Fix possible buffer overflow
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Mar 18, 2014 at 3:31 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> values[] should be the same size as attr[].
> ---
>  unit/test-avrcp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
> index ec70da4..02f9949 100644
> --- a/unit/test-avrcp.c
> +++ b/unit/test-avrcp.c
> @@ -439,10 +439,12 @@ static int get_value_text(struct avrcp *session, uint8_t transaction,
>  static int get_value(struct avrcp *session, uint8_t transaction,
>                         uint8_t number, uint8_t *attrs, void *user_data)
>  {
> -       uint8_t values[2] = { 0x00, 0x00 };
> +       uint8_t values[number];
>
>         DBG("");
>
> +       memset(values, 0, number);
> +
>         avrcp_get_current_player_value_rsp(session, transaction, number, attrs,
>                                                                         values);
>
> --
> 1.8.3.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
