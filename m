Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C82C433E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A270520656
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvvcnj6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgHUREp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgHUREk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 13:04:40 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333EDC061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:04:40 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id a65so2100783otc.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zmXkuSmjIU/TZiJV8eCBj0UoFt7Tb7XFXvE7rizzqWY=;
        b=pvvcnj6Cm2cmkWY/dVUNjTcKU59HJ6hn+5dIq+LMoGCvq2AOcLPS/rlprvWLJL9G63
         NaIyPxyyJrx/O3uZVT48J39yzvthB835+Iake0HZWwqPl2LKiMhS/hIQfYWCy2ckvyle
         Ylf/SXLRt2ZfaogXQM/8ppFLrurmY74CHHGFD2wwE60z5SqIVxCcnJEeKaam6XLQusoB
         Ika3yxbBC5BT/TxolaOOk23b36czt401C7Vxea6CuJ4pHkrFDeprze4N1+BVzj8rFo9i
         LjsvC9IpCPNcJGToUICLJU4wiugIxgbl2xLVgMjwlhVI2jUrgFACaaQ0it8DilJrEsXw
         +J2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zmXkuSmjIU/TZiJV8eCBj0UoFt7Tb7XFXvE7rizzqWY=;
        b=RvN9/ESx/BUoHEiSppOqgYgrFj8MgRzoAERWnejc4AXde0FPhbhVUHNRIwDC/i9aM4
         5MAK8h2Zzv9SQLzO0+1TlJiUNXEdjPRtpeT/ghzlP1+QQkGnwnrvc1glqC6O+ngmARco
         8idLo2+k80mP2wC/AgjAkhWyA1P/T6fd3zuZXhVX8qsXETc0Y5DdPl5tU1srysskICIF
         /zLMbzu2THKzfbk8rNXMGiXJMtcrpkzwXakdrMz1ttgnsAHA1hECfAKz5vtJcpGqUto4
         wB2NmESBvXinISTY9gT6SIZcJXDeaNYxJmhoDSQFvtrd/uUCg6YAKr4KzxgkBPCZtn9S
         M90g==
X-Gm-Message-State: AOAM530rioZuyC9o582jv2aMaBkoTTJ3faFoW+/S5n35++Cpak9XBWBY
        9/XDWmwarM+JpUbkhikIum3e3WOkNq/cIH4HLNn5AiAE
X-Google-Smtp-Source: ABdhPJwCJjf92Y5XiPyAlFTxXjFlF01X/XO+/OFG/UGAXOXwZ01NU787+F7qXpKwmg3g3JNXIAIoy0tpgT03LJUbT8o=
X-Received: by 2002:a9d:429:: with SMTP id 38mr2568495otc.88.1598029479041;
 Fri, 21 Aug 2020 10:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200821063844.17349-1-sonnysasaka@chromium.org>
In-Reply-To: <20200821063844.17349-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 Aug 2020 10:04:28 -0700
Message-ID: <CABBYNZ+XpOa1btcjGqQiosn_oSOBki1-wF4B9jny=Gxzswz6-A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] device: Cleanup att of a device object before
 assigning a new one.
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Thu, Aug 20, 2020 at 11:40 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> For some unknown reason, sometimes the controller replies "Command
> Disallowed" to a Disconnect command. When this happens, bluez kernel
> strangely reports 2 MGMT_EV_DEVICE_CONNECTED events to bluetoothd.
> Unfortunately bluetoothd doesn't handle this case so this situation will
> lead to bluetoothd crashing due to UAF at later time.
>
> This patch protects this situation by always cleaning up the att of a
> device object before assigning a new one. This way the old att will not
> at later time fire disconnect event which would operate on the already
> freed device pointer.
>
> Tested by repeatedly connecting/disconnecting to a device until the
> situation happens and checking that bluetoothd doesn't crash.
>
> ---
>  src/device.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 7b7808405..e696ba1c6 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -5304,6 +5304,12 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
>                 return false;
>         }
>
> +       // This may be reached when the device already has att attached to it.
> +       // In this case cleanup the att first before assigning the new one,
> +       // otherwise the old att may fire a disconnect event at later time
> +       // and will invoke operations on the already freed device pointer.
> +       if (dev->attrib || dev->att)
> +               attio_cleanup(dev);

It might be better just returning instead of cleaning up just to
recreate the instance below or is there a problem reusing the existing
instance? btw we need to investigate why the kernel is reporting
connected 2 times in a row since that is probably a bug there.

>         dev->attrib = attrib;
>         dev->att = g_attrib_get_att(attrib);
>
> --
> 2.26.2
>


-- 
Luiz Augusto von Dentz
