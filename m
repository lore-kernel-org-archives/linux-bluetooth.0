Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA88BC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 09:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE63F61055
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 09:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhHIJUI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Aug 2021 05:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbhHIJUH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Aug 2021 05:20:07 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33978C061796
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Aug 2021 02:19:47 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so14038891wms.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Aug 2021 02:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=5e4PmsQRlGxMmgnJTg6Pkw2CO7JWPy14wJKAd7YTXoA=;
        b=hvypfmlDzIEtp+RFWIZ+IAjKcCtsgxKQl29O4edQD4OfnlIuLLtj86o1+LqmYpxp/h
         9oNOkiI8Xus0N+SNEypAy9rrWnVHtWNWODgQBxfn9gW1l0bQ4XPa2rcb8BrefO7rdFB5
         ZDeA9L/kpX7bTSYJ3fyLZBwdAeHINJLTZqUnQ7y1jGt2voEYnbPqOtnB8JbkgKn3KTA3
         wlKbLIzE3mEq1e8hxWRssPrUZPcxwoj0OStCUmQKwrVisDtQV7xi10kPqPZFvHQw3eEH
         M84+KkhL06mssoHFLZjPndCTjYbxp2wgoS4szLGzGFwhs4mFXZjSEBM4D4iE03K9qQ/+
         h+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5e4PmsQRlGxMmgnJTg6Pkw2CO7JWPy14wJKAd7YTXoA=;
        b=iL32U77xWyX9V2i7Z8G+OuXka+M3uoUNuz3OB0wvjhgfb/ETDLNYVDTNNly7/5XuDC
         doCIMOvtNPlgOURvwP/7ug1eu7FDpKe1vsY/TpdGpf7Px5qp/WSzOh5ZcXSDMaot1Aem
         6TcklQQ+ghd4iMXhRCT0KsDZq1O6TV6H4SmVPTCphIqrKzUtgI6fFZ1LCzoZYxlo+c9h
         Jaaa1MxCS6lG5iA3gfRX3JnCQ5cjmkFLrwzI0EHOl8K7+ZIcZ2lSlfZPFodesoActQfF
         M+s6v1FBGHfAAK8+/CxvDwX3pSLURJFuoLTrC4J1+uUMsW+sUKvBIH/L6vBxpqH/1Gn4
         f7vg==
X-Gm-Message-State: AOAM532+DJ5359uyrY538xi0osEcTYapeiB7afcc6BnWCAAxSfv9gEtn
        ymAXbxh1KrdGIaA0LZHdjNII5Q==
X-Google-Smtp-Source: ABdhPJw9QL++xee1pGp15c5K3+y5HzRSDMKeZ3dhMUZEKX8fIkOyo+0wjtLG1eTf8hBJjB/DZlCY0w==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr15613475wmi.70.1628500785673;
        Mon, 09 Aug 2021 02:19:45 -0700 (PDT)
Received: from localhost ([2a01:cb19:826e:8e00:ef10:98d1:78e3:9e80])
        by smtp.gmail.com with ESMTPSA id r129sm16719560wmr.7.2021.08.09.02.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 02:19:45 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
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
Subject: Re: [PATCH v2] Bluetooth: Shutdown controller after workqueues are
 flushed or cancelled
In-Reply-To: <CAAd53p7BU2=GwmyLUECKZfGhD830UQUk12mxU2y9HsXv=F_AfA@mail.gmail.com>
References: <20210514071452.25220-1-kai.heng.feng@canonical.com>
 <576B26FD-81F8-4632-82F6-57C4A7C096C4@holtmann.org>
 <8735ryk0o7.fsf@baylibre.com>
 <CAAd53p7Zc3Zk21rwj_x1BLgf8tWRxaKBmXARkM6d7Kpkb+fDZA@mail.gmail.com>
 <87y29o58su.fsf@baylibre.com>
 <CAAd53p4Ss1Z-7CB4g=_xZYxo1xDz6ih6GHUuMcgncy+yNAfU4w@mail.gmail.com>
 <87a6lzx7jf.fsf@baylibre.com>
 <CAAd53p6T_K67CPthLPObF=OWWCEChW4pMFMwuq87qWmTmzP2VA@mail.gmail.com>
 <87bl6cnzy2.fsf@baylibre.com>
 <CAAd53p5TVJk3G4cArS_UO7cgUpJLONNGVHnpezXy0XTYoXd_uw@mail.gmail.com>
 <87tuk3j6rh.fsf@baylibre.com>
 <CAAd53p7BU2=GwmyLUECKZfGhD830UQUk12mxU2y9HsXv=F_AfA@mail.gmail.com>
Date:   Mon, 09 Aug 2021 11:19:43 +0200
Message-ID: <875ywfnff4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kai-Heng,

Kai-Heng Feng <kai.heng.feng@canonical.com> writes:

> Hi Mattijs,
>
>> [snipped]
>
> Thanks for your testing. I think I finally got it:
> btmtksdio_shutdown()
> -> mtk_hci_wmt_sync()
>  -> __hci_cmd_send()
>   then waiting for BTMTKSDIO_TX_WAIT_VND_EVT, which is cleared in
> btmtksdio_recv_event():
> btmtksdio_recv_event()
> -> hci_recv_frame()
>  -> queue_work(hdev->workqueue, &hdev->rx_work);
>
> That means it has to be done before the following drain_workqueue() call.
> Can you please see if moving the ->shutdown() part right before
> drain_workqueue() can fix the issue?
I've tested the following patch:

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2560ed2f144d..131e69a9a66a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1757,6 +1757,14 @@ int hci_dev_do_close(struct hci_dev *hdev)
                        cancel_delayed_work_sync(&adv_instance->rpa_expired_cb);
        }
 
+       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
+           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+           test_bit(HCI_UP, &hdev->flags)) {
+               /* Execute vendor specific shutdown routine */
+               if (hdev->shutdown)
+                       hdev->shutdown(hdev);
+       }
+
        /* Avoid potential lockdep warnings from the *_flush() calls by
         * ensuring the workqueue is empty up front.
         */
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

It does not seem to fix the issue.
Adding the bits in btmtksdio_flush() does not change the result of the
above patch.

Here are the logs. These are just with the above patch (not with the
btmtksdio_flush() changes.

dmesg: https://pastebin.com/FZZBkqGC
btmtksdio_ftrace: https://pastebin.com/JQ0UWenY

Mattijs
>
> Kai-Heng
>
>>
>> Mattijs
>>
>> >
>> > Kai-Heng
