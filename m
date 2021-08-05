Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E6FC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 07:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C51D6105A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 07:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbhHEHUA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:20:00 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:42776
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230471AbhHEHT6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 03:19:58 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 477233F230
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Aug 2021 07:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628147984;
        bh=dprqqFGKEqV7x72rJjapY3EuNeylEWr75863Ym1V8hE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=UaawYewZNmUGp42wwo3WI+hloRHvyzr7nQCx3BEF0Bg+i7F//zdTz0YqcHTBeCt4E
         WDN7y3zDb73kaGqYf8iPXJFZAgJf7LnIICQV4GfJL69ZCMkhueS+8qXIXdNSNaVXBd
         9kmEqgqV7Zpm5zXfQyhck9Bq7wD0ZC0Njrcg+FJOiHGj5i1DYg13pyBXmx0o+X64bt
         dc+zQY8lxM9XZpN3X9EWGq7sL9AGkjMExRQ11XLdi0PCUCykPhze+DdCRR10Vdm5EQ
         oj5/kbSIR9GPVO5ppPVJW34bvZjCa3L4CAcbINpPKAP0V/aIRXkXypeiM4yHsAgrmv
         KvlG7R4waPqTg==
Received: by mail-ej1-f72.google.com with SMTP id zp23-20020a17090684f7b02905a13980d522so1718289ejb.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Aug 2021 00:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dprqqFGKEqV7x72rJjapY3EuNeylEWr75863Ym1V8hE=;
        b=OJO7PXZcmO+8l8e91w/T8s8ckcg3b+yhu07WgiXetCeujqxgudX7KLaJ0bFEgANpld
         s7Wa7vjQvAXAYDVgx+i1Qv0KbqJNvO36kxmIY6uY69lDjTvi1myH3YMcIIm98Ltguy/A
         De6W2ftklBQeb3Mf5Bq7QXc4CwD90PCBQbCAXkocNXNp86n8S8VkdN5KtYgSqKa8GAMp
         LgoOt5eK9STEZWMtsvir+97m7dQdDUEcqzvRZIfEFeZsfU3sB4xMictFK1bD95fLXsNj
         0XnOkdr9s7CD/cAOiGh5YlVf0NTp+TPF/UCLvFBiw4yrQT7wprYh1xQ6u+rFmgIyB3fT
         G+kg==
X-Gm-Message-State: AOAM533s8uMGHrsCRPJxoNqhbrqBtk2BmdlllnXikatZiWpAYDoD8xj7
        dpDfhEvZgqerRhEMWCI/JVWf2loYPSm4pmswUXYSFAH9ya0ydHCLOOC8NR+fKVjZrvdgv37VJwa
        rcDKc6YkcLjg26xMA/9714TozEYrCx8ruU3uQKC+8EdQejANfokK6BiTlEaf2Sw==
X-Received: by 2002:a17:906:79a:: with SMTP id l26mr3575772ejc.192.1628147983941;
        Thu, 05 Aug 2021 00:19:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVYx4H8kX3IITvR/G2XnEd7cg1AeN9XxMaCTLuh5W0I1dUh/MVFTganzFvEkf0oFXCWq00D8/9Ojo4LD8FkXQ=
X-Received: by 2002:a17:906:79a:: with SMTP id l26mr3575754ejc.192.1628147983672;
 Thu, 05 Aug 2021 00:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210514071452.25220-1-kai.heng.feng@canonical.com>
 <20210802030538.2023-1-hdanton@sina.com> <CAAd53p4NO3KJkn2Zp=hxQOtR8vynkJpcPmNtwv2R6z=zei056Q@mail.gmail.com>
 <20210803074722.2383-1-hdanton@sina.com> <CAAd53p6wi7pk6yFgTnG-JDd9e4zCn3F40bioYyGbAqYg5kMHZQ@mail.gmail.com>
 <20210805030024.2603-1-hdanton@sina.com> <CAAd53p439uW9D1rK07JUQFhVfs1FCvm_rECExp0JmzFHB7dGNg@mail.gmail.com>
 <20210805063536.2698-1-hdanton@sina.com>
In-Reply-To: <20210805063536.2698-1-hdanton@sina.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 5 Aug 2021 15:19:28 +0800
Message-ID: <CAAd53p6BXj_Yxq+8GvDW4eNvbXisz2WK9uf5rcLrCwkMiSB4-g@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Shutdown controller after workqueues are
 flushed or cancelled
To:     Hillf Danton <hdanton@sina.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluez <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[snipped]

> >How? Most of the time the BT controller can't be brought up again
> >after shutdown(), and we need to stop other activities before that.
> >What other reasoning is expected?
>
> See below.
> >
> >Kai-Heng
> >
> >>
> >> >time it's just "Bluetooth: hci0: HCI reset during shutdown failed" in
> >> >dmesg.
>
> In drivers/bluetooth/btusb.c, there are three cases of
>
>         bt_dev_err(hdev, "HCI reset during shutdown failed");
>
> and in btusb_shutdown_intel_new() it has nothing to do with kfree_skb()
> because of IS_ERR(skb).

No, kfree_skb() doesn't gets called in this case. But when that
happens the BT controller won't work anymore.

>
> Feel free to specify why an skb error links to the race you are trying to fix.

The race here is that the btusb_shutdown_intel_new() is trying to
reset the controller while other works like scanning or discovering
are still underway.
So the patch is to ensure that shutdown() callback is invoked after
other works are cancelled.

I think I understand what you are trying to ask, you want to know
where the double kfree_skb() race happens.
I didn't really investigate that because quiesce the other activities
then call shutdown() is the right thing to do and I haven't seen the
kernel splat since.

Kai-Heng

>
> >> >
> >> >Kai-Heng
> >>
> >>
> >> +++ x/net/bluetooth/hci_request.c
> >> @@ -257,8 +257,10 @@ int __hci_req_sync(struct hci_dev *hdev,
> >>                 break;
> >>         }
> >>
> >> -       kfree_skb(hdev->req_skb);
> >> -       hdev->req_skb = NULL;
> >> +       if (!err) {
> >> +               kfree_skb(hdev->req_skb);
> >> +               hdev->req_skb = NULL;
> >> +       }
> >>         hdev->req_status = hdev->req_result = 0;
> >>
> >>         bt_dev_dbg(hdev, "end: err %d", err);
