Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F3BC28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 22:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbiHVWnX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 18:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238545AbiHVWnS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 18:43:18 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3C0F57
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 15:43:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x10so11966214ljq.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=739pd3enK8jIurUnVnMrXucPvCdt7QWPQOgq04buA+k=;
        b=d0lZywBMXct45K86lWG0zzV4zbP3yEKHSuHPdt1ZRtQv2RHLTamg84JwffvitCNB2u
         oFOKz18xwN5EWRSUHd1S6ZgyuzNSEhhnwrUV1tGl5Xz9zB7kM4AwZCHGyAWDgiPjDtg9
         HVBHkJC8Eonh8kuz/2EQuctf4JtkFdKDbcvsBLz63vZ7CWtnhF79hNebzkmosAyrSL2t
         aSFr4qeKHG6ScmC/j+XHKmkgCR5V5GlY5NnIU8Lkk1M2keIzTLDX/HUxeOmBsY0SAdsC
         ooNd/O1zUDIuS2dXADJpQOlEOiqzsvT5i8UwjtLp/xB21Q5ZDM6PFilKv1DYeheNX4tC
         nx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=739pd3enK8jIurUnVnMrXucPvCdt7QWPQOgq04buA+k=;
        b=oEWJwxO+VRZCwWC5wKB7Uq6ME/H4OQ0NFwh1B/unVHpmESier/659uhIcxOI6ZfIcu
         yvHnt9fjaFo9QLm8zOP3wyDYF6pGQ0+u+GdvuRQGswTnR5OmN9Xn41Vz0Z/RYxUSHzHK
         xP77VEudHA8WWECPjZjJ8sManVsntAVhZ3/RXYkwkt7O5BQZCaRTcgPTPQ7WR9krIwby
         r4uBKWexGwG+BXOJu75Dje8mQJlKTkGm00FTdpzG/MCjZZHUl8oGcUrkU8kH+ttBBGG7
         8UZgqT5XbKBjUWUAbXhhd74iHSizi5TC7nRy0kN9AQQzV1bc0qw1tIWfu+ew9ifFXuky
         Zkbw==
X-Gm-Message-State: ACgBeo0d/Qa1Z655c53YvCH86CCnv7rxgLZnHg0i0/qyVozxF4N6Ijwq
        fC7HKqhRqSEUp+ZtwjEtZPfsT2uROpywych12Ft+sc7m
X-Google-Smtp-Source: AA6agR6N/7hG/FgE+2mOQI1PtuNNJJehpMlaz4zRzBZEfw0SfP4wuWmePPcpz64F0s0mzRRItLh89o17wq//89J1c3c=
X-Received: by 2002:a05:651c:54c:b0:25f:dd42:5d06 with SMTP id
 q12-20020a05651c054c00b0025fdd425d06mr6619537ljp.161.1661208193609; Mon, 22
 Aug 2022 15:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR13MB5755759CD2C40AE2F350A556FE719@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <CABBYNZ+KRZSBYJiFo2X5CXE-SuYyARScephbJq-nvN9oCH_iXQ@mail.gmail.com> <SJ0PR13MB5755B59D0F772BDB0A88B867FE719@SJ0PR13MB5755.namprd13.prod.outlook.com>
In-Reply-To: <SJ0PR13MB5755B59D0F772BDB0A88B867FE719@SJ0PR13MB5755.namprd13.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 Aug 2022 15:43:02 -0700
Message-ID: <CABBYNZJcSo1ZE_tuO+mPQJV9GWCcnWnGCUdCQ9CfAT3BUXfr0A@mail.gmail.com>
Subject: Re: Can BlueZ D-BUS API identify local Bluetooth hardware version?
To:     John Klug <John.Klug@multitech.com>
Cc:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi John,

On Mon, Aug 22, 2022 at 10:57 AM John Klug <John.Klug@multitech.com> wrote:
>
> No.  I want the hardware version of the device as specified by Bluetooth SIG.
>
> Or at least the manufacturer and model of the local device.

That is normally exposed by the bus/driver under sysfs.

> Not the bluez version.
>
>
>
>
>
> John Klug



-- 
Luiz Augusto von Dentz
