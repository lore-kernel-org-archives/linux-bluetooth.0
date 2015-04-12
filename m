Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1428674761-24609-1-git-send-email-luiz.dentz@gmail.com>
References: <1428674761-24609-1-git-send-email-luiz.dentz@gmail.com>
Date: Sun, 12 Apr 2015 21:58:19 +0300
Message-ID: <CABBYNZLSFL2DvN0Hz_AUZkQonPN10njY2MPeCCXX2dWEx91izw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/9] unit/test-crc: Use tester framework
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Apr 10, 2015 at 5:05 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  Makefile.am     |  2 +-
>  unit/test-crc.c | 37 ++++++++++++++++++-------------------
>  2 files changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index 2a1fe76..f9f26aa 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -282,7 +282,7 @@ unit_test_textfile_LDADD = @GLIB_LIBS@
>  unit_tests += unit/test-crc
>
>  unit_test_crc_SOURCES = unit/test-crc.c monitor/crc.h monitor/crc.c
> -unit_test_crc_LDADD = @GLIB_LIBS@
> +unit_test_crc_LDADD = src/libshared-glib.la @GLIB_LIBS@
>
>  unit_tests += unit/test-crypto
>
> diff --git a/unit/test-crc.c b/unit/test-crc.c
> index db40dc9..791fa51 100644
> --- a/unit/test-crc.c
> +++ b/unit/test-crc.c
> @@ -26,6 +26,7 @@
>  #endif
>
>  #include "monitor/crc.h"
> +#include "src/shared/tester.h"
>
>  #include <glib.h>
>
> @@ -160,35 +161,33 @@ static void test_crc(gconstpointer data)
>         crc = crc24_calculate(crc_init, test_data->packet + 4,
>                                                 test_data->size - 7);
>
> -       if (g_test_verbose())
> -               g_print("CRC: 0x%6.6x, Calculated: 0x%6.6x\n",
> -                                               crc_value, crc);
> +       tester_debug("CRC: 0x%6.6x, Calculated: 0x%6.6x", crc_value, crc);
>
>         g_assert(crc_value == crc);
>
>         rev = crc24_reverse(crc_value, test_data->packet + 4,
>                                                 test_data->size - 7);
>
> -       if (g_test_verbose())
> -               g_print("Preset: 0x%6.6x, Calculated: 0x%6.6x\n",
> -                                               crc_init, rev);
> +       tester_debug("Preset: 0x%6.6x, Calculated: 0x%6.6x", crc_init, rev);
>
>         g_assert(crc_init == rev);
> +
> +       tester_test_passed();
>  }
>
>  int main(int argc, char *argv[])
>  {
> -       g_test_init(&argc, &argv, NULL);
> -
> -       g_test_add_data_func("/crc/1", &crc_1, test_crc);
> -       g_test_add_data_func("/crc/2", &crc_2, test_crc);
> -       g_test_add_data_func("/crc/3", &crc_3, test_crc);
> -       g_test_add_data_func("/crc/4", &crc_4, test_crc);
> -       g_test_add_data_func("/crc/5", &crc_5, test_crc);
> -       g_test_add_data_func("/crc/6", &crc_6, test_crc);
> -       g_test_add_data_func("/crc/7", &crc_7, test_crc);
> -       g_test_add_data_func("/crc/8", &crc_8, test_crc);
> -       g_test_add_data_func("/crc/9", &crc_9, test_crc);
> -
> -       return g_test_run();
> +       tester_init(&argc, &argv);
> +
> +       tester_add("/crc/1", &crc_1, NULL, test_crc, NULL);
> +       tester_add("/crc/2", &crc_2, NULL, test_crc, NULL);
> +       tester_add("/crc/3", &crc_3, NULL, test_crc, NULL);
> +       tester_add("/crc/4", &crc_4, NULL, test_crc, NULL);
> +       tester_add("/crc/5", &crc_5, NULL, test_crc, NULL);
> +       tester_add("/crc/6", &crc_6, NULL, test_crc, NULL);
> +       tester_add("/crc/7", &crc_7, NULL, test_crc, NULL);
> +       tester_add("/crc/8", &crc_8, NULL, test_crc, NULL);
> +       tester_add("/crc/9", &crc_9, NULL, test_crc, NULL);
> +
> +       return tester_run();
>  }
> --
> 2.1.0

Applied.


-- 
Luiz Augusto von Dentz
