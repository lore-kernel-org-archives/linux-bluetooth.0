Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19502C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 06:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA4B60F9C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 06:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhHCGmg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 02:42:36 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:44946
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231386AbhHCGmf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 02:42:35 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id B23343F331
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 06:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627972943;
        bh=WOGxtwx6AEh5sPp4Uy0fChJ5+55ettnCggYD7WCOhLY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=dCrDiUW38KjRV+u1obvcGLqtUCZ1p5Rvr1qGJnZy/QLzxr2I9S7pdEELeJ4EG9pR9
         9AI/pliFBbJwqXHcQ3UbnyhatuQzvm8IvC9EaBk/3Ro0w+m1gvz8XoPG4QaiXd3u4a
         JYQgyJL/25NoPWFUVqbuVpWOfcVRmtp/v+ZgPLa22FmfgxSDGoPo0e2T0QWNNGq+QO
         prrOEXFFAQqLW/VRBCOOYvhHvakrm+RbCg2MfC+snQ/kBwcaWK5WDkDHATfoYrDcad
         uMQcer6Fz8z+zhT1kDRJdPvWdbbyU36FFthVsUjbye6bRhWgvEdsJ9CuEpO8uQIY6b
         GX/YUuHejTuDg==
Received: by mail-ed1-f71.google.com with SMTP id x1-20020a05640218c1b02903bc7f97f858so8358941edy.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Aug 2021 23:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WOGxtwx6AEh5sPp4Uy0fChJ5+55ettnCggYD7WCOhLY=;
        b=n3FUBiKwMrMRibrGfkz72KkMSz03MnhfTC5opBkK5TBSnlhFThAEFhZC0ncQF0E/hR
         j8pyMBxsI5SKFJMSvMut3PPkWlVb7JrgjL9Lt303rFnvuZdqDiWsGKBUPn+8bZk3zYwm
         z+aDiqAu2oUydtnYgorROEhZUEXGiOGvVVeUNlyva2EjcU0phDPd0JjC5u4JVNYGuLpB
         a/LamKyCsMu7qXONSuDfBLgbGdCCJDx2bzeRQKFRURlaUmjTQZMzdxhFIMsI5eDOHAsj
         v0vmrVhOl48SvttJDbemIFDRntSn/pZ0zKfFJhdW7KiD0ZEoxE/F0ZxG1wLaBxIw9nJZ
         n0YA==
X-Gm-Message-State: AOAM530/ZnOOw9Vafa51xpRdbDhwgMS/bOhwYr/jko/jsLsZDKUCj8Qp
        hoLcRlLzrzeRLwbw4uMzfABzZYQ6TzQPnd2NQPfuUy2lNi45P05ZZrKo15JvfQqP3oNpVEFeSah
        9VajR13Kpx46d3TEY7vC77KL9TKNety60igK1HpGBwFsHA2YlXeaHiYm+vK5u/A==
X-Received: by 2002:a17:906:4e52:: with SMTP id g18mr19461987ejw.432.1627972943357;
        Mon, 02 Aug 2021 23:42:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4elE987Jh4ibN4W1ZpLtyp77e6TnKGcx0FC8iRxdRfFA+YYC0MIZAsiDuO4B3H+DuiodPtyWa4x9NjD6Ax9g=
X-Received: by 2002:a17:906:4e52:: with SMTP id g18mr19461964ejw.432.1627972943071;
 Mon, 02 Aug 2021 23:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210514071452.25220-1-kai.heng.feng@canonical.com>
 <576B26FD-81F8-4632-82F6-57C4A7C096C4@holtmann.org> <8735ryk0o7.fsf@baylibre.com>
 <CAAd53p7Zc3Zk21rwj_x1BLgf8tWRxaKBmXARkM6d7Kpkb+fDZA@mail.gmail.com> <87y29o58su.fsf@baylibre.com>
In-Reply-To: <87y29o58su.fsf@baylibre.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 3 Aug 2021 14:42:07 +0800
Message-ID: <CAAd53p4Ss1Z-7CB4g=_xZYxo1xDz6ih6GHUuMcgncy+yNAfU4w@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Shutdown controller after workqueues are
 flushed or cancelled
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mattijs,

On Fri, Jul 30, 2021 at 7:40 PM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Kai-Heng,

[snipped]

> Thank you for your help. Sorry I did not post the logs previously.
>
> dmesg: https://pastebin.com/tpWDNyQr
> ftrace on btmtksdio: https://pastebin.com/jmhvmwUw

Seems like btmtksdio needs shudown() to be called before flush().
Since the order was there for a very long time, changing the calling
order indeed can break what driver expects.
Can you please test the following patch:
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2560ed2f144d..a61e610a400c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1785,6 +1785,14 @@ int hci_dev_do_close(struct hci_dev *hdev)
        aosp_do_close(hdev);
        msft_do_close(hdev);

+       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
+           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+           test_bit(HCI_UP, &hdev->flags)) {
+               /* Execute vendor specific shutdown routine */
+               if (hdev->shutdown)
+                       hdev->shutdown(hdev);
+       }
+
        if (hdev->flush)
                hdev->flush(hdev);

@@ -1798,14 +1806,6 @@ int hci_dev_do_close(struct hci_dev *hdev)
                clear_bit(HCI_INIT, &hdev->flags);
        }

-       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
-           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
-           test_bit(HCI_UP, &hdev->flags)) {
-               /* Execute vendor specific shutdown routine */
-               if (hdev->shutdown)
-                       hdev->shutdown(hdev);
-       }
-
        /* flush cmd  work */
        flush_work(&hdev->cmd_work);

Kai-Heng

>
> Mattijs
> >
> > Kai-Heng
> >
> >>
> >> Thanks,
> >> Mattijs Korpershoek
> >>
> >>
> >> >
> >> > Regards
> >> >
> >> > Marcel
