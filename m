Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FFFC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 20:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiKVUTQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 15:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiKVUTP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 15:19:15 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDAB27FE4
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 12:19:14 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id d3so19233200ljl.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 12:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ufc10UPOIEg8XLG2Y9etfgvXngVW180g4+laNvxcio4=;
        b=S+dj1XAFz/qaYJkdi4pjyzU5CoISNAR2/jt0DjYrXMPJykX9g/tN6JXPB35bj2d3M6
         hPwQuUxNtPns5qurwU8vEo7vlkmaGNAlXRGOjzSffnflvV3vUT05026RJLtCtPmTJ3wy
         EaRYNaoBq37/vh1P84LWiOZf3EFo9HKrVUOF4nR48nEL3EESfs/Zn+RSSilFRxkAiBlO
         1z522ph0cdAbHSfTxf/jHWE/h1APtAk6cNL6I8g4FFCdfYdX0pD8JXR6bPUTnYKYPCWv
         Jomt0FF9QjIFp3gUfxeG1HOI4OYS47bcPC32J3j8JpNRzUU3Zi6RuqDxp4OUdQJ2NKfm
         k4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ufc10UPOIEg8XLG2Y9etfgvXngVW180g4+laNvxcio4=;
        b=EgLdV3kv5vj5R7N0CwbkAF+V7sSf59AkUSTp4cNARLRw7JWjy/gsNfx3shlSpbstYx
         jozGWgjR/EZD1blCJWXNC0uK5G08Aq/lZIXTuIZpeZzU7Fq4eD1fIaop7iIzej22T0wx
         Y4UNXEgXvwRszOvS9fz0DvY4DKH5DNapg/n7dleO9cS1bLyvtdzXB68P1zvxU7q2/zXf
         IXbBCInYJtznAJRGTcHg1VporFFKR9OLZE8JZeNnWCo+2dItIcZODnrdGEz6gWjhm5TT
         B7o+QPO6oFggj9B8f/P8d+ZE+H50lYGkMWyh0R9AXJiFU4DbMMZE8qaviyEeNwug2uWl
         zLKw==
X-Gm-Message-State: ANoB5pl955UXc4NG5r7/EH0S14Plro+pSDayQpwjG90OeF9Zy4q3aZ0u
        bVrv/qAHlX2rJkO9RwPQuIXiB07ORypmnSZVuav0lxjf
X-Google-Smtp-Source: AA0mqf5NB9yd6BQafH8q6sY5Lk7B4w5hsoeaxFxQQZbLD4tA0xLFMTs3BhM1B9ZLE1Pv2Z8nxtn0JnFcm9UKwXKIHgk=
X-Received: by 2002:a05:651c:c8b:b0:277:f8b:bb4f with SMTP id
 bz11-20020a05651c0c8b00b002770f8bbb4fmr2397735ljb.161.1669148352378; Tue, 22
 Nov 2022 12:19:12 -0800 (PST)
MIME-Version: 1.0
References: <20221122101232.45320-1-sathish.narasimman@intel.com> <20221122101232.45320-8-sathish.narasimman@intel.com>
In-Reply-To: <20221122101232.45320-8-sathish.narasimman@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 22 Nov 2022 12:19:00 -0800
Message-ID: <CABBYNZLXja9-ZkEidsgiEFZxoyA8XJ2Q3=y34WQyMJeJtqa7Jg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 7/7] tools: Add support to generate RSI using SIRK
To:     Sathish Narasimman <sathish.narasimman@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Tue, Nov 22, 2022 at 2:16 AM Sathish Narasimman
<sathish.narasimman@intel.com> wrote:
>
> The patch helps to generate Resolvable set identifier adv data.
> which can be used as ADV data during advertisement.
> It will be used to identify the device as part of setmember for
> Coordinated set identification profile.
> Example:
> $<path to advtest/>advtest -i "761FAE703ED681F0C50B34155B6434FB"
> SIRK: 761FAE703ED681F0C50B34155B6434FB
>   RSI:  0x71 0xcb 0xbc 0x7e 0x01 0x84
>     Random: bccb71
>     Hash:   84017e
> ---
>  tools/advtest.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 78 insertions(+), 2 deletions(-)
>
> diff --git a/tools/advtest.c b/tools/advtest.c
> index de036e783325..9ef69ed5124a 100644
> --- a/tools/advtest.c
> +++ b/tools/advtest.c
> @@ -13,6 +13,13 @@
>  #include <config.h>
>  #endif
>
> +#include <stdlib.h>
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +
>  #include <getopt.h>
>
>  #include "lib/bluetooth.h"
> @@ -32,6 +39,9 @@
>                         "\xe1\x23\x99\xc1\xca\x9a\xc3\x31"
>  #define SCAN_IRK       "\xfa\x73\x09\x11\x3f\x03\x37\x0f" \
>                         "\xf4\xf9\x93\x1e\xf9\xa3\x63\xa6"
> +#ifndef MIN
> +#define MIN(x, y) ((x) < (y) ? (x) : (y))
> +#endif
>
>  static struct mgmt *mgmt;
>  static uint16_t index1 = MGMT_INDEX_NONE;
> @@ -43,13 +53,73 @@ static struct bt_hci *scan_dev;
>
>  static void print_rpa(const uint8_t addr[6])
>  {
> -       printf("  Address:  %02x:%02x:%02x:%02x:%02x:%02x\n",
> +       printf("  RSI:\t0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
>                                         addr[5], addr[4], addr[3],
>                                         addr[2], addr[1], addr[0]);
>         printf("    Random: %02x%02x%02x\n", addr[3], addr[4], addr[5]);
>         printf("    Hash:   %02x%02x%02x\n", addr[0], addr[1], addr[2]);
>  }
>
> +static size_t hex2bin(const char *hexstr, uint8_t *buf, size_t buflen)
> +{
> +       size_t i, len;
> +
> +       len = MIN((strlen(hexstr) / 2), buflen);
> +       memset(buf, 0, len);
> +
> +       for (i = 0; i < len; i++)
> +               if (sscanf(hexstr + (i * 2), "%02hhX", &buf[i]) != 1)
> +                       continue;
> +
> +
> +       return len;
> +}
> +
> +static bool get_random_bytes(void *buf, size_t num_bytes)
> +{
> +       ssize_t len;
> +       int fd;
> +
> +       fd = open("/dev/urandom", O_RDONLY);
> +       if (fd < 0)
> +               return false;
> +
> +       len = read(fd, buf, num_bytes);
> +
> +       close(fd);
> +
> +       if (len < 0)
> +               return false;
> +
> +       return true;
> +}
> +
> +static void generate_rsi(char *val)
> +{
> +       uint8_t sirk[16], hash[3];
> +       uint8_t  rsi[6] = {0};
> +
> +       hex2bin(val, sirk, sizeof(sirk));
> +
> +       get_random_bytes(&rsi[3], 3);
> +
> +       rsi[5] &= 0x3f; /* Clear 2 msb */
> +       rsi[5] |= 0x40; /* Set 2nd msb */
> +
> +       crypto = bt_crypto_new();
> +       if (!crypto) {
> +               fprintf(stderr, "Failed to open crypto interface\n");
> +               mainloop_exit_failure();
> +               return;
> +       }
> +
> +       bt_crypto_ah(crypto, sirk, rsi + 3, hash);
> +       memcpy(rsi, hash, 3);
> +
> +       print_rpa(rsi);
> +}
> +
> +
>  static void scan_le_adv_report(const void *data, uint8_t size,
>                                                         void *user_data)
>  {
> @@ -351,9 +421,11 @@ static void usage(void)
>         printf("\tadvtest [options]\n");
>         printf("options:\n"
>                 "\t-h, --help             Show help options\n");
> +       printf(" \t-i  <128bit SIRK>,     Generate RSI ADV Data\n");
>  }
>
>  static const struct option main_options[] = {
> +       { "hash",   no_argument,       NULL, 'i' },
>         { "version",   no_argument,       NULL, 'v' },
>         { "help",      no_argument,       NULL, 'h' },
>         { }
> @@ -366,11 +438,15 @@ int main(int argc ,char *argv[])
>         for (;;) {
>                 int opt;
>
> -               opt = getopt_long(argc, argv, "vh", main_options, NULL);
> +               opt = getopt_long(argc, argv, "i:vh", main_options, NULL);
>                 if (opt < 0)
>                         break;
>
>                 switch (opt) {
> +               case 'i':
> +                       printf("SIRK: %s\n", optarg);
> +                       generate_rsi(optarg);
> +                       return EXIT_SUCCESS;
>                 case 'v':
>                         printf("%s\n", VERSION);
>                         return EXIT_SUCCESS;
> --
> 2.25.1

I think it would be better if bluetoothd generates the RSI if a
Set.Key has been programmed into the main.conf, that can then check if
there is enough space to enter the RSI in either the ad or scan
response, in the future we may consider having the Sirk be passed on
to the kernel so we can leave it to generate the RSI.

-- 
Luiz Augusto von Dentz
