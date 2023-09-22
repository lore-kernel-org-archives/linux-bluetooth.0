Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79363CD484A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Sep 2023 17:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjIVRrL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Sep 2023 13:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIVRrK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Sep 2023 13:47:10 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A2299
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Sep 2023 10:47:00 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c022ce8114so42007311fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Sep 2023 10:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695404818; x=1696009618; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxaTriwWVRjK3jQxV2aiD1R9PoEOapIKPQgR46w/QrM=;
        b=e9fyVP+S8rA+Ev0G+6lQC5S5KfFgrcCCd8Ld4/b5PCZ3wopVW/ZjQRg/0BDa6sY3gL
         K6+SUCHsbeiyXOqBIHsAS4y0luEWjP0JdH30Qj3alQ+GRoZYK6BcmlPmFRP5t7BSO1Rl
         eqpfF9bN/MbYFCT2uwg0lkst8LsTZXm3xWNUWwliSjk0J94MdujBDhglJLGPQB2lNBfl
         UQUPHlgg4v9bB0JKSQt1f7xgbAqTa6GCsx+ppIw1yZpIqw9GRFQIbwL0P+ARiY3I02UN
         6gWSE+gkB9/qJ04yw4R6ZETevqn+InwJQ0bdVQUfKw+TJKvWSxMhgRMJYbwdE9G8NcSO
         1zfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695404818; x=1696009618;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxaTriwWVRjK3jQxV2aiD1R9PoEOapIKPQgR46w/QrM=;
        b=WSTFy0dIViD+ItOHB/wn6GKoKJdTbu+jZMju1x8mbll+mWUSA0r1qCwqXphiqgqBfR
         sx0dgqQlVdrJJ23oTsg0tQVNDJvT/TU3vcK7QgVKdvAYiNrnCRw9cHIn6y0p0M3cGU8e
         MkajXwu7kWr15MpI+Y8wUadGNtH4DS3t4h9cKw6P+V/+sikHLPgAuX9CrbXKs2Yyc632
         eeP1MliZHUvwNeDd0kWcYZrFVM3VYmKIyxNyPQE8MPnjE4UQwjWIelqy3GOUVDQDOWvr
         G1QbDjZaril4anyWxzywuM6F82HqI51XN89U2mNmubDH6VdNFTSwY0rIZLl6M52gGjLY
         Wvfg==
X-Gm-Message-State: AOJu0YxRq6EvjTaWDm4RDI0gnBrokMdyjqdONI0n6h9w2R/y+vR0bToh
        Hj7zeXD5FplxX0NDlvfeX15mnsgvwngo5BJz8LoUAtnc
X-Google-Smtp-Source: AGHT+IFAzKi9Lapm+j/oOnncxPDXBm2BTJYN8XQ2J+tfF2fI860jXHzSz4l5rfNp+tMobzlChY5VdwMuCn3JbOwKa0Y=
X-Received: by 2002:a2e:8193:0:b0:2c0:2e25:5730 with SMTP id
 e19-20020a2e8193000000b002c02e255730mr8384527ljg.5.1695404817703; Fri, 22 Sep
 2023 10:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230921234738.929423-1-luiz.dentz@gmail.com> <650d08ad.170a0220.dc361.dbe0@mx.google.com>
In-Reply-To: <650d08ad.170a0220.dc361.dbe0@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 22 Sep 2023 10:46:45 -0700
Message-ID: <CABBYNZ+2e-b565H5=BtkeSaviUf+8MgXrYOP0LRoxo8pYov-XA@mail.gmail.com>
Subject: Re: [BlueZ,1/5] media-api: Update to reflect the last code changes
To:     linux-bluetooth@vger.kernel.org,
        Vlad Pruteanu <vlad.pruteanu@nxp.com>,
        Claudia Draghicescu <claudia.rosu@nxp.com>,
        iulia-tanasescu <iulia.tanasescu@nxp.com>,
        Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>,
        Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Sep 21, 2023 at 8:23=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D786=
455

Have a look if I capture everything correctly, Ive made sure the
bluetoothctl works with QoS being a single property but we still have
to do the changes at upper layers.

@Pauli Virtanen You can use bluetoothctl as an example how to encode
the QoS property, note that there are multiple containers involved
because the QoS dict becomes the variant portion of the outer
dictionary but you will notice if the daemon is not able to parse it.
I could consider supporting the old format though if you think we
should maintain backwards compatibility.

> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      2.52 seconds
> GitLint                       FAIL      1.58 seconds
> BuildEll                      PASS      34.31 seconds
> BluezMake                     PASS      1192.51 seconds
> MakeCheck                     PASS      13.44 seconds
> MakeDistcheck                 PASS      195.33 seconds
> CheckValgrind                 PASS      314.03 seconds
> CheckSmatch                   PASS      437.84 seconds
> bluezmakeextell               PASS      131.38 seconds
> IncrementalBuild              PASS      5145.48 seconds
> ScanBuild                     PASS      1374.82 seconds
>
> Details
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint
> Output:
> [BlueZ,3/5] client: Make transport.show to print QoS property
>
> WARNING: I3 - ignore-body-lines: gitlint will be switching from using Pyt=
hon regex 'match' (match beginning) to 'search' (match anywhere) semantics.=
 Please review your ignore-body-lines.regex option accordingly. To remove t=
his warning, set general.regex-style-search=3DTrue. More details: https://j=
orisroovers.github.io/gitlint/configuration/#regex-style-search
> 10: B3 Line contains hard tab characters (\t): "        UUID: 00002bcb-00=
00-1000-8000-00805f9b34fb"
> 11: B3 Line contains hard tab characters (\t): "        Codec: 0x06 (6)"
> 12: B3 Line contains hard tab characters (\t): "        Configuration:"
> 14: B3 Line contains hard tab characters (\t): "        Device: /org/blue=
z/hci0/dev_00_AA_01_01_00_03"
> 15: B3 Line contains hard tab characters (\t): "        State: idle"
> 16: B3 Line contains hard tab characters (\t): "        Endpoint: /org/bl=
uez/hci0/dev_00_AA_01_01_00_03/pac_sink0"
> 17: B3 Line contains hard tab characters (\t): "        QoS Key: CIG"
> 18: B3 Line contains hard tab characters (\t): "        QoS Value: 0x00 (=
0)"
> 19: B3 Line contains hard tab characters (\t): "        QoS Key: CIS"
> 20: B3 Line contains hard tab characters (\t): "        QoS Value: 0x00 (=
0)"
> 21: B3 Line contains hard tab characters (\t): "        QoS Key: Framing"
> 22: B3 Line contains hard tab characters (\t): "        QoS Value: 0x00 (=
0)"
> 23: B3 Line contains hard tab characters (\t): "        QoS Key: Presenta=
tionDelay"
> 24: B3 Line contains hard tab characters (\t): "        QoS Value: 0x0000=
9c40 (40000)"
> 25: B3 Line contains hard tab characters (\t): "        QoS Key: Interval=
"
> 26: B3 Line contains hard tab characters (\t): "        QoS Value: 0x0000=
2710 (10000)"
> 27: B3 Line contains hard tab characters (\t): "        QoS Key: Latency"
> 28: B3 Line contains hard tab characters (\t): "        QoS Value: 0x000a=
 (10)"
> 29: B3 Line contains hard tab characters (\t): "        QoS Key: SDU"
> 30: B3 Line contains hard tab characters (\t): "        QoS Value: 0x0028=
 (40)"
> 31: B3 Line contains hard tab characters (\t): "        QoS Key: PHY"
> 32: B3 Line contains hard tab characters (\t): "        QoS Value: 0x02 (=
2)"
> 33: B3 Line contains hard tab characters (\t): "        QoS Key: Retransm=
issions"
> 34: B3 Line contains hard tab characters (\t): "        QoS Value: 0x02 (=
2)"
> 35: B3 Line contains hard tab characters (\t): "        Location: 0x00000=
003 (3)"
> 36: B3 Line contains hard tab characters (\t): "        Links: /org/bluez=
/hci0/dev_00_AA_01_01_00_03/pac_source0/fd0"
>
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
