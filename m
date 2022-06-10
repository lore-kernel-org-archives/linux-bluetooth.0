Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FE7C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 15:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345672AbiFJPtK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 11:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243695AbiFJPtH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 11:49:07 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00EF22D
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 08:49:05 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id g2so1255214ljk.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=onZpNAbz974fPMY8t0bDj3pDhjNMu8w4nPlAOEaLkDc=;
        b=TKLzWa862XvNAr/j6E5wd/bVQtJ3EV8pK8voI8mgCYhqqNemy5NSSilTtW9abgckAz
         /YSaIQQ5cQJQy+feKdZAvY80oHKVl0nvnyyJbryx6L/CBSdi+GdMK69tRbIppPpsZWoK
         dcwJ9GMLF/kWqkC46wTAF3ArO0UhRcIi8Bn9wEZlpRRUOZ49al8dGoTxyGNO1/1+OSz5
         xtW9bwcyupWcAEOn0kaQCymIIeUDPhbkucTIM6hKDGRHXGxtKmqhsxSPU6iZn9A3Y6vb
         ZDxTQ05S+SdlrYBoWqHB4qgDZBYS25rjR2jmdmzlZanEfd4JibNhol1kogEB0DWNwH/I
         YJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=onZpNAbz974fPMY8t0bDj3pDhjNMu8w4nPlAOEaLkDc=;
        b=APDKD2pBE1IoWrbkd7f6Lyqo3x5owOUBILw4lxlcVbLlJx17ofcJTLZhON457f+Hr+
         RovftedDLaGfGRtBIaX6Mc2scPK3iY7WK8ifD/duI2gjYLhpbFktWU8UTT7fkUwptyuh
         wcrltwk8EcmPkpfTF5PEjEoXmZa7JpTHBL9cmJkXueYo54IqTNscRuPXk/Da1/R3mciR
         kAg0cbTqFby7Y//5hQ8UyJrB1Q4xSggVrSD4f/ymErgbVU62am326iGe8RazvVmpkvr4
         IC6DUW8rDcMxhnFwj8VDsjx9qGEzfeN3x6j5qyuEBG0qbj/CkUED7gyg0DAvEP5qOnm9
         9vAA==
X-Gm-Message-State: AOAM530GSqPl6MRT57QOkVqHEr9Zk++YcwaO350Mo4+Hda/nqLKWnJU7
        Gzyr84UbBXFPilClVbOUwQTr3gz6N3MlHsaBfyyVU8xi
X-Google-Smtp-Source: ABdhPJzWQiW8EPyZi3wP6S6gFRJ9W3TjkyF7N3FfPF5XIcQf7l+ZeDrGnpv8/ExsiGMFToKSgNt5qnc9Ubfvv8l87wQ=
X-Received: by 2002:a2e:a4c2:0:b0:258:e71c:8693 with SMTP id
 p2-20020a2ea4c2000000b00258e71c8693mr2599981ljm.65.1654876143899; Fri, 10 Jun
 2022 08:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220610072850.16593-1-frederic.danis@collabora.com> <20220610072850.16593-3-frederic.danis@collabora.com>
In-Reply-To: <20220610072850.16593-3-frederic.danis@collabora.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 10 Jun 2022 08:48:51 -0700
Message-ID: <CABBYNZLgh+7JfWgX59+=t5_DM45EJyPTTU=8+whxZk8KiJXkug@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 2/3] test-runner: Add audio card support
To:     =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Fr=C3=A9d=C3=A9ric,

On Fri, Jun 10, 2022 at 12:30 AM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> With this commit audio daemons can detect an audio card with output and
> input, allowing to test interaction between BlueZ and the audio daemon.
> ---
>  doc/test-runner.txt |  5 +++++
>  tools/test-runner.c | 23 ++++++++++++++++++++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/doc/test-runner.txt b/doc/test-runner.txt
> index 683c622a2..019c23188 100644
> --- a/doc/test-runner.txt
> +++ b/doc/test-runner.txt
> @@ -54,6 +54,11 @@ For Bluetooth functionality:
>
>         CONFIG_UHID=3Dy
>
> +For Audio functionality:
> +       CONFIG_SYSVIPC=3Dy
> +       CONFIG_SOUND=3Dy
> +       CONFIG_SND=3Dy
> +       CONFIG_SND_INTEL8X0=3Dy

Lets have this as a separate patch.

>  These options should be installed as .config in the kernel source direct=
ory
>  followed by this command.
> diff --git a/tools/test-runner.c b/tools/test-runner.c
> index 9fc8e7b33..bbbca5b5d 100644
> --- a/tools/test-runner.c
> +++ b/tools/test-runner.c
> @@ -54,6 +54,7 @@ static bool start_monitor =3D false;
>  static int num_devs =3D 0;
>  static const char *qemu_binary =3D NULL;
>  static const char *kernel_image =3D NULL;
> +static bool audio_support;
>
>  static const char *qemu_table[] =3D {
>         "qemu-system-x86_64",
> @@ -261,6 +262,7 @@ static void start_qemu(void)
>                                 run_auto, testargs);
>
>         argv =3D alloca(sizeof(qemu_argv) +
> +                               (audio_support ? 4 : 0) +
>                                 (sizeof(char *) * (4 + (num_devs * 4))));
>         memcpy(argv, qemu_argv, sizeof(qemu_argv));
>
> @@ -268,6 +270,20 @@ static void start_qemu(void)
>
>         argv[0] =3D (char *) qemu_binary;
>
> +       if (audio_support) {
> +               char *xdg_runtime_dir, *audiodev;
> +
> +               xdg_runtime_dir =3D getenv("XDG_RUNTIME_DIR");
> +               audiodev =3D alloca(40 + strlen(xdg_runtime_dir));
> +               sprintf(audiodev, "id=3Daudio,driver=3Dpa,server=3D%s/pul=
se/native",
> +                               xdg_runtime_dir);
> +
> +               argv[pos++] =3D "-audiodev";
> +               argv[pos++] =3D audiodev;
> +               argv[pos++] =3D "-device";
> +               argv[pos++] =3D "AC97,audiodev=3Daudio";
> +       }
> +
>         argv[pos++] =3D "-kernel";
>         argv[pos++] =3D (char *) kernel_image;
>         argv[pos++] =3D "-append";
> @@ -990,6 +1006,7 @@ static void usage(void)
>                 "\t-u, --unix [path]      Provide serial device\n"
>                 "\t-q, --qemu <path>      QEMU binary\n"
>                 "\t-k, --kernel <image>   Kernel image (bzImage)\n"
> +               "\t-A, --audio            Add audio support\n"
>                 "\t-h, --help             Show help options\n");
>  }
>
> @@ -1004,6 +1021,7 @@ static const struct option main_options[] =3D {
>         { "monitor", no_argument,       NULL, 'm' },
>         { "qemu",    required_argument, NULL, 'q' },
>         { "kernel",  required_argument, NULL, 'k' },
> +       { "audio",   no_argument,       NULL, 'A' },
>         { "version", no_argument,       NULL, 'v' },
>         { "help",    no_argument,       NULL, 'h' },
>         { }
> @@ -1023,7 +1041,7 @@ int main(int argc, char *argv[])
>         for (;;) {
>                 int opt;
>
> -               opt =3D getopt_long(argc, argv, "aubdslmq:k:vh", main_opt=
ions,
> +               opt =3D getopt_long(argc, argv, "aubdslmq:k:Avh", main_op=
tions,
>                                                                 NULL);
>                 if (opt < 0)
>                         break;
> @@ -1057,6 +1075,9 @@ int main(int argc, char *argv[])
>                 case 'k':
>                         kernel_image =3D optarg;
>                         break;
> +               case 'A':
> +                       audio_support =3D true;
> +                       break;
>                 case 'v':
>                         printf("%s\n", VERSION);
>                         return EXIT_SUCCESS;
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
