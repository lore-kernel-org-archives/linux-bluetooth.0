Return-Path: <SRS0=1nTO=O7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19766C43387
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Dec 2018 22:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D930621934
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Dec 2018 22:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI1QJE+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbeLVWzD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Dec 2018 17:55:03 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45340 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731406AbeLVWzD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Dec 2018 17:55:03 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so8303736ota.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Dec 2018 14:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z+NkndoPC0EDPG8USEXgKTUX4+otQxkzr4FogtpmhZ8=;
        b=bI1QJE+w1zP8VXIgKQub0zM6xAQUwGFYdOCwHmhHAf8zRaONUdwVY9cikkfztxqpKa
         XGhQ9dNsR2fcjQnhJ4s8nubMSXAIJuMtH9mGITCi+c9DDH7LIoC7jFhYNIZasj346X4S
         SPo4szZ63g2/mZiiQ4HtKPjk1MJpvEhtzTg7YWZNccJ+eG+FkqgcI4R5r7l3+XebWfg9
         ZApb2AtyiPbNBx9mG9Zbsl0Dhcqq9ou97FTeCQyxE4XaO8FoyH6ruOJZnWHcKdEMoNUf
         TgbHPoWUmXYfgVmMFR296IVXINc3ZH7uc2jeorMN0u2N4OlxRlEGBTSq7GgxKaaHYxPs
         npYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z+NkndoPC0EDPG8USEXgKTUX4+otQxkzr4FogtpmhZ8=;
        b=fRGFijX82r3irjKz+21jhJ1tvrobPvTaXvRMPADRGmAqgPMg2h2EQSHnOWX7ewnn0u
         0zLx9AQdlo6xPpUOihmyCgkOg9FGYqIDUEMonNT/gdhpBSyWMpDQT1P1RXZAo97VznVs
         6tdUOLpudBQbI3T3P9Y9d1QzGkZKskZt3lwhPK3zGKGx+40CIil4Ml+kg2oHIy7IE/4e
         Uh7e3uGTBjOCNBbpDsBjJZuHqYQXvmomwxHUpTxpK3Cw9VlFizHDFdCcPZQTZ/h8Y9m2
         Og9fmFvUbkjQ3lS7JyiW6ZDL4h5Lqf3FMGIE849TBOo+evggRQkHckO/lgztUKw4wKFH
         vu0g==
X-Gm-Message-State: AJcUukdL35x8VdgkLf+06dXDRWKXI/Wx4fC32rnNyo1VW2sraUr9NEsf
        Jf2blnqE/MK23chO2wUn92u0Lynh+ZQ1l1pUv2w=
X-Google-Smtp-Source: ALg8bN5wHxeTn2eEvZxiPHaqhgCwCnBMXW11LqUfZB1+Rr55uxcY1lmerkDaflz76wlmiIhfuilURpgfuwGTJ17Gnf0=
X-Received: by 2002:a9d:322d:: with SMTP id t45mr5718982otc.71.1545519300979;
 Sat, 22 Dec 2018 14:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20181219165109.29088-1-pali.rohar@gmail.com>
In-Reply-To: <20181219165109.29088-1-pali.rohar@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 22 Dec 2018 19:54:48 -0300
Message-ID: <CABBYNZ+ryN3zywdsFQTguJWZ8jSYSOTT7OghxGVZ6wpoYh_QTQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] A2DP: Fix endianity and define new A2DP codecs
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Wed, Dec 19, 2018 at 5:17 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> This patch series try to fix endianity problems in a2dp-codecs.h file,
> then fixes parsing MPEG bit rate values, extend a2dp-codecs.h file for
> new A2DP codecs FastStream, aptX Low Latency, aptX HD and finally adds
> support for parsing information about FastStream, aptX Low Latency,
> aptX HD and LDAC codecs in avinfo utility.
>
> Pali Roh=C3=A1r (10):
>   avinfo: Fix buffer overflow when parsing broken/malicious data
>   avinfo: Show Vendor Specific Data
>   a2dp-codecs: Add SBC prefix for MIN/MAX_BITPOOL constants
>   a2dp-codecs: Fix codec id for ATRAC
>   a2dp-codecs & avinfo: Fix parsing MPEG bit rate values
>   a2dp-codecs: Define a2dp_vendor_codec_t struct in endian neutral way
>   a2dp-codecs: Add needed includes and properly check for endian macros
>   a2dp-codecs: Properly define macros and struct for LDAC codec
>   a2dp-codecs: Add macros and structures for FastStream, aptX Low
>     Latency and aptX HD codecs
>   avinfo: Parse information about A2DP codecs: FastStream, aptX Low
>     Latency, aptX HD and LDAC
>
>  android/a2dp.c               |   8 +-
>  android/avdtp.c              |   4 +-
>  android/hal-audio-aptx.c     |  15 +-
>  android/hal-audio-sbc.c      |  12 +-
>  profiles/audio/a2dp-codecs.h | 256 ++++++++++++++++++++++++++----
>  profiles/audio/a2dp.c        |   8 +-
>  tools/avinfo.c               | 362 ++++++++++++++++++++++++++++++++++++-=
------
>  7 files changed, 551 insertions(+), 114 deletions(-)
>
> --
> 2.11.0

gitlint: checking commit message...
3: B6 Body message is missing
-----------------------------------------------
gitlint: \033[31mYour commit message contains the above violations.\033[0m

Please add description to the commit messages. Also there seems to be
several problems with codying style like the following:

Applying: avinfo: Fix buffer overflow when parsing broken/malicious data
WARNING:UNSPECIFIED_INT: Prefer 'unsigned int' to bare use of 'unsigned'
#77: FILE: tools/avinfo.c:241:
+    unsigned freq, bitrate;

WARNING:LONG_LINE: line over 80 characters
#124: FILE: tools/avinfo.c:433:
+static void print_media_codec(struct avdtp_media_codec_capability
*cap, uint8_t size)

WARNING:LONG_LINE: line over 80 characters
#182: FILE: tools/avinfo.c:510:
+            print_content_protection((void *) cap->data, cap->length);

total: 0 errors, 3 warnings, 173 lines checked




--=20
Luiz Augusto von Dentz
