Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1394442593-4233-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394442593-4233-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 10 Mar 2014 15:01:33 +0200
Message-ID: <CABBYNZJKy=Ed5_NOTq8OEv-cDRyqDorAzyLW-QRvaxzDmKVQ-w@mail.gmail.com>
Subject: Re: [PATCHv2 01/10] unit/avrcp: Add /TP/MDI/BV-01-C test
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Mar 10, 2014 at 11:09 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Test verifies Get play status.
> ---
>  unit/test-avrcp.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
> index db1a67e..4f81954 100644
> --- a/unit/test-avrcp.c
> +++ b/unit/test-avrcp.c
> @@ -459,6 +459,23 @@ static ssize_t avrcp_handle_set_player_value(struct avrcp *session,
>         return 1;
>  }
>
> +static ssize_t avrcp_handle_get_play_status(struct avrcp *session,
> +                                               uint8_t transaction,
> +                                               uint16_t params_len,
> +                                               uint8_t *params,
> +                                               void *user_data)
> +{
> +       DBG("");
> +
> +       if (params_len)
> +               return -EINVAL;
> +
> +       avrcp_get_play_status_rsp(session, transaction, 0xaaaaaaaa, 0xbbbbbbbb,
> +                                                                       0x00);
> +
> +       return -EAGAIN;
> +}
> +
>  static const struct avrcp_control_handler control_handlers[] = {
>                 { AVRCP_GET_CAPABILITIES,
>                                         AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
> @@ -481,6 +498,9 @@ static const struct avrcp_control_handler control_handlers[] = {
>                 { AVRCP_SET_PLAYER_VALUE,
>                                         AVC_CTYPE_CONTROL, AVC_CTYPE_STABLE,
>                                         avrcp_handle_set_player_value },
> +               { AVRCP_GET_PLAY_STATUS,
> +                                       AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
> +                                       avrcp_handle_get_play_status },
>                 { },
>  };
>
> @@ -782,5 +802,16 @@ int main(int argc, char *argv[])
>                                 0x00, 0x19, 0x58, AVRCP_GET_PLAY_STATUS,
>                                 0x00, 0x00, 0x00));
>
> +       /* Get play status - TG */
> +       define_test("/TP/MDI/BV-02-C", test_server,
> +                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
> +                               0x00, 0x19, 0x58, AVRCP_GET_PLAY_STATUS,
> +                               0x00, 0x00, 0x00),
> +                       raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
> +                               0x00, 0x19, 0x58, AVRCP_GET_PLAY_STATUS,
> +                               0x00, 0x00, 0x09, 0xaa, 0xaa, 0xaa,
> +                               0xaa, 0xbb, 0xbb, 0xbb, 0xbb, 0x00));
> +
> +
>         return g_test_run();
>  }
> --
> 1.8.3.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
