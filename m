Return-Path: <SRS0=sa5O=ZF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAD8C432C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Nov 2019 17:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9166B206E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Nov 2019 17:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZoSR9pL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKMRYD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:24:03 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:45280 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfKMRYD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Nov 2019 12:24:03 -0500
Received: by mail-io1-f50.google.com with SMTP id v17so3392602iol.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2019 09:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bVg5vC2NZqIVUgy1ZeLr106OgFJ3JTExWIl7kPUAbSc=;
        b=eZoSR9pL28yNkJq5y+EdmO4i350Q+clPcwygM9XJSoy6SgN1UuroW+0uXK/2zkgY2L
         YX9IoqI5qycasYUaNEOXC37GcwumZg3uY0svEr1IU3ixmOtktoVmTTBBlTDfvfpLM4DO
         iNqiSrmL62LZic+gTZV0LlKQDOTUetOS9mXJ9G5VwED85xcSktmQUmjUhzfY4CRC4HLd
         cb4qI837aRN2C/lfyHkQQ1E8yI2+2J+ZfXJcMLKSW4jBX0w/jCByxDeDrW0gdgtSpO7T
         v0e7wdq/qyxlT0bw998Zx1BxN3/uo8h47iCCaEgTBA1UetiZ3sTYvds5uq1ENEl33GDU
         bHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=bVg5vC2NZqIVUgy1ZeLr106OgFJ3JTExWIl7kPUAbSc=;
        b=gy0212BAGV6vyP8GPQLZJjhl0JxJtdRzVEtP/C3nNZHXBFZHfKnUv5ZPcvSp/jOvur
         M9dKEpqAYULC4UAaUcVvSQDnTT1Mk+QIiM5kEBEC0lDRthjh1H59FeFHAntnaSARjJIy
         6bWuBvSS+3Tw5u9yzjcNjWekHdPK+3nuUFGJ54XHCMBvvOWi2IXDVtPf0Zrt+V6duEdn
         P3iCLzx3J8wsTp7kV/NDRJtaITSolT7esFPs8mBD/79DniLMMdrH6JPEqa0YiXYdsMp+
         Ti26rn85yTIqupzGKMhvqkgBxIgtqYezucWGiQ/9Zhhu6EApMRHAqmwBotUJrS/T7XGA
         ZmYA==
X-Gm-Message-State: APjAAAUisrO3P7sb/vOt5otMFXVd5IbuR/OspDnADfvmm5ZTaDRqZ88l
        gpjqAULwurDmZMRhwRJkUYOE2rPc3g2kdkyZZiDwbHMm
X-Google-Smtp-Source: APXvYqxlQXrniEnHyusIKNEM/OfaxZ5VbWkG1AoZMywMBx3wkZ38O/yWooar5wpcQXSKnYMTrdOT64OuGofniq1rOuE=
X-Received: by 2002:a6b:d81a:: with SMTP id y26mr4554360iob.23.1573665841748;
 Wed, 13 Nov 2019 09:24:01 -0800 (PST)
MIME-Version: 1.0
References: <CAMGddftdorPGAzJbQzwLbaKNjfSrbayzGzKFb7iMBSwNQvsf7g@mail.gmail.com>
 <5852113.xjoqjODIPz@ix>
In-Reply-To: <5852113.xjoqjODIPz@ix>
From:   =?UTF-8?B?S3Jpc3TDs2YgSG9ydsOhdGg=?= 
        <horvath.kristof.attila@gmail.com>
Date:   Wed, 13 Nov 2019 18:23:52 +0100
Message-ID: <CAMGddfvgDWrdVCXb=YgL-nYpyapW+4MAusrqD6=6ZdsbPGW+DQ@mail.gmail.com>
Subject: Re: Simple SDP and RFCOMM example
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

> There is test/test-profile and test/test-hfp in BlueZ source code.

Thank you very much. Without a table of contents, it's hard to find
the appropriate scripts. (This is also true for the files in folder
doc.)

With the test-profile code, I could register a service, and I could
discover it from another device. However, a connection couldn't build
up. The function NewConnection didn't call at all. (By the way, I
didn't find any line of code to receive the data, how is it possible?)

I monitored the connection-attempt with bluetoothctl (every row starts
with the prefix "[chg] Device {address of the other device}"):

ServiceResolved: yes
Paired: yes
(There was a little pause here.)
ServiceResolved: no
Paired: no
Connected: no

Have you got any idea what the problem is? Thank you for your help.

Regards,
Krist=C3=B3f Horv=C3=A1th
