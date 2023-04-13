Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CB5C77B61
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Apr 2023 13:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjDMNz1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Apr 2023 09:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjDMNz0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Apr 2023 09:55:26 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A4A19A1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 06:55:24 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id g26-20020a4adc9a000000b0053b9059edd5so2237896oou.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681394123; x=1683986123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFuIG0J+LneGq+4r0DiD7CEEt5f+B8fcONqdd9iEtqA=;
        b=kY4FpfQwu2hqLLp9+YR4TGXWgYC0jn6v2x58o34K7W7T85eMTnTKmkU/Lt3l1FrOmn
         0xdaqIhIXfuP5sk1s6o3ZxTLNwYCfdOWN0uiAsXPcsq0zMoqDXqMJthrPNVghGPYLj5u
         FyAs8tN/OUX6+c3s9EQc5lrlyF2vZiSCSimvvXg5cQtJf/HrGc4ngfIl/sU0FW0yDBbW
         wNyQty8AlgrgfLez57tnxwy364TW1bYIyCwgejLqSN5nDK57BYUyxB/+9QIYFlYTH+GN
         bZyuEMwgjw/IIQO3UFvdXPFfmYQcgfpTBWyA20eWedDJOuxXkY80/8i7csAAq3q8bmNQ
         FHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681394123; x=1683986123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFuIG0J+LneGq+4r0DiD7CEEt5f+B8fcONqdd9iEtqA=;
        b=ZN6+pOBPwRem9TedBCu0G6a4lD3r/UDsVS8K3SiM1sIv6mnOX3HsLW12Fl8A9HkU1N
         sGKfyV8oD0fsId3SP3Bcpgq1P4QtH3ItxBTJFayRmW+dEAASg5mtyQOUqlVNZj8kbYnM
         AF2jmbbE2/e3sEhEdW0qjMk8vCoCpGnMdMur5/S5rz+RR1WaINyUPDQ0lsc7M34DV/4+
         X6LjgDLliIQvgSZ6R/e7ldi5k8zRCWpJ/2jM3i8x3Ch6lSlwR6XsR/LGO5TKbkglfqYY
         pt5WBP4FUGkB44419uTE8QlagPpMYFku2XSeCoS9v9f1DLIVQj2KwEUBSGzhJsopgH9G
         82kg==
X-Gm-Message-State: AAQBX9fAndaMxcK4ISysZBSN+5jw5od8sU1gTCWhxU+Fx5QQfFxVrBfT
        GAvwdrNn2D9qnFHUDo7UdHXgVo82nJQrDwwoz/w=
X-Google-Smtp-Source: AKy350Z0MGFbnLhpTAe0hSGPkjqKbS3HY+/+XaZAcLWhR2GXgR2a4DWxRVHvKBRe/eqUVPgRIbhRS6A+hYljuPgInhY=
X-Received: by 2002:a4a:e691:0:b0:541:b832:6ce0 with SMTP id
 u17-20020a4ae691000000b00541b8326ce0mr624778oot.0.1681394123348; Thu, 13 Apr
 2023 06:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <CACk7upyDgd8kCY+8j+RMJz35GXrF=bwRzDNH76Oh8q4nB8i0KQ@mail.gmail.com>
 <126c5bce-6496-4744-9101-6a61f0fff106@app.fastmail.com>
In-Reply-To: <126c5bce-6496-4744-9101-6a61f0fff106@app.fastmail.com>
From:   Raul Cheleguini <raul.cheleguini@gmail.com>
Date:   Thu, 13 Apr 2023 10:54:47 -0300
Message-ID: <CACk7upyYLmiS9GMJVatjDz52Z4MEPRVAoHi_tSchHWjQfqo2sA@mail.gmail.com>
Subject: Re: unexpected SMP command errors with controller ATS2851
To:     Christopher Snowhill <chris@kode54.net>
Cc:     linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Mar 31, 2023 at 2:50=E2=80=AFAM Christopher Snowhill <chris@kode54.=
net> wrote:
>
> Would some pcapng logs be useful? It appears this device flags some comma=
nds as supported, while indicating their entire feature sets are not suppor=
ted in the local supported features bitfields. Or that's as near as I can g=
uess.
>
> First is captured from a generic driver that works, the latter is capture=
d from Linux 6.2.9. Included in the working capture is the beginning of an =
exchange with my Sony headphones. The latter stops logging after the first =
failed command.
>
> https://f.losno.co/bluetooth_ats2851.pcapng.zst
> https://f.losno.co/bluetooth_ats2851_broken.pcapng.zst

Hi Christopher,

Thank you for sharing the pcap files. Based on your comments from another
thread regarding this adapter, I suggest that you apply the following patch=
es:

[PATCH] Bluetooth: Improve support for Actions Semi ATS2851 based devices
https://marc.info/?l=3Dlinux-bluetooth&m=3D167846197021176&w=3D2

[PATCH] Bluetooth: Add new quirk for broken set random RPA timeout for ATS.=
..
https://marc.info/?l=3Dlinux-bluetooth&m=3D167957918920723&w=3D2

[PATCH] Bluetooth: Add new quirk for broken extended create connection for.=
..
https://marc.info/?l=3Dlinux-bluetooth&m=3D167957998621276&w=3D2

You would end up in the situation mentioned in this thread, and you could
resume your tests from there. I haven't had the time to experiment with SMP=
 yet,
so any assistance would be greatly appreciated.
