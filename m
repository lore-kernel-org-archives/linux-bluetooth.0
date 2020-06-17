Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7A6C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 15:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F17A20888
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 15:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="rV7T2DOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgFQPBn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgFQPBm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 11:01:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673B2C06174E
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 08:01:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n24so3230531lji.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 08:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6omWERRJGdyMzfylVv8hdNU7qwrXfmeVO8i3n+7b8QM=;
        b=rV7T2DOyjyh10IzNEJRyrt7GpksRAxOd+8x/hXXWo/y/4mUCTylEGgQHa4/P8ExOed
         FjTaLdypJeL1POATOIsrcgUSNvrQoHkSYjXrxyiqc4WFepB+axpSLqidfOCnlUS1Yijo
         hn1ipQiFs1WkoObPZLCDsGmDIOBuFg8Vyz5Dykxp/0rIx0TWsLTwJVQLEZVYZT721oZB
         U/sjoLCSUpoE0r8kDCia6jmZ4Jt2OtuiY+j6v5F2POfEoJT9dyysENzRLnDLK/CU1ogn
         bDixFF7ykME4QncO/ATr2BVeEm+9rrMX7kHJNFnBrb4s/oYpPRJFwlQeRn2GhIT/0DE/
         n7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6omWERRJGdyMzfylVv8hdNU7qwrXfmeVO8i3n+7b8QM=;
        b=HZVAbpKPiHf9C5huQSJK7eQYlUeW8+lohlw3L+xkRn58JPDg7DFEWxYG/CLFjwyNmY
         B16EioxD7VSvWNi2B5fcfwtgIWyXjE/WUhuIU7fjbXpmuSHiHWSkveFTKEJW76KvolSy
         e2DVZnddgw4rQbcapwF/uzDxn9oSCvUKDpFKlp1MhL38YuV085XbYonEjB9aqeQ/hGq3
         /gNM/C3lFs73dpr4QRfJlKW69ktv9i+bL3eIIl5O+lcQqZb3Do0vWJ4Bx3INsFsJlc9U
         XihFfDM8Io/y5VY2Sem+E7VbFFPl2S5Jl5CIvfov3y5Y+dWMw/5fS2/Xux0UyD5PiqSQ
         XXHw==
X-Gm-Message-State: AOAM532aqiQMQ6u9XeD8S3fpxucyW1CH3My9PQGEZTJhGBMV5Qg7yFle
        eYthx0keU0bh+dbf/fiOP10RXJQ8HdtpXy9/Uz6D/A==
X-Google-Smtp-Source: ABdhPJxMQN5UROZ7X2PsZhUnYegBQkPshjKQFA4iNIbu9OpCmIzTs0/B1LO8yTA+lmjmuhWQMm2jjHf/q3tXSqJ1VVM=
X-Received: by 2002:a2e:9dd8:: with SMTP id x24mr4600424ljj.304.1592406100504;
 Wed, 17 Jun 2020 08:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200617075536.98672-1-michaelfsun@google.com> <20200617005531.bluez.v3.3.I55df963e4055bf1778db6f9e46f166b88472e051@changeid>
In-Reply-To: <20200617005531.bluez.v3.3.I55df963e4055bf1778db6f9e46f166b88472e051@changeid>
From:   "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Date:   Wed, 17 Jun 2020 08:01:28 -0700
Message-ID: <CACumGOLjw5N8v=+r_kjWCn6G=2zyzf+RT+bXFdaGfdEmvrhEeA@mail.gmail.com>
Subject: Re: [bluez PATCH v3 3/3] btmgmt: Add command "add" into "monitor"
 btmgmt submenu
To:     Michael Sun <michaelfsun@google.com>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Michael,

On Wed, Jun 17, 2020 at 12:55 AM Michael Sun <michaelfsun@google.com> wrote=
:
>
> This patch introduces a new command =E2=80=98add=E2=80=99 within "monitor=
" submenu to
> allow users to add advertisement monitor filters and get back monitor
> handlers. An event handler is also added to handle kernel issued
> MGMT_EV_ADV_MONITOR_ADDED events. The command will work with the new
> MGMT opcode MGMT_OP_ADD_ADV_MONITOR. This patch only adds support for
> adding pattern based filters.
>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Michael Sun <michaelfsun@google.com>
> ---
>
> Changes in v3:
> - Fix build errors
>
> Changes in v2:
> - Move add command into submenu and fix build warnings
>
>  tools/btmgmt.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 160 insertions(+), 1 deletion(-)
>
> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
> index 5a70e9e1c3e9..ce2a198b1b29 100644
> --- a/tools/btmgmt.c
> +++ b/tools/btmgmt.c
> @@ -1013,6 +1013,19 @@ static void advertising_removed(uint16_t index, ui=
nt16_t len,
>         print("hci%u advertising_removed: instance %u", index, ev->instan=
ce);
>  }
>
> +static void advmon_added(uint16_t index, uint16_t len, const void *param=
,
> +                                                       void *user_data)
> +{
> +       const struct mgmt_ev_adv_monitor_added *ev =3D param;
> +
> +       if (len < sizeof(*ev)) {
> +               error("Too small (%u bytes) %s event", len, __func__);
> +               return;
> +       }
> +
> +       print("hci%u %s: handle %u", index, __func__, ev->monitor_handle)=
;
> +}
> +
>  static void advmon_removed(uint16_t index, uint16_t len, const void *par=
am,
>                                                         void *user_data)
>  {
> @@ -4587,7 +4600,7 @@ static const char * const advmon_features_str[] =3D=
 {
>  static const char *advmon_features2str(uint32_t features)
>  {
>         static char str[512];
> -       int off, i;
> +       unsigned int off, i;
>
>         off =3D 0;
>         snprintf(str, sizeof(str), "\n\tNone");
> @@ -4657,6 +4670,148 @@ static void cmd_advmon_features(int argc, char **=
argv)
>         }
>  }
>
> +static void advmon_add_rsp(uint8_t status, uint16_t len, const void *par=
am,
> +                                                       void *user_data)
> +{
> +       const struct mgmt_rp_add_adv_patterns_monitor *rp =3D param;
> +
> +       if (status !=3D MGMT_STATUS_SUCCESS) {
> +               error("Could not add advertisement monitor with status "
> +                               "0x%02x (%s)", status, mgmt_errstr(status=
));
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       print("Advertisement monitor with handle:0x%04x added",
> +                                                       rp->monitor_handl=
e);
> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +static bool str2pattern(struct mgmt_adv_pattern *pattern, const char *st=
r)
> +{
> +       int type_len, offset_len, offset_end_pos, str_len;
> +       int i, j;
> +       char pattern_str[62] =3D { 0 };
> +       char tmp;
> +
> +       if (sscanf(str, "%2hhx%n:%2hhx%n:%s", &pattern->ad_type, &type_le=
n,
> +                       &pattern->offset, &offset_end_pos, pattern_str) !=
=3D 3)
> +               return false;
> +
> +       offset_len =3D offset_end_pos - type_len - 1;
> +       str_len =3D strlen(pattern_str);
> +       pattern->length =3D str_len / 2 + str_len % 2;
> +
> +       if (type_len > 2 || offset_len > 2 ||
> +                                       pattern->offset + pattern->length=
 > 31)
> +               return false;
> +
> +       for (i =3D 0, j =3D 0; i < str_len; i++, j++) {
> +               if (sscanf(&pattern_str[i++], "%2hhx", &pattern->value[j]=
)
> +                                                                       !=
=3D 1)
> +                       return false;
> +               if (i < str_len && sscanf(&pattern_str[i], "%1hhx", &tmp)=
 !=3D 1)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
> +static void advmon_add_usage(void)
> +{
> +       bt_shell_usage();
> +       print("Options:\n"
> +               "\t-P, --pattern <ad_type:offset:pattern>  "
> +               "Advertising data bytes\n"
> +               "Monitor Types:\n"
> +               "\t-p, --pattern-monitor                        "
> +               "Pattern Monitor\n"
> +               "e.g.:\n"
> +               "\tadd -P 0:1:c504 -P 1:a:9a55beef -p");
> +}
> +
> +static struct option advmon_add_options[] =3D {
> +                                       { "help", 0, 0, 'h' },
> +                                       { "pattern-monitor", 0, 0, 'p' },
> +                                       { "pattern", 1, 0, 'P' },
> +                                       { 0, 0, 0, 0 } };
> +
> +static void cmd_advmon_add(int argc, char **argv)
> +{
> +
> +       uint16_t index;
> +       void *cp =3D NULL;
> +       struct mgmt_adv_pattern *patterns =3D NULL;
> +       int opt, patterns_len;
> +       int pattern_count =3D 0, cp_len =3D 0;
> +       bool success =3D false, type_selected =3D false;
> +
> +       index =3D mgmt_index;
> +       if (index =3D=3D MGMT_INDEX_NONE)
> +               index =3D 0;
> +
> +       while ((opt =3D getopt_long(argc, argv, "P:ph", advmon_add_option=
s,
> +                                                               NULL)) !=
=3D -1) {
> +               switch (opt) {
> +               case 'P':
> +                       patterns_len =3D (pattern_count + 1) *
> +                                       sizeof(struct mgmt_adv_pattern);
> +                       patterns =3D realloc(patterns, patterns_len);
> +
> +                       if (!str2pattern(&patterns[pattern_count++], opta=
rg)) {
> +                               error("Failed to parse monitor patterns."=
);
> +                               goto done;
> +                       }
> +                       break;
> +               case 'p':
> +                       if (!pattern_count) {
> +                               advmon_add_usage();
> +                               goto done;
> +                       }
> +                       cp_len =3D
> +                               sizeof(struct mgmt_cp_add_adv_monitor) +
> +                               patterns_len;
> +                       cp =3D realloc(cp, cp_len);
> +
> +                       ((struct mgmt_cp_add_adv_monitor *)cp)
> +                                       ->pattern_count =3D pattern_count=
;
> +
> +                       memcpy(((struct mgmt_cp_add_adv_monitor *)cp)
> +                                       ->patterns, patterns, patterns_le=
n);
> +                       type_selected =3D true;
> +                       break;
> +               case 'h':
> +                       success =3D true;
> +                       /* fall through */
> +               default:
> +                       advmon_add_usage();
> +                       goto done;
> +               }
> +       }
> +
> +       argc -=3D optind;
> +       argv +=3D optind;
> +
> +       if (argc || !type_selected) {
> +               advmon_add_usage();
> +               goto done;
> +       }
> +
> +       if (!mgmt_send(mgmt, MGMT_OP_ADD_ADV_PATTERNS_MONITOR, index, cp_=
len,
> +                                       cp, advmon_add_rsp, NULL, NULL)) =
{
> +               error("Unable to send \"Add Advertising Monitor\" command=
");
> +               goto done;
> +       }
> +
> +       success =3D true;
> +
> +done:
> +       optind =3D 0;
> +       free(patterns);
> +       free(cp);
> +       if (!success)
> +               bt_shell_noninteractive_quit(EXIT_FAILURE);
> +}
> +
>  static void advmon_remove_rsp(uint8_t status, uint16_t len, const void *=
param,
>                                                         void *user_data)
>  {
> @@ -4747,6 +4902,8 @@ static void register_mgmt_callbacks(struct mgmt *mg=
mt, uint16_t index)
>                                                 advertising_added, NULL, =
NULL);
>         mgmt_register(mgmt, MGMT_EV_ADVERTISING_REMOVED, index,
>                                         advertising_removed, NULL, NULL);
> +       mgmt_register(mgmt, MGMT_EV_ADV_MONITOR_ADDED, index, advmon_adde=
d,
> +                                                               NULL, NUL=
L);
>         mgmt_register(mgmt, MGMT_EV_ADV_MONITOR_REMOVED, index, advmon_re=
moved,
>                                                                 NULL, NUL=
L);
>  }
> @@ -4774,6 +4931,8 @@ static const struct bt_shell_menu monitor_menu =3D =
{
>                                         "features"                      }=
,
>         { "remove",             "<handle>",
>                 cmd_advmon_remove,      "Remove advertisement monitor " }=
,
> +       { "add",                "[options] <-p|-h>",
> +               cmd_advmon_add,         "Add advertisement monitor"     }=
,

Is there any particular reason why you are adding getopt options
instead of just having regular arguments? Also the optional parameters
(those delimited by []), shall come after the mandatory ones
(delimited by <>).

>         { } },
>  };
>
> --
> 2.27.0.290.gba653c62da-goog
>
