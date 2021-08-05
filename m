Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F49C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 07:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB676105A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 07:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhHEHEv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhHEHEu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 03:04:50 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB3CC0613C1
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Aug 2021 00:04:36 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id r1so4099727iln.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Aug 2021 00:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8OHXExxtDwOoQLWpw5qKeYWpDd/wE3WEDJewZmrIO40=;
        b=SNyh52+RN1RrKXgLlxVfz7kcXrdsHqrbacEOmQ5w4MvubZE2x+fb1EKKWBGq04t0m6
         0ocTTD2u2Jkd2k8VOfjftapFYwQgkFXbbd0JKMVvlOWRb3LwYt/QBeLJGECinQO/bk8A
         MugGWPBAClM2LNa9gfr/BKWulJ3YXR1ZFaBV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8OHXExxtDwOoQLWpw5qKeYWpDd/wE3WEDJewZmrIO40=;
        b=ju0UN3VA0Ly6uw4kUEKQLigdKhZreY5+JMa61/6eB+5fcKv0dUnOZUgQK4J2Ek3rqP
         FToUVO9KEr4ABmgKcIOlhTfSSkYYTza3KMbiPrVQFbf+jegl9uLgRIkh76s8fFR4Zvx5
         9dLEnk267JkxkZZvPRVKkg0DGqAabHjRBWI67AwvRaU7yIpghu4BV9Hxlr/o88i7Pf4Q
         3lh9tLp+F53CMxSmkVR3xzBVJpeHR3ccBVkh7AEGbjQ5bVkud3WiviCbr6D1XmZlrcZq
         W0wOYQNhmi6uXz6iB3/pdlvrdMacVWOcAuCQgK0YEgwEnT25UQunX/A/A1IzV3lv1wCD
         npKQ==
X-Gm-Message-State: AOAM533Yo1z8QR6QcCFx7KiG2SmrGG73ZPuNN+5yYRDuoaZdtdvhMImK
        vIu5jpcz7NM1W0lHc1kEqsGRBuwOoRR5Y121Tf4zzg==
X-Google-Smtp-Source: ABdhPJzvmCC1+omzWmIHtr7zHneB7lOU5G6A3f5e07pXOtHfTQdwbgU4n5OtcGK6QRP5yXIINmvYUYUtbw8CjFDh+qk=
X-Received: by 2002:a92:c8c1:: with SMTP id c1mr577209ilq.106.1628147075759;
 Thu, 05 Aug 2021 00:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210514071452.25220-1-kai.heng.feng@canonical.com>
 <20210802030538.2023-1-hdanton@sina.com> <CAAd53p4NO3KJkn2Zp=hxQOtR8vynkJpcPmNtwv2R6z=zei056Q@mail.gmail.com>
 <CAJMQK-gT4e_xTc8WY+n52DJPUagPGce-0FJEtqZSwPm3U=LViQ@mail.gmail.com> <20210805070114.2803-1-hdanton@sina.com>
In-Reply-To: <20210805070114.2803-1-hdanton@sina.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 5 Aug 2021 15:04:09 +0800
Message-ID: <CAJMQK-ifNH7hoU-U3EzzrvqBOSG1fq9t=xvq8ry24zJXKPfNVA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Shutdown controller after workqueues are
 flushed or cancelled
To:     Hillf Danton <hdanton@sina.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Bluez <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Aug 5, 2021 at 3:01 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Thu, 5 Aug 2021 14:12:10 +0800 Hsin-Yi Wang wrote:
> >
> >The original patch 60789afc02f592b8d91217b60930e7a76271ae07
> >("Bluetooth: Shutdown controller after workqueues are flushed or
> >cancelled") is causing the tx fail when downloading fw on mediatek
> >mt8183 device using QCA bluetooth:
>
> Want to know if reverting 60789afc02f59 is a cure.

Reverting 60789afc02f592b8d91217b60930e7a76271ae07 can also fixed the issue.
>
> >
> >[  225.205061] Bluetooth: qca_download_firmware() hci0: QCA
> >Downloading qca/rampatch_00440302.bin
> >[  227.252653] Bluetooth: hci_cmd_timeout() hci0: command 0xfc00 tx timeout
> >...
> >follows by a lot of:
> >[  223.604971] Bluetooth: qca_recv() hci0: Frame reassembly failed (-84)
> >[  223.605027] Bluetooth: qca_recv() hci0: Frame reassembly failed (-84)
> >
> >After applying the fixup to allow tx, the issue is solved.
>
> Feel free to specify the fixup and its link to 60789afc02f59.

The fixup is pasted by Kai-Heng here:
https://lkml.org/lkml/2021/8/3/103
