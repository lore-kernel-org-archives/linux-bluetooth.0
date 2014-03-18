Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1395144323-12283-1-git-send-email-luiz.dentz@gmail.com>
References: <1395144323-12283-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 18 Mar 2014 14:54:47 +0200
Message-ID: <CABBYNZ+v_xm5BC1VBaPc7xNrnEBzETmkb8WTOs7cnuNSViBNGw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] unit/test-avrcp: Fix using empty response to /TP/PAS/BV-08-C
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 18, 2014 at 2:05 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> The purpose of unit tests is to exercise the code as much as possible so
> return non-empty when testing avrcp_get_player_values_text_rsp.
> ---
>  unit/test-avrcp.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
> index 3235e48..dc22708 100644
> --- a/unit/test-avrcp.c
> +++ b/unit/test-avrcp.c
> @@ -339,9 +339,12 @@ static int get_value_text(struct avrcp *session, uint8_t transaction,
>                                 uint8_t attr, uint8_t number, uint8_t *values,
>                                 void *user_data)
>  {
> +       const char *text[] = { "on" };
> +
>         DBG("");
>
> -       avrcp_get_player_values_text_rsp(session, transaction, 0, NULL, NULL);
> +       avrcp_get_player_values_text_rsp(session, transaction, number,
> +                                                               values, text);
>
>         return -EINVAL;
>  }
> @@ -688,7 +691,8 @@ int main(int argc, char *argv[])
>                         raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
>                                 0x00, 0x19, 0x58,
>                                 AVRCP_GET_PLAYER_VALUE_TEXT,
> -                               0x00, 0x00, 0x01, 0x00));
> +                               0x00, 0x00, 0x07, 0x01, 0x01, 0x00,
> +                               0x6a, 0x02, 0x6f, 0x6e));
>
>         define_test("/TP/PAS/BV-09-C", test_client,
>                         raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> --
> 1.8.5.3

Pushed.


-- 
Luiz Augusto von Dentz
