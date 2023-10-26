Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561E8C25B48
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Oct 2023 16:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjJZQYc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Oct 2023 12:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJZQYc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Oct 2023 12:24:32 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20206183
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Oct 2023 09:24:30 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D1FE53FB5A
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Oct 2023 16:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698337468;
        bh=pT3EMKt5ioi+OgaDwva0dXSIRL7TtCf5ZHkNSxBDmGs=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=jHb/o/NPlHKVD7d+X6nS1akEs5MkcgfILFuk6wP9VamSIpWnL2OBHk6WQS8HpNlWP
         kLM6aSPVeteHCU5WZylEH8qWOtjoEuC7doBe3hTrssvihF9r11J99+cfnZC2MHKogk
         eXXlsmjJmGAyaX2wLnmclOm9JejJ1lA08VEoY26fbS8X9ICEZ0l5muWUkWC/YXYKOJ
         2ZagcyIdH/JifJ1ZrXtfMpn8vtVIKALHGJwa75Qh+Wp69T4GrljgwlbTqJW9idKEDV
         ZQPKO5YRUAr5ZvyZD4LUw62dKFJPzAEuaWtnWxLXDc7nKSlhNZ5tjK/sTabq4WjtO1
         tz6cfE4dQgH6w==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32f68d3b788so241196f8f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Oct 2023 09:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698337468; x=1698942268;
        h=mime-version:organization:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pT3EMKt5ioi+OgaDwva0dXSIRL7TtCf5ZHkNSxBDmGs=;
        b=jGa5YQmSHuL28rYgYOxhpMz2Iv6HH5SYVkPT1OeMCzR0z2dJ/m/CcRb+NDI3ongoPO
         ar71OTovIYmlIdoO/CYPPrl4f6AhMHSuGMUNDL8KCK1Omg+mJqe4kBuOKhVw/gzGjbST
         6iASQWNF2onXP4Bq5tXz3EvusBdeFSzTXiku7KGZVfWiizurOsjbQUqmT+uy0ZnkQq7g
         c5B/ilNAtW8GmSMGy2hTv2vDf/Bg2fW+6EbD/ZJ6FyVcwTuv1Z/jmwn7R2pgaGDVZRJH
         SWX0cMxK6Yxt2NefBeJSt3abWpx+/SIulaIkFYqRQoj+xJtpgA/X8AzL7iOhNg25kVOK
         fUNA==
X-Gm-Message-State: AOJu0YwXjRWMLPztUal4G8qVrJirKetpSSHRghYzIT7XYPosRVpJNe9x
        CaAr/B4t81ljHI0oPg8vrrXhxqgr8efxn6uGmasGQfAJmWipn9KaatJ4AxSefLPAmf54LcknP83
        WBg7f54mzpUGy/xffiNDRRsJmUY33iY2P2rnN20jC/m58zZ2UhmKRjw==
X-Received: by 2002:adf:ed83:0:b0:32d:a688:8814 with SMTP id c3-20020adfed83000000b0032da6888814mr121270wro.19.1698337468511;
        Thu, 26 Oct 2023 09:24:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw6u6iwE+WUNsR/D8FMKVDtEbyNtAzd0JYV9uopJ/R6RAwiaK3AqAvc3mqpweOSXthcFrDXQ==
X-Received: by 2002:adf:ed83:0:b0:32d:a688:8814 with SMTP id c3-20020adfed83000000b0032da6888814mr121252wro.19.1698337468168;
        Thu, 26 Oct 2023 09:24:28 -0700 (PDT)
Received: from gollum ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id p17-20020a5d68d1000000b0032d687fd9d0sm14544177wrw.19.2023.10.26.09.24.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:24:27 -0700 (PDT)
Date:   Thu, 26 Oct 2023 18:24:26 +0200
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     linux-bluetooth@vger.kernel.org
Subject: bluez: btmgmt --index broken
Message-ID: <20231026182426.032a776d@gollum>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8n_V7_y2uqdC0n1YRNs_fhT";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--Sig_/8n_V7_y2uqdC0n1YRNs_fhT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

Commit 648b4362521b ("shared/shell: Add support for -i/--init-script")
introduced a short option namespace collision with btmgmt's --index option,
both of which use '-i'.

As a result, a provided --index is treated as an init-script...

$ sudo btmgmt --index 0 info
Unable to open 0: No such file or directory (2)


On a separate note, should btmgmt actually support --init-script since it
doesn't seem to do anything and just enters interactive mode?

$ cat test
help
info
quit

$ btmgmt --init-script test
[mgmt]#


Simple fix for the first issue, use -s/--init-script instead:

diff --git a/src/shared/shell.c b/src/shared/shell.c
index db79c882c..fbccff5b5 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1128,7 +1128,7 @@ static void rl_init(void)
 static const struct option main_options[] =3D {
        { "version",    no_argument, 0, 'v' },
        { "help",       no_argument, 0, 'h' },
-       { "init-script", required_argument, 0, 'i' },
+       { "init-script", required_argument, 0, 's' },
        { "timeout",    required_argument, 0, 't' },
        { "monitor",    no_argument, 0, 'm' },
        { "zsh-complete",       no_argument, 0, 'z' },
@@ -1169,9 +1169,9 @@ void bt_shell_init(int argc, char **argv, const struc=
t bt_shell_opt *opt)
        if (opt) {
                memcpy(options + offset, opt->options,
                                sizeof(struct option) * opt->optno);
-               snprintf(optstr, sizeof(optstr), "+mhvi:t:%s", opt->optstr);
+               snprintf(optstr, sizeof(optstr), "+mhvs:t:%s", opt->optstr);
        } else
-               snprintf(optstr, sizeof(optstr), "+mhvi:t:");
+               snprintf(optstr, sizeof(optstr), "+mhvs:t:");
=20
        data.name =3D strrchr(argv[0], '/');
        if (!data.name)
@@ -1193,7 +1193,7 @@ void bt_shell_init(int argc, char **argv, const struc=
t bt_shell_opt *opt)
                        data.argv =3D &cmplt;
                        data.mode =3D 1;
                        goto done;
-               case 'i':
+               case 's':
                        if (optarg)
                                data.init_fd =3D open(optarg, O_RDONLY);
                        if (data.init_fd < 0)

--Sig_/8n_V7_y2uqdC0n1YRNs_fhT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmU6kroACgkQD9OLCQum
Qrf4AQ/9HUSjhxA+MQhpVbraq5m/P36d2jALkWXorPq7ByFc7UYlfvLhndkQHR4+
0C7zcZEL8ElsrpKHgL+AAHqUm5QwFCimHhiE/PLYygI4yYhuOI62rPORRYp43ONu
hZNaYZj4vtOcFCvqWV7ePKW54xJPLxfrBf7rHtHzYAXCqpUjhF76t4wqPk8LWb1X
dzBKJz/BdZ1ETHQKc3CWqsEQbFUROI474lrtLzGdRWFeYrGC70OgC3SgGavCkcoC
SHpMThl+v+gt1PekKvYPTZw532zTltdJEpocNIa4G1l5Misth9c737yZPax3b03N
hcLGLAEy0mMxpCWGPROWo9SjwK6qKmRkx4MhhT6i8AGg/MD2yGEzBoFsvtVAIsIW
Ls1BoFc04guj2Y7QaZncpxUYO+NU0Xuco0/DCOwjFa6i3JvXvBYJDLCOWNUzGUCG
pV6M2n7Plo4gWix4JHgGr27wIjrLtkRVGGNkzjl81hz6JEMSShAn1nvhZmTOPMVs
QttfMP2iNvgojjOVhKHpzUOiyJqwI7esRfib/Lchu/zEBlS0WSnLiAzWQzXM/n2X
WuTR1xEqMmha8H7P0ZL2f6JYnK5yq/ffvz9XFFKTPjAJy62XJXF+ccC+l5/K9xjs
hGgt4KojFCIAG1UHvxFEP7o5Dx2eE0jG7b3IMLcTCGPFkrkY/wA=
=zrDR
-----END PGP SIGNATURE-----

--Sig_/8n_V7_y2uqdC0n1YRNs_fhT--
