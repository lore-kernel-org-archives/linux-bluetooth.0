Return-Path: <SRS0=+CIn=MU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E43C64EB8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Oct 2018 07:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE13D20878
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Oct 2018 07:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJpmpopl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE13D20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeJHPEW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:04:22 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:40982 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeJHPEW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Oct 2018 11:04:22 -0400
Received: by mail-oi1-f181.google.com with SMTP id l197-v6so15045387oib.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Oct 2018 00:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=OYgVjNfriVNlfqC9uOX/24N7t8XFl1bC09B7eBVdNH0=;
        b=aJpmpoplNNEu3wg6vAQXWBXNcq3KGZJ2oOoVV99Cb/0etNXYUg/pvdeo97JbqC1BUv
         pt9fKQZqmLttmF+24C7l8ChR7xyGahbMm679gC/Cb5wEBjx1UUkcmnb97OXdOrXq4cI9
         BxJZcPq2KXr0+lCLnx5a5fqPhLetTMEmw6tObyyd9D0cFDidJhpz+7AJ6zLoSZK7D8FY
         p1wn7PXyg2fEHqhBI6B7fFqLTmfu684T0zo3ib0OV5wQ9KGzE0b4TgDlB/Hml1/ECMdR
         6tDxyOdAv7nOrKVWfSVYc1yBYnSZH55wfallbW0mfUUVZdxEcIfRfinPSqNgxkZ2Qzvm
         GtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=OYgVjNfriVNlfqC9uOX/24N7t8XFl1bC09B7eBVdNH0=;
        b=k8WWoNAr4ewMOCeoWOjsE+Cenecvvwfw6T30dBdTi6KtjXgOm8HuwpSK0gYWYjM1i5
         C/3MTuuQt/JiTC6QneK7QlSyNkQGlODqGh0C/gWtfq21Odb3Qj/F6XZdAo7YzWjLTbWu
         907IMN2rP7qgmZ5DYYSoG9DmN9CY26nZMx+/g2MQPlMLHSV20oEXEzeDRBaD1D8OyFFC
         85s0Oj2tpm6Z2XL3H4mDi6iHVvbHkB7BSedSGObGMb07QJBJUYLU4zUUmE6+1MNsNBpW
         XCyT3S+vc1e2CQ0a7zblHrmSU1bVr2X9N/xD++UFDPXWttyUPbVzB++4YcbzI9OA4yoy
         Y5jg==
X-Gm-Message-State: ABuFfojgK/6QxRiO9e96LRJ2s/vkfC4yKoJc6IdT0Lp74a27RVyjYyAo
        xxEGQcIENQSshn2cGNdIWgKDwq0BA+TFxlv1NrlCmw==
X-Google-Smtp-Source: ACcGV602/yVZeHbCN1r7qI6naglDD0gvP8DEaMFnMMmGh+9a8AeY5Wx2VHCRKRX0jhHFjOdQOjlTA5tQlhfpBd2bKyU=
X-Received: by 2002:aca:c28b:: with SMTP id s133-v6mr4761512oif.219.1538985236134;
 Mon, 08 Oct 2018 00:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181005090026.7535-1-luiz.dentz@gmail.com>
In-Reply-To: <20181005090026.7535-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Oct 2018 10:53:43 +0300
Message-ID: <CABBYNZ+Qn35uZHNA16XeBGgFUEK=5uoSRtnpeV5e=hkuo5Zs=Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] shared/tester: Add option to print to monitor
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Fri, Oct 5, 2018 at 12:00 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds option -m/--monitor that can be used toguether with
> tester_monitor to send protocol data to be decoded by btmon.
>
> In addition to that this also logs the tester output into btmon since
> that has support to store its output on file this can be quite
> convenient for reporting.
> ---
>  src/shared/tester.c | 237 ++++++++++++++++++++++++++++++++++++++++----
>  src/shared/tester.h |   4 +
>  2 files changed, 220 insertions(+), 21 deletions(-)
>
> diff --git a/src/shared/tester.c b/src/shared/tester.c
> index 80d65110b..05c81a66d 100644
> --- a/src/shared/tester.c
> +++ b/src/shared/tester.c
> @@ -27,14 +27,19 @@
>
>  #include <stdio.h>
>  #include <errno.h>
> +#include <syslog.h>
>  #include <unistd.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <signal.h>
>  #include <sys/signalfd.h>
> +#include <sys/socket.h>
>
>  #include <glib.h>
>
> +#include "lib/bluetooth.h"
> +#include "lib/hci.h"
> +
>  #ifdef HAVE_VALGRIND_MEMCHECK_H
>  #include <valgrind/memcheck.h>
>  #endif
> @@ -54,15 +59,15 @@
>  #define COLOR_HIGHLIGHT        "\x1B[1;39m"
>
>  #define print_text(color, fmt, args...) \
> -               printf(color fmt COLOR_OFF "\n", ## args)
> +               tester_log(color fmt COLOR_OFF, ## args)
>
>  #define print_summary(label, color, value, fmt, args...) \
> -                       printf("%-52s " color "%-10s" COLOR_OFF fmt "\n", \
> +               tester_log("%-52s " color "%-10s" COLOR_OFF fmt, \
>                                                         label, value, ## args)
>
>  #define print_progress(name, color, fmt, args...) \
> -               printf(COLOR_HIGHLIGHT "%s" COLOR_OFF " - " \
> -                               color fmt COLOR_OFF "\n", name, ## args)
> +               tester_log(COLOR_HIGHLIGHT "%s" COLOR_OFF " - " \
> +                               color fmt COLOR_OFF, name, ## args)
>
>  enum test_result {
>         TEST_RESULT_NOT_RUN,
> @@ -100,6 +105,7 @@ struct test_case {
>  };
>
>  static GMainLoop *main_loop;
> +static char *tester_name;
>
>  static GList *test_list;
>  static GList *test_current;
> @@ -108,9 +114,25 @@ static GTimer *test_timer;
>  static gboolean option_version = FALSE;
>  static gboolean option_quiet = FALSE;
>  static gboolean option_debug = FALSE;
> +static gboolean option_monitor = FALSE;
>  static gboolean option_list = FALSE;
>  static const char *option_prefix = NULL;
>
> +struct monitor_hdr {
> +       uint16_t opcode;
> +       uint16_t index;
> +       uint16_t len;
> +       uint8_t  priority;
> +       uint8_t  ident_len;
> +} __attribute__((packed));
> +
> +struct monitor_l2cap_hdr {
> +       uint16_t cid;
> +       uint16_t psm;
> +} __attribute__((packed));
> +
> +static int monitor_fd = -1;
> +
>  static void test_destroy(gpointer data)
>  {
>         struct test_case *test = data;
> @@ -128,43 +150,208 @@ static void test_destroy(gpointer data)
>         free(test);
>  }
>
> -void tester_print(const char *format, ...)
> +static int monitor_open(void)
>  {
> -       va_list ap;
> +       struct sockaddr_hci addr;
> +       int fd;
> +
> +       if (!option_monitor)
> +               return -1;
> +
> +       if (monitor_fd >= 0)
> +               return monitor_fd;
> +
> +       fd = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
> +       if (fd < 0)
> +               return fd;
> +
> +       memset(&addr, 0, sizeof(addr));
> +       addr.hci_family = AF_BLUETOOTH;
> +       addr.hci_dev = HCI_DEV_NONE;
> +       addr.hci_channel = HCI_CHANNEL_LOGGING;
> +
> +       if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> +               option_monitor = FALSE;
> +               tester_debug("Failed to open monitor socket: %s",
> +                            strerror(errno));
> +               close(fd);
> +               return -1;
> +       }
> +
> +       monitor_fd = fd;
> +
> +       return fd;
> +}
> +
> +static void monitor_sendmsg(const char *label, int level, struct iovec *io,
> +                                                       size_t io_len)
> +{
> +       struct monitor_hdr hdr;
> +       struct msghdr msg;
> +       struct iovec iov[5];
> +       size_t i;
> +
> +       monitor_fd = monitor_open();
> +       if (monitor_fd < 0 || io_len > 3)
> +               return;
> +
> +       hdr.opcode = cpu_to_le16(0x0000);
> +       hdr.index = cpu_to_le16(0xffff);
> +       hdr.ident_len = strlen(label) + 1;
> +       hdr.len = cpu_to_le16(2 + hdr.ident_len);
> +       hdr.priority = level;
> +
> +       iov[0].iov_base = &hdr;
> +       iov[0].iov_len = sizeof(hdr);
> +
> +       iov[1].iov_base = (void *) label;
> +       iov[1].iov_len = hdr.ident_len;
> +
> +       memset(&msg, 0, sizeof(msg));
> +       msg.msg_iov = iov;
> +       msg.msg_iovlen = 2;
> +
> +       for (i = 0; i < io_len; i++) {
> +               iov[i + 2] = io[i];
> +               hdr.len += io[i].iov_len;
> +               msg.msg_iovlen++;
> +       }
>
> +       if (sendmsg(monitor_fd, &msg, 0) < 0) {
> +               /* Disable monitor */
> +               option_monitor = FALSE;
> +               tester_debug("Failed to send to monitor: %s", strerror(errno));
> +               close(monitor_fd);
> +               monitor_fd = -1;
> +       }
> +}
> +
> +static void monitor_vprintf(const char *id, int level, const char *format,
> +                                                               va_list ap)
> +{
> +       struct iovec iov;
> +       char *str;
> +
> +       if (!option_monitor)
> +               return;
> +
> +       if (vasprintf(&str, format, ap) < 0)
> +               return;
> +
> +       iov.iov_base = str;
> +       iov.iov_len = strlen(str) + 1;
> +
> +       monitor_sendmsg(id, level, &iov, 1);
> +
> +       free(str);
> +}
> +
> +static void tester_vprintf(const char *format, va_list ap)
> +{
>         if (tester_use_quiet())
>                 return;
>
>         printf("  %s", COLOR_WHITE);
> +       vprintf(format, ap);
> +       printf("%s\n", COLOR_OFF);
> +}
> +
> +static void tester_log(const char *format, ...)
> +{
> +       va_list ap;
> +
>         va_start(ap, format);
>         vprintf(format, ap);
> +       printf("\n");
> +       va_end(ap);
> +
> +       va_start(ap, format);
> +       monitor_vprintf(tester_name, LOG_INFO, format, ap);
> +       va_end(ap);
> +}
> +
> +void tester_print(const char *format, ...)
> +{
> +       va_list ap;
> +
> +       va_start(ap, format);
> +       tester_vprintf(format, ap);
> +       va_end(ap);
> +
> +       va_start(ap, format);
> +       monitor_vprintf(tester_name, LOG_INFO, format, ap);
>         va_end(ap);
> -       printf("%s\n", COLOR_OFF);
>  }
>
>  void tester_debug(const char *format, ...)
>  {
>         va_list ap;
>
> -       if (!tester_use_debug())
> -               return;
> +       va_start(ap, format);
> +       tester_vprintf(format, ap);
> +       va_end(ap);
>
> -       printf("  %s", COLOR_WHITE);
>         va_start(ap, format);
> -       vprintf(format, ap);
> +       monitor_vprintf(tester_name, LOG_DEBUG, format, ap);
>         va_end(ap);
> -       printf("%s\n", COLOR_OFF);
>  }
>
>  void tester_warn(const char *format, ...)
>  {
>         va_list ap;
>
> -       printf("  %s", COLOR_WHITE);
>         va_start(ap, format);
> -       vprintf(format, ap);
> +       tester_vprintf(format, ap);
> +       va_end(ap);
> +
> +       va_start(ap, format);
> +       monitor_vprintf(tester_name, LOG_WARNING, format, ap);
>         va_end(ap);
> -       printf("%s\n", COLOR_OFF);
> +}
> +
> +static void monitor_debug(const char *str, void *user_data)
> +{
> +       const char *label = user_data;
> +
> +       tester_debug("%s: %s", label, str);
> +}
> +
> +static void monitor_log(char dir, uint16_t cid, uint16_t psm, const void *data,
> +                                                               size_t len)
> +{
> +       struct iovec iov[3];
> +       struct monitor_l2cap_hdr hdr;
> +       uint8_t term = 0x00;
> +       char label[16];
> +
> +       if (snprintf(label, sizeof(label), "%c %s", dir, tester_name) < 0)
> +               return;
> +
> +       hdr.cid = cpu_to_le16(cid);
> +       hdr.psm = cpu_to_le16(psm);
> +
> +       iov[0].iov_base = &hdr;
> +       iov[0].iov_len = sizeof(hdr);
> +
> +       iov[1].iov_base = (void *) data;
> +       iov[1].iov_len = len;
> +
> +       /* Kernel won't forward if data is no NULL terminated */
> +       iov[2].iov_base = &term;
> +       iov[2].iov_len = sizeof(term);
> +
> +       monitor_sendmsg(label, LOG_INFO, iov, 3);
> +}
> +
> +void tester_monitor(char dir, uint16_t cid, uint16_t psm, const void *data,
> +                                                               size_t len)
> +{
> +       monitor_log(dir, cid, psm, data, len);
> +
> +       if (!tester_use_debug())
> +               return;
> +
> +       util_hexdump(dir, data, len, monitor_debug, (void *) tester_name);
>  }
>
>  static void default_pre_setup(const void *test_data)
> @@ -208,7 +395,7 @@ void tester_add_full(const char *name, const void *test_data,
>         }
>
>         if (option_list) {
> -               printf("%s\n", name);
> +               tester_log("%s", name);
>                 if (destroy)
>                         destroy(user_data);
>                 return;
> @@ -278,7 +465,7 @@ static int tester_summarize(void)
>         gdouble execution_time;
>         GList *list;
>
> -       printf("\n");
> +       tester_log("");
>         print_text(COLOR_HIGHLIGHT, "");
>         print_text(COLOR_HIGHLIGHT, "Test Summary");
>         print_text(COLOR_HIGHLIGHT, "------------");
> @@ -312,17 +499,17 @@ static int tester_summarize(void)
>                 }
>          }
>
> -       printf("\nTotal: %d, "
> +       tester_log("Total: %d, "
>                 COLOR_GREEN "Passed: %d (%.1f%%)" COLOR_OFF ", "
>                 COLOR_RED "Failed: %d" COLOR_OFF ", "
> -               COLOR_YELLOW "Not Run: %d" COLOR_OFF "\n",
> +               COLOR_YELLOW "Not Run: %d" COLOR_OFF,
>                         not_run + passed + failed, passed,
>                         (not_run + passed + failed) ?
>                         (float) passed * 100 / (not_run + passed + failed) : 0,
>                         failed, not_run);
>
>         execution_time = g_timer_elapsed(test_timer, NULL);
> -       printf("Overall execution time: %.3g seconds\n", execution_time);
> +       tester_log("Overall execution time: %.3g seconds", execution_time);
>
>         return failed;
>  }
> @@ -379,7 +566,7 @@ static void next_test_case(void)
>
>         test = test_current->data;
>
> -       printf("\n");
> +       tester_log("");
>         print_progress(test->name, COLOR_BLACK, "init");
>
>         test->start_time = g_timer_elapsed(test_timer, NULL);
> @@ -774,6 +961,8 @@ static GOptionEntry options[] = {
>                                 "Run tests without logging" },
>         { "debug", 'd', 0, G_OPTION_ARG_NONE, &option_debug,
>                                 "Run tests with debug output" },
> +       { "monitor", 'm', 0, G_OPTION_ARG_NONE, &option_monitor,
> +                               "Enable monitor output" },
>         { "list", 'l', 0, G_OPTION_ARG_NONE, &option_list,
>                                 "Only list the tests to be run" },
>         { "prefix", 'p', 0, G_OPTION_ARG_STRING, &option_prefix,
> @@ -807,6 +996,12 @@ void tester_init(int *argc, char ***argv)
>
>         main_loop = g_main_loop_new(NULL, FALSE);
>
> +       tester_name = strrchr(*argv[0], '/');
> +       if (!tester_name)
> +               tester_name = strdup(*argv[0]);
> +       else
> +               tester_name = strdup(++tester_name);
> +
>         test_list = NULL;
>         test_current = NULL;
>  }
> diff --git a/src/shared/tester.h b/src/shared/tester.h
> index 83ef5de7a..96e8dc901 100644
> --- a/src/shared/tester.h
> +++ b/src/shared/tester.h
> @@ -22,6 +22,8 @@
>   */
>
>  #include <stdbool.h>
> +#include <stddef.h>
> +#include <stdint.h>
>
>  void tester_init(int *argc, char ***argv);
>  int tester_run(void);
> @@ -35,6 +37,8 @@ void tester_warn(const char *format, ...)
>                                 __attribute__((format(printf, 1, 2)));
>  void tester_debug(const char *format, ...)
>                                 __attribute__((format(printf, 1, 2)));
> +void tester_monitor(char dir, uint16_t cid, uint16_t psm, const void *data,
> +                                                               size_t len);
>
>  typedef void (*tester_destroy_func_t)(void *user_data);
>  typedef void (*tester_data_func_t)(const void *test_data);
> --
> 2.17.1

Applied.

-- 
Luiz Augusto von Dentz
