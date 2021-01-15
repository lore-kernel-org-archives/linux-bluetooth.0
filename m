Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBF8C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 11:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3216E23730
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 11:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbhAOL4B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Jan 2021 06:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbhAOL4A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Jan 2021 06:56:00 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D643C0613C1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 03:55:20 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id u21so10116141lja.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 03:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0DR23Uv36lFOeyWc2E3fpzQQ6ex6kJ4apVo9RFeX4k=;
        b=UqEtJ1mjDwIc/3+1wbqsIaayxInH8tt0oyZnUarAcUccR8VNH6LMeIPxPc79fbjpl6
         aktKpPJz+enPzaz1AMdEe9Zye0io1nXB+8Jp1HTH3+ue3T21PMyVcFV4lbsmViEX0B6z
         qnTjwt3LizGoToWRe5g3d+0pg+rZhXBpBgzVj83q9uje19eEnRRCplaLNeo+pL82hYMf
         mpz+OMNhXvCIGuM1aM6Ln0IXBimttlbnQHPUaqcq36I7cvxnN9M50uVlGVkR1o7vYloB
         Z6zG5t5aRcJuoFgki7zcaNTOvkBVcdb7hFjfCVvZra+t7evmIXudMa2c6iTl2mLA6iWy
         cWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0DR23Uv36lFOeyWc2E3fpzQQ6ex6kJ4apVo9RFeX4k=;
        b=McUmzVK13MDya7yjD0SoSZsCH3imYp69cAgM/G6UjuFyXem7Oorvubvqz5k3d/II4e
         qcLR7rcv8NXe4GTlAyb1OgnisCD3un6+emlUhTrTLVyPWOUzyCgkYP2S4MrA+Nb04vOR
         ISTm4ZWy6l5CHsJuGlMpuTpjcHitusNAsvR+4q+rDke3h5h4DPiwLspdBUs81hj/s6kA
         FybzpBtFpM982sK+KWj7dSmAwH1zgyUEfNGqPIF3QnTlVltlUds2Nldro0FIk20hohZH
         vQn3VZh4CWmqrJRlmp/prZ+jh3ApGMauUTRfSf8cMMGPqYI5raiPvvueIr5gRzUAv998
         7WCw==
X-Gm-Message-State: AOAM532OPPHZY7lDovyvXyF0mxWMt19BD4J6TzQhMEofwWDR1dFaNTk2
        EqhgbEfzYcAuyco93BVfNbfvRY93mF9LtYIo13BFQg==
X-Google-Smtp-Source: ABdhPJzNk63Xi33ihquQKLnl0DPHjJdNubRLw1Hd/UurkkE0yfBpJ6HrWLEb5le07geAKAsMQ7m3gHAa11eo5J3aZ4Q=
X-Received: by 2002:a2e:b166:: with SMTP id a6mr4957998ljm.100.1610711718302;
 Fri, 15 Jan 2021 03:55:18 -0800 (PST)
MIME-Version: 1.0
References: <20210114074458.3399055-1-apusaka@google.com> <20210114154405.Bluez.v3.4.I20391efb1b5a40cd2b0cb6069d88b7fb9f7ed66b@changeid>
 <CABBYNZKTqLQeDOEiY2FC2mm8U3jNRsR6ySnkyzBEW9K+bxoCKQ@mail.gmail.com>
In-Reply-To: <CABBYNZKTqLQeDOEiY2FC2mm8U3jNRsR6ySnkyzBEW9K+bxoCKQ@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Fri, 15 Jan 2021 19:55:07 +0800
Message-ID: <CAJQfnxGVKfzL-1Lt-mdH6j6HLHubKO88g0-TA_KJLxNmeyg5Pg@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 4/5] bluetoothctl: advmon rssi support for mgmt
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, 15 Jan 2021 at 02:42, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Wed, Jan 13, 2021 at 11:45 PM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > Using the new opcode MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI to
> > monitor advertisement according to some RSSI criteria.
> >
> > Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> > ---
> >
> > Changes in v3:
> > * split the struct RSSIThresholdsAndTimers
> >
> >  client/adv_monitor.c | 162 ++++++++++++++++++++++++++-----------------
> >  client/adv_monitor.h |   1 +
> >  client/main.c        |  29 ++++----
> >  3 files changed, 113 insertions(+), 79 deletions(-)
> >
> > diff --git a/client/adv_monitor.c b/client/adv_monitor.c
> > index f62e9f4442..37faf1edfa 100644
> > --- a/client/adv_monitor.c
> > +++ b/client/adv_monitor.c
> > @@ -30,9 +30,10 @@
> >
> >  struct rssi_setting {
> >         int16_t high_threshold;
> > -       uint16_t high_timer;
> > +       uint16_t high_timeout;
> >         int16_t low_threshold;
> > -       uint16_t low_timer;
> > +       uint16_t low_timeout;
> > +       uint16_t sampling_period;
> >  };
> >
> >  struct pattern {
> > @@ -131,24 +132,58 @@ static gboolean get_type(const GDBusPropertyTable *property,
> >         return TRUE;
> >  }
> >
> > -static gboolean get_rssi(const GDBusPropertyTable *property,
> > +static gboolean get_low_threshold(const GDBusPropertyTable *property,
> >                                 DBusMessageIter *iter, void *user_data)
> >  {
> >         struct adv_monitor *adv_monitor = user_data;
> >         struct rssi_setting *rssi = adv_monitor->rssi;
> > -       DBusMessageIter data_iter;
> >
> > -       dbus_message_iter_open_container(iter, DBUS_TYPE_STRUCT,
> > -                                                       NULL, &data_iter);
> > -       dbus_message_iter_append_basic(&data_iter, DBUS_TYPE_INT16,
> > -                                                       &rssi->high_threshold);
> > -       dbus_message_iter_append_basic(&data_iter, DBUS_TYPE_UINT16,
> > -                                                       &rssi->high_timer);
> > -       dbus_message_iter_append_basic(&data_iter, DBUS_TYPE_INT16,
> > +       dbus_message_iter_append_basic(iter, DBUS_TYPE_INT16,
> >                                                         &rssi->low_threshold);
> > -       dbus_message_iter_append_basic(&data_iter, DBUS_TYPE_UINT16,
> > -                                                       &rssi->low_timer);
> > -       dbus_message_iter_close_container(iter, &data_iter);
> > +       return TRUE;
> > +}
> > +
> > +static gboolean get_high_threshold(const GDBusPropertyTable *property,
> > +                               DBusMessageIter *iter, void *user_data)
> > +{
> > +       struct adv_monitor *adv_monitor = user_data;
> > +       struct rssi_setting *rssi = adv_monitor->rssi;
> > +
> > +       dbus_message_iter_append_basic(iter, DBUS_TYPE_INT16,
> > +                                                       &rssi->high_threshold);
> > +       return TRUE;
> > +}
> > +
> > +static gboolean get_low_timeout(const GDBusPropertyTable *property,
> > +                               DBusMessageIter *iter, void *user_data)
> > +{
> > +       struct adv_monitor *adv_monitor = user_data;
> > +       struct rssi_setting *rssi = adv_monitor->rssi;
> > +
> > +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
> > +                                                       &rssi->low_timeout);
> > +       return TRUE;
> > +}
> > +
> > +static gboolean get_high_timeout(const GDBusPropertyTable *property,
> > +                               DBusMessageIter *iter, void *user_data)
> > +{
> > +       struct adv_monitor *adv_monitor = user_data;
> > +       struct rssi_setting *rssi = adv_monitor->rssi;
> > +
> > +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
> > +                                                       &rssi->high_timeout);
> > +       return TRUE;
> > +}
> > +
> > +static gboolean get_sampling_period(const GDBusPropertyTable *property,
> > +                               DBusMessageIter *iter, void *user_data)
> > +{
> > +       struct adv_monitor *adv_monitor = user_data;
> > +       struct rssi_setting *rssi = adv_monitor->rssi;
> > +
> > +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
> > +                                                       &rssi->sampling_period);
> >         return TRUE;
> >  }
> >
> > @@ -212,7 +247,11 @@ static gboolean pattern_exists(const GDBusPropertyTable *property, void *data)
> >
> >  static const GDBusPropertyTable adv_monitor_props[] = {
> >         { "Type", "s", get_type },
> > -       { "RSSIThresholdsAndTimers", "(nqnq)", get_rssi, NULL, rssi_exists },
> > +       { "RSSILowThreshold", "n", get_low_threshold, NULL, rssi_exists },
> > +       { "RSSIHighThreshold", "n", get_high_threshold, NULL, rssi_exists },
> > +       { "RSSILowTimeout", "q", get_low_timeout, NULL, rssi_exists },
> > +       { "RSSIHighTimeout", "q", get_high_timeout, NULL, rssi_exists },
> > +       { "RSSISamplingPeriod", "q", get_sampling_period, NULL, rssi_exists },
>
> Interesting, is the SamplingPeriod new? It seems we are missing the
> documentation changes of the split.

Yes, it is new. The purpose is to make it compatible with the add
monitor MGMT command. Also yes, I forgot to update the doc. Will do so
in v4.
>
> >         { "Patterns", "a(yyay)", get_patterns, NULL, pattern_exists },
> >         { }
> >  };
> > @@ -376,56 +415,51 @@ static uint8_t str2bytearray(char *str, uint8_t *arr)
> >         return arr_len;
> >  }
> >
> > -static void parse_rssi_value_pair(char *value_pair, int *low, int *high)
> > -{
> > -       char *val1, *val2;
> > -       bool flag = value_pair[0] == ',';
> > -
> > -       val1 = strtok(value_pair, ",");
> > -
> > -       if (!val1)
> > -               return;
> > -
> > -       val2 = strtok(NULL, ",");
> > -
> > -       if (!val2) {
> > -               if (!flag)
> > -                       *low = atoi(val1);
> > -               else
> > -                       *high = atoi(val1);
> > -       } else {
> > -               *low = atoi(val1);
> > -               *high = atoi(val2);
> > -       }
> > -}
> > -
> > -static struct rssi_setting *parse_rssi(char *range, char *timeout)
> > +static struct rssi_setting *parse_rssi(char *params)
> >  {
> >         struct rssi_setting *rssi;
> > -       int high_threshold, low_threshold, high_timer, low_timer;
> > -
> > -       high_threshold = RSSI_DEFAULT_HIGH_THRESHOLD;
> > -       low_threshold = RSSI_DEFAULT_LOW_THRESHOLD;
> > -       high_timer = RSSI_DEFAULT_HIGH_TIMEOUT;
> > -       low_timer = RSSI_DEFAULT_LOW_TIMEOUT;
> > +       char *split, *endptr;
> > +       int i;
> > +       int values[5] = {RSSI_DEFAULT_LOW_THRESHOLD,
> > +                       RSSI_DEFAULT_HIGH_THRESHOLD,
> > +                       RSSI_DEFAULT_LOW_TIMEOUT,
> > +                       RSSI_DEFAULT_HIGH_TIMEOUT,
> > +                       RSSI_DEFAULT_SAMPLING_PERIOD};
> > +
> > +       for (i = 0; i < 5; i++) {
> > +               if (!params) /* Params too short */
> > +                       goto bad_format;
> > +
> > +               split = strsep(&params, ",");
> > +               if (*split != '\0') {
> > +                       values[i] = strtol(split, &endptr, 0);
> > +                       if (*endptr != '\0') /* Conversion failed */
> > +                               goto bad_format;
> > +               } /* Otherwise no parsing needed - use default */
> > +       }
>
> You might want to consider taking these parameters separately in the
> command itself, that way we don't have to reparse the string parameter
> as they would be split in argc/argv by bt_shell.

Done in v4
>
> > -       parse_rssi_value_pair(range, &low_threshold, &high_threshold);
> > -       parse_rssi_value_pair(timeout, &low_timer, &high_timer);
> > +       if (params) /* There are trailing unused params */
> > +               goto bad_format;
> >
> >         rssi = g_malloc0(sizeof(struct rssi_setting));
> > -
> >         if (!rssi) {
> > -               bt_shell_printf("Failed to allocate rssi_setting");
> > +               bt_shell_printf("Failed to allocate rssi_setting\n");
> >                 bt_shell_noninteractive_quit(EXIT_FAILURE);
> >                 return NULL;
> >         }
> >
> > -       rssi->high_threshold = high_threshold;
> > -       rssi->high_timer = high_timer;
> > -       rssi->low_threshold = low_threshold;
> > -       rssi->low_timer = low_timer;
> > +       rssi->low_threshold = values[0];
> > +       rssi->high_threshold = values[1];
> > +       rssi->low_timeout = values[2];
> > +       rssi->high_timeout = values[3];
> > +       rssi->sampling_period = values[4];
> >
> >         return rssi;
> > +
> > +bad_format:
> > +       bt_shell_printf("Failed to parse RSSI\n");
> > +       bt_shell_noninteractive_quit(EXIT_FAILURE);
> > +       return NULL;
> >  }
> >
> >  static struct pattern *parse_pattern(char *parameter_list[])
> > @@ -435,7 +469,7 @@ static struct pattern *parse_pattern(char *parameter_list[])
> >         pat = g_malloc0(sizeof(struct pattern));
> >
> >         if (!pat) {
> > -               bt_shell_printf("Failed to allocate pattern");
> > +               bt_shell_printf("Failed to allocate pattern\n");
> >                 bt_shell_noninteractive_quit(EXIT_FAILURE);
> >                 return NULL;
> >         }
> > @@ -531,12 +565,14 @@ static void print_adv_monitor(struct adv_monitor *adv_monitor)
> >                 bt_shell_printf("\trssi:\n");
> >                 bt_shell_printf("\t\thigh threshold: %hd\n",
> >                                         adv_monitor->rssi->high_threshold);
> > -               bt_shell_printf("\t\thigh threshold timer: %hu\n",
> > -                                       adv_monitor->rssi->high_timer);
> > +               bt_shell_printf("\t\thigh threshold timeout: %hu\n",
> > +                                       adv_monitor->rssi->high_timeout);
> >                 bt_shell_printf("\t\tlow threshold: %hd\n",
> >                                         adv_monitor->rssi->low_threshold);
> > -               bt_shell_printf("\t\tlow threshold timer: %hu\n",
> > -                                       adv_monitor->rssi->low_timer);
> > +               bt_shell_printf("\t\tlow threshold timeout: %hu\n",
> > +                                       adv_monitor->rssi->low_timeout);
> > +               bt_shell_printf("\t\tsampling period: %hu\n",
> > +                                       adv_monitor->rssi->sampling_period);
> >         }
> >
> >         if (adv_monitor->patterns) {
> > @@ -572,15 +608,15 @@ void adv_monitor_add_monitor(DBusConnection *conn, char *type,
> >         while (find_adv_monitor_with_idx(adv_mon_idx))
> >                 adv_mon_idx += 1;
> >
> > -       if (rssi_enabled == FALSE)
> > +       if (rssi_enabled == FALSE) {
> >                 rssi = NULL;
> > -       else {
> > -               rssi = parse_rssi(argv[1], argv[2]);
> > +       } else {
> > +               rssi = parse_rssi(argv[1]);
> >                 if (rssi == NULL)
> >                         return;
> >
> > -               argv += 2;
> > -               argc -= 2;
> > +               argv += 1;
> > +               argc -= 1;
> >         }
> >
> >         patterns = parse_patterns(argv+1, argc-1);
> > diff --git a/client/adv_monitor.h b/client/adv_monitor.h
> > index dd6f615799..2bdc447265 100644
> > --- a/client/adv_monitor.h
> > +++ b/client/adv_monitor.h
> > @@ -12,6 +12,7 @@
> >  #define RSSI_DEFAULT_LOW_THRESHOLD -70
> >  #define RSSI_DEFAULT_HIGH_TIMEOUT 10
> >  #define RSSI_DEFAULT_LOW_TIMEOUT 5
> > +#define RSSI_DEFAULT_SAMPLING_PERIOD 0
> >
> >  void adv_monitor_add_manager(DBusConnection *conn, GDBusProxy *proxy);
> >  void adv_monitor_remove_manager(DBusConnection *conn);
> > diff --git a/client/main.c b/client/main.c
> > index 9403f1af6e..5d84e7cd54 100644
> > --- a/client/main.c
> > +++ b/client/main.c
> > @@ -2709,26 +2709,23 @@ static void cmd_ad_clear(int argc, char *argv[])
> >
> >  static void print_add_or_pattern_with_rssi_usage(void)
> >  {
> > -       bt_shell_printf("rssi-range format:\n"
> > -                       "\t<low-rssi>,<high-rssi>\n"
> > -                       "\tBoth parameters can be skipped, in that case the\n"
> > -                       "\tparamter will be set to its pre-defined value\n");
> > -       bt_shell_printf("\tPre-defined low-rssi,high-rssi: %d,%d\n",
> > -                                               RSSI_DEFAULT_LOW_THRESHOLD,
> > -                                               RSSI_DEFAULT_HIGH_THRESHOLD);
> > -       bt_shell_printf("timeout format:\n"
> > -                       "\t<low-rssi>,<high-rssi>\n"
> > -                       "\tBoth parameters can be skipped, in that case the\n"
> > -                       "\tparamter will be set to its pre-defined value\n");
> > -       bt_shell_printf("\tPre-defined low-timeout,high-timeout: %d,%d\n",
> > -                                               RSSI_DEFAULT_LOW_TIMEOUT,
> > +       bt_shell_printf("rssi format:\n"
> > +                       "\t<low-rssi>,<high-rssi>,<low-rssi-timeout>,"
> > +                                       "<high-rssi-timeout>,<sampling>\n"
> > +                       "\tAll parameters can be skipped, in that case they\n"
> > +                       "\twill be set to pre-defined values, which are:\n");
> > +       bt_shell_printf("\t\tlow-rssi: %d\n", RSSI_DEFAULT_LOW_THRESHOLD);
> > +       bt_shell_printf("\t\thigh-rssi: %d\n", RSSI_DEFAULT_HIGH_THRESHOLD);
> > +       bt_shell_printf("\t\tlow-rssi-timeout: %d\n", RSSI_DEFAULT_LOW_TIMEOUT);
> > +       bt_shell_printf("\t\thigh-rssi-timeout: %d\n",
> >                                                 RSSI_DEFAULT_HIGH_TIMEOUT);
> > +       bt_shell_printf("\t\tsampling: %d\n", RSSI_DEFAULT_SAMPLING_PERIOD);
> >         bt_shell_printf("pattern format:\n"
> >                         "\t<start_position> <ad_data_type> <content_of_pattern>\n");
> >         bt_shell_printf("e.g.\n"
> > -                       "\tadd-or-pattern-rssi -10, ,10 1 2 01ab55\n");
> > +                       "\tadd-or-pattern-rssi -10,,,10,0 1 2 01ab55\n");
> >         bt_shell_printf("or\n"
> > -                       "\tadd-or-pattern-rssi -50,-30 , 1 2 01ab55 3 4 23cd66\n");
> > +                       "\tadd-or-pattern-rssi -50,-30,,, 1 2 01ab55 3 4 23cd66\n");
> >  }
> >
> >  static void print_add_or_pattern_usage(void)
> > @@ -2826,7 +2823,7 @@ static const struct bt_shell_menu advertise_monitor_menu = {
> >         .name = "monitor",
> >         .desc = "Advertisement Monitor Options Submenu",
> >         .entries = {
> > -       { "add-or-pattern-rssi", "<rssi-range=low,high> <timeout=low,high> "
> > +       { "add-or-pattern-rssi", "<rssi=low,high,low-time,high-time,sampling> "
>
> Perhaps we should split the rssi setting in multiple commands as well e.g.:
>
> rssi <low> <high>
> timeout <low> <high>
> interval <value>
> add-or-pattern <pattern1> [...]
>
> So when add-or-pattern is used it takes the rssi values if they have
> been, we would probably need to create the instance at first command
> but we only register when add is called, also don't fill the defaults
> just omit them so the daemon fill them in that way if we at some point
> change the defaults we don't have to change it in multiple places.

Done in v4. Please tell me what you think!
>
> >                                 "[patterns=pattern1 pattern2 ...]",
> >                                 cmd_adv_monitor_add_or_monitor_with_rssi,
> >                                 "Add 'or pattern' type monitor with RSSI "
> > --
> > 2.30.0.284.gd98b1dd5eaa7-goog
> >
>
>
> --
> Luiz Augusto von Dentz

Thanks,
Archie
