Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1393322970-27451-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393322970-27451-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1393322970-27451-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 26 Feb 2014 10:26:08 +0200
Message-ID: <CABBYNZKjRDqKgbozp0a4UfmkVc_DrdVWuDJoQatguNFyuQKyaw@mail.gmail.com>
Subject: Re: [PATCH 4/4] unit/avrcp: Add /TP/PTT/BV-05-I test
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Feb 25, 2014 at 12:09 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Test verifies that the Target reacts to the PASS THROUGH command in
> category 1 from the Controller. The command chosen is PLAY (0x44).
> The PLAY button is being pressed and released.
> ---
>  unit/test-avrcp.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
> index 66f0973..53e9237 100644
> --- a/unit/test-avrcp.c
> +++ b/unit/test-avrcp.c
> @@ -354,5 +354,15 @@ int main(int argc, char *argv[])
>                         raw_pdu(0x02, 0x11, 0x0e, 0x09, 0x48, 0x7c,
>                                 AVC_SELECT, 0x00));
>
> +       define_test("/TP/PTT/BV-05-I", test_server,
> +                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x7c,
> +                               AVC_PLAY, 0x00),
> +                       raw_pdu(0x02, 0x11, 0x0e, 0x09, 0x48, 0x7c,
> +                               AVC_PLAY, 0x00),
> +                       raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x7c,
> +                               AVC_PLAY | 0x80, 0x00),
> +                       raw_pdu(0x02, 0x11, 0x0e, 0x09, 0x48, 0x7c,
> +                               AVC_PLAY | 0x80, 0x00));
> +
>         return g_test_run();
>  }
> --
> 1.8.3.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
