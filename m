Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE79C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jan 2021 17:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75FE264E05
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jan 2021 17:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhA2Rr4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jan 2021 12:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhA2Rpq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jan 2021 12:45:46 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEB7C06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 09:45:02 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id b5so5296806vsh.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 09:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDZFBI2Ktm4KXQ9tPgJSgleFsR41D0VLMKKTpQlt7jE=;
        b=IuqEbTEPrkK8Yjt+TNSpT7KGYFeWTsU5LqUQC8NRTaE7h9rwxFwThZsM11dOqvC8t8
         LTDiprN0msmL6BqkpSByeBtnhYqDtCeTtUtCShMEmT3xoABb18VjQP8n4xZSm2gCCrbP
         5yH5OQqvtASpbGVsU+7HeLQoM1r/1GhdCzJIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDZFBI2Ktm4KXQ9tPgJSgleFsR41D0VLMKKTpQlt7jE=;
        b=rIjjaC8JeaS4KCeDB719X2wMhnzgXc7gjnh0xBUUieZb05gYZtFFuru8hv75HVqDzQ
         fmynFh2u17yWDJbrfjg1GAnOwhvQl8FoU0RogzPbs0DuBUI9koHlr6+Gv5InMrwWqJxu
         vd0FoEoiHwJMaxNgrA3bv0GsiEUnX5XCdqds/vJylu275IUrekjzW4EbYxlP8gY4dxAD
         LBNId0AGBGKGHtE5kiFAO/zfJxxxycge7rbxNeslrmN04YjbgG5AedtsguQM+BT9MWQU
         BK3ryvs88dbr6sRorfrO7SUwI/pCXfEZqtrI5E5yWXCqiaveCxPGRwzor6qTcCKay/eT
         bDMg==
X-Gm-Message-State: AOAM532ogNI2CGnsKs9DF7q3uhA0L2ui7oQYhtt3vrs1Z7RPPtBWSERq
        KWYf1pjU6AueMSMWUueDOZYJFVA4OCPwBpjI1SYT8A==
X-Google-Smtp-Source: ABdhPJxmfIUhUbKGQ5EcrKDy6LC3Do+2qC9ViAim2VuCk/wQqhBpGHilCMmcB0f+Xnms+pUiFVtF45ciS4L3LdKCqrA=
X-Received: by 2002:a67:e353:: with SMTP id s19mr3528765vsm.53.1611942302009;
 Fri, 29 Jan 2021 09:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20210128163313.426404-1-hdegoede@redhat.com> <20210128163313.426404-2-hdegoede@redhat.com>
In-Reply-To: <20210128163313.426404-2-hdegoede@redhat.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Fri, 29 Jan 2021 09:44:50 -0800
Message-ID: <CANFp7mUaHyhS_QoQ6BHjA=4kgrKKYQ_SgOzBD=UqWZMgAukJuw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_h5: Disable the hci_suspend_notifier
 for btrtl devices
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>, max.chou@realtek.com,
        Alex Lu <alex_lu@realsil.com.cn>, hildawu@realtek.com,
        Claire Chang <tientzu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Jan 28, 2021 at 8:34 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The hci_suspend_notifier which was introduced last year, is causing
> problems for uart attached btrtl devices. These devices may loose their
> firmware and their baudrate setting over a suspend/resume.
>
> Since we don't even know the baudrate after a suspend/resume recovering
> from this is tricky. The driver solves this by treating these devices
> the same as USB BT HCIs which drop of the bus during suspend.
>
> Specifically the driver:
> 1. Simply unconditionally turns the device fully off during
>    system-suspend to save maximum power.
> 2. Calls device_reprobe() from a workqueue to fully re-init the device
>    from scratch on system-resume (unregistering the old HCI and
>    registering a new HCI).
>
> This means that these devices do not benefit from the suspend / resume
> handling work done by the hci_suspend_notifier. At best this unnecessarily
> adds some time to the suspend/resume time.
>
> But in practice this is actually causing problems:
>
> 1. These btrtl devices seem to not like the HCI_OP_WRITE_SCAN_ENABLE(
> SCAN_DISABLED) request being send to them when entering the
> BT_SUSPEND_CONFIGURE_WAKE state. The same request send on
> BT_SUSPEND_DISCONNECT works fine, but the second one send (unnecessarily?)
> from the BT_SUSPEND_CONFIGURE_WAKE transition causes the device to hang:
>
> [  573.497754] PM: suspend entry (s2idle)
> [  573.554615] Filesystems sync: 0.056 seconds
> [  575.837753] Bluetooth: hci0: Timed out waiting for suspend events
> [  575.837801] Bluetooth: hci0: Suspend timeout bit: 4
> [  575.837925] Bluetooth: hci0: Suspend notifier action (3) failed: -110
>
> 2. The PM_POST_SUSPEND / BT_RUNNING transition races with the
> driver-unbinding done by the device_reprobe() work.
> If the hci_suspend_notifier wins the race it is talking to a dead
> device leading to the following errors being logged:
>
> [  598.686060] Bluetooth: hci0: Timed out waiting for suspend events
> [  598.686124] Bluetooth: hci0: Suspend timeout bit: 5
> [  598.686237] Bluetooth: hci0: Suspend notifier action (4) failed: -110
>
> In both cases things still work, but the suspend-notifier is causing
> these ugly errors getting logged and ut increase both the suspend- and
> the resume-time by 2 seconds.
>
> This commit avoids these problems by disabling the hci_suspend_notifier.
>
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Cc: Vasily Khoruzhick <anarsoul@gmail.com>
> Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Per the other conversation thread, since the h5 driver unconditionally
reprobes on resume, this change looks good as-is.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
