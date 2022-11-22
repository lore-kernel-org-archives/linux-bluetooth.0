Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA42C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 00:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiKVAes (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 19:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKVAer (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 19:34:47 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F85C6972
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 16:34:45 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id k19so16284319lji.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 16:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dHhgkoK21s/3LRCz/dbQZlnlzNPjbHbFZwmzf0kclgQ=;
        b=Cr2XWm1jX1nhE+AfzlQbOUL3VreEEwof7YzSyefbsZzxmcC8btqhbhCHSDCuPyHwAK
         aSHgyY7n/WayOkaRtVH/qDmX47SWID5p2z/rq0vdgKdboBCPG108i3+vBWX7iJuRGwDa
         5mTbOhdiPPVgH68qwO4rfC7CFziMdkXosu5VQK6SZBH2Hwu7Gu+PcJD2s+J+1sq1mU8A
         8Dv+TUBb6T/55qVMKkfXCiqASeZZvUYDP7SiSK46LBpuU7//YeUDIh9WqeXtdVvGGt6L
         Wn4jNDr4U2W4M9wkZhePDRnKgQJOG00Mc8d8v7LzrBVzMFkiMIb0m2aejtHdRBKjbB0n
         nirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHhgkoK21s/3LRCz/dbQZlnlzNPjbHbFZwmzf0kclgQ=;
        b=yEz0Sz3iadk74DLfoothHDFZX8govV93+f2FD9wOaG/n4oW7BH1HpbuqNYDNKLJ/cZ
         DRQd16Ye/XBpQgxSTbOnO1dklWurt3Stq2rOufptlXakKXI75AkVtCIeSb6mn62aeWXc
         Diq0+LWDUpG4FM1egt37IFO/lGM8pUc/7qx+X+vtfQWHLr+pv9S7shez7mJ1RoJ25he0
         9+RQXJpHSXTdSWLSGj1+DFUaXJtxjujKdylt+oQEJ1Ve7ku6FR2jCu1cYIOEjdfO1Rsc
         Bwm3Vbo5ctMBbWd3nMKztdImvP1DYgCDzU6nGEShaEIwkeoB/oVX4l7USnp4OTfz4L+8
         /WnA==
X-Gm-Message-State: ANoB5plKOv46V/zGxqZQnc8dt5flYWjdrw4n2QI+uNvVou7zMQBArl26
        3Z25k26cbWBuegQfEK0NHkXxuoKFJ05uydaYODfOWufsBxepXA==
X-Google-Smtp-Source: AA0mqf5ZhTF5k6tZyR8Sxf2RR62m3LgRnwHHLbIcm9LWmh94NggTd0V5xLKMYbsuYh9jYJ/OlRDkDQFFkUZ+wwVCDXA=
X-Received: by 2002:a2e:87ce:0:b0:277:ddf:f476 with SMTP id
 v14-20020a2e87ce000000b002770ddff476mr6635017ljj.432.1669077283736; Mon, 21
 Nov 2022 16:34:43 -0800 (PST)
MIME-Version: 1.0
References: <zEEbuiH5Idm8MyWzcjDThSGXk1jtLq8YxNQPGtHSClFG3F-22Zb3kYwj_IR_YVLszbAnWC-9cqTvWS-RjiZHlNqX8Ftduyy6fwIL8iDHkns=@proton.me>
 <63790ece.020a0220.f799c.57bd@mx.google.com>
In-Reply-To: <63790ece.020a0220.f799c.57bd@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Nov 2022 16:34:32 -0800
Message-ID: <CABBYNZ+eOXGuoqQAsa=OCWcwTz-rnyJLX-b1FawRpPKpfrSJxA@mail.gmail.com>
Subject: Re: btusb: HCI_QUICK_NO_SUSPEND_NOTIFIER causes kernel panic
To:     linux-bluetooth@vger.kernel.org
Cc:     MihirKhatri@proton.me
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mihir,

On Sat, Nov 19, 2022 at 9:15 AM <bluez.test.bot@gmail.com> wrote:
>
> This is an automated email and please do not reply to this email.
>
> Dear Submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.
>
> ----- Output -----
>
> error: patch failed: drivers/bluetooth/btusb.c:2267
> error: drivers/bluetooth/btusb.c: patch does not apply
> hint: Use 'git am --show-current-patch' to see the failed patch
>
> Please resolve the issue and submit the patches again.

What tree is this patch for? Also Im surprised the setting of
HCI_QUIRK_NO_SUSPEND_NOTIFIER would actually cause what you are
describing since in that case register_pm_notifier is not supposed to
be called:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_core.c#n2767

-- 
Luiz Augusto von Dentz
