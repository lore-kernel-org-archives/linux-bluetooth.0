Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1394543154-25355-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394458798-13822-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1394543154-25355-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 11 Mar 2014 16:06:04 +0200
Message-ID: <CABBYNZK6yEDvVwda3GBubgh2+J=SwE_Vmr5oEJ_hhqhOLd2CsA@mail.gmail.com>
Subject: Re: [PATCHv2 01/10] unit/avrcp: Pass context to control handlers
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Mar 11, 2014 at 3:05 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> ---
>  unit/test-avrcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
> index 9760420..fe7009a 100644
> --- a/unit/test-avrcp.c
> +++ b/unit/test-avrcp.c
> @@ -578,7 +578,7 @@ static void test_server(gconstpointer data)
>
>         avrcp_set_passthrough_handlers(context->session, passthrough_handlers,
>                                                                 context);
> -       avrcp_set_control_handlers(context->session, control_handlers, NULL);
> +       avrcp_set_control_handlers(context->session, control_handlers, context);
>
>         g_idle_add(send_pdu, context);
>
> --
> 1.8.3.2

Patches 1-5 are now applied, please rework the patch 6/10 so it
doesn't include avrcp-lib.h in avctp.c.


-- 
Luiz Augusto von Dentz
