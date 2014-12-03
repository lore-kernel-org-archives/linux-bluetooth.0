Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417615733-7350-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1417615733-7350-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 3 Dec 2014 20:35:41 +0200
Message-ID: <CABBYNZKRXORa_7d+aaFfw7HOHvG8MsNRQNu0gR8wvG3SuGwOPQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] unit/gatt: Fix using possible negative return value
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Dec 3, 2014 at 4:08 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> ---
>  unit/test-gatt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> index 03a66b9..f20da91 100644
> --- a/unit/test-gatt.c
> +++ b/unit/test-gatt.c
> @@ -648,11 +648,11 @@ static void test_server(gconstpointer data)
>
>         len = write(context->fd, pdu.data, pdu.size);
>
> +       g_assert_cmpint(len, ==, pdu.size);
> +
>         if (g_test_verbose())
>                 util_hexdump('<', pdu.data, len, test_debug, "GATT: ");
>
> -       g_assert_cmpint(len, ==, pdu.size);
> -
>         execute_context(context);
>  }
>
> --
> 1.9.1

What changes does this make?


-- 
Luiz Augusto von Dentz
