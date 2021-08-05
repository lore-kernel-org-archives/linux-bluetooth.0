Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77949C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 06:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58B4A610A0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 06:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbhHEGzV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 02:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbhHEGzU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 02:55:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92138C061765
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 23:55:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z4so5059152wrv.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=UQut8Ke/ADO3sWjb/iXhRcq7XHUhpPbiGz4qSbh/qc4=;
        b=FXTKey/8zkE8p8iLf73PYkEKQ21oEqVIt8Z16g4+3UGc5EuWvitls4vPwXZQKArgkW
         h9ci+D5xEjD+dj/KYYm3rcjQfrn6Ab2346oo0ufsJi7GOIg1ddw+5S4aqD5kuELnVU+l
         8GwADQLaia/BlIJTXhqFS+elM6iuandX3GyudV4Q52vhtoY9jS9BfgCRWEs9FrM6lsi4
         vXX6dC43uvIWe908VL714AWh5VoII9QGRBb8V8t5+Wxg17XQNe5XLinx2MRmEQ21j+HQ
         nvm/ECDZCLqU7aU4SmZYWCj14HnsFzKDvhaRRayQMWjM2B6tFVbWEJGzFc96aoc24WQb
         x5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UQut8Ke/ADO3sWjb/iXhRcq7XHUhpPbiGz4qSbh/qc4=;
        b=gaBOF+EZTRPFPfTVU+bIHoZ13iCIqBiAL2TbleiwhyTLgsLfbnWILDzzN9pEJUkGxo
         HB3WTpQHfP5tBdq845E2TWHf0xWleX0idf2Djryh4OdX995hOPXUOXWaOKnCBsEOiqxl
         wFMO3ZnKBwshi+HNRcRf7GZWIuRSlsUfYqBYBMAIThNVM6TMjizi5V9s7L0j3uLkq2W+
         qjaXm/LAGVipssWj2JEXXzugRUuk0J2kH9P9PiV2Na7KxsM1Lzr7Cme4CXSX16mOdkhG
         6JlaGE0640X5acOhePiKidM6Zxe4UOP153q9HhqE5rg7eWlpc2dYqFTg1/rdEgtSICfz
         fdow==
X-Gm-Message-State: AOAM532E55sfNQzq0mi5uK0Ofg1cLeJRV7+EjReK7LfH/y8+v9ZeFWvh
        iTmiVvF3aUdWbaSFtLFcUdYtRg==
X-Google-Smtp-Source: ABdhPJz3XnFL0DGFUnzaBTdRDRxgZADi+TIE5d/2ijw/qeG1RZ6wlm+jdbwTraoGpvnWzXv3vBQ7fA==
X-Received: by 2002:a05:6000:124b:: with SMTP id j11mr3351631wrx.348.1628146504096;
        Wed, 04 Aug 2021 23:55:04 -0700 (PDT)
Received: from localhost ([2a01:cb19:826e:8e00:21a2:cbbe:58a1:6e75])
        by smtp.gmail.com with ESMTPSA id j5sm4874231wrs.22.2021.08.04.23.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 23:55:03 -0700 (PDT)
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
In-Reply-To: <CAAd53p6T_K67CPthLPObF=OWWCEChW4pMFMwuq87qWmTmzP2VA@mail.gmail.com>
References: <20210514071452.25220-1-kai.heng.feng@canonical.com>
 <576B26FD-81F8-4632-82F6-57C4A7C096C4@holtmann.org>
 <8735ryk0o7.fsf@baylibre.com>
 <CAAd53p7Zc3Zk21rwj_x1BLgf8tWRxaKBmXARkM6d7Kpkb+fDZA@mail.gmail.com>
 <87y29o58su.fsf@baylibre.com>
 <CAAd53p4Ss1Z-7CB4g=_xZYxo1xDz6ih6GHUuMcgncy+yNAfU4w@mail.gmail.com>
 <87a6lzx7jf.fsf@baylibre.com>
 <CAAd53p6T_K67CPthLPObF=OWWCEChW4pMFMwuq87qWmTmzP2VA@mail.gmail.com>
Date:   Thu, 05 Aug 2021 08:55:01 +0200
Message-ID: <87bl6cnzy2.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kai-Heng,

Thanks for your patch,

Kai-Heng Feng <kai.heng.feng@canonical.com> writes:

> On Tue, Aug 3, 2021 at 4:21 PM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> Hi Kai-Heng,
>>
>> Kai-Heng Feng <kai.heng.feng@canonical.com> writes:
>>
>> > Hi Mattijs,
>> >
>> > On Fri, Jul 30, 2021 at 7:40 PM Mattijs Korpershoek
>> > <mkorpershoek@baylibre.com> wrote:
>> >>
>> >> Hi Kai-Heng,
>> >
>> > [snipped]
>> >
>> >> Thank you for your help. Sorry I did not post the logs previously.
>> >>
>> >> dmesg: https://pastebin.com/tpWDNyQr
>> >> ftrace on btmtksdio: https://pastebin.com/jmhvmwUw
>> >
>> > Seems like btmtksdio needs shudown() to be called before flush().
>> > Since the order was there for a very long time, changing the calling
>> > order indeed can break what driver expects.
>> > Can you please test the following patch:
>> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> > index 2560ed2f144d..a61e610a400c 100644
>> > --- a/net/bluetooth/hci_core.c
>> > +++ b/net/bluetooth/hci_core.c
>> > @@ -1785,6 +1785,14 @@ int hci_dev_do_close(struct hci_dev *hdev)
>> >         aosp_do_close(hdev);
>> >         msft_do_close(hdev);
>> >
>> > +       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
>> > +           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
>> > +           test_bit(HCI_UP, &hdev->flags)) {
>> > +               /* Execute vendor specific shutdown routine */
>> > +               if (hdev->shutdown)
>> > +                       hdev->shutdown(hdev);
>> > +       }
>> > +
>> >         if (hdev->flush)
>> >                 hdev->flush(hdev);
>> >
>> > @@ -1798,14 +1806,6 @@ int hci_dev_do_close(struct hci_dev *hdev)
>> >                 clear_bit(HCI_INIT, &hdev->flags);
>> >         }
>> >
>> > -       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
>> > -           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
>> > -           test_bit(HCI_UP, &hdev->flags)) {
>> > -               /* Execute vendor specific shutdown routine */
>> > -               if (hdev->shutdown)
>> > -                       hdev->shutdown(hdev);
>> > -       }
>> > -
>> >         /* flush cmd  work */
>> >         flush_work(&hdev->cmd_work);
>>
>> Thanks for the patch and your help.
>> I've tried it, but it seems that it does not improve for me.
>> I'm still observing:
>>
>> i500-pumpkin login: root
>> root@i500-pumpkin:~# hciconfig hci0 up
>> Can't init device hci0: Connection timed out (110)
>>
>> Logs for this session:
>> dmesg:   https://pastebin.com/iAFk5Tzi
>> ftrace:  https://pastebin.com/kEMWSYrE
>
> Thanks for the testing!
> What about moving the shutdown() part right after hci_req_sync_lock()
> so tx/rx can still work:
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 2560ed2f144d4..be3113fb7d4b0 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1727,6 +1727,14 @@ int hci_dev_do_close(struct hci_dev *hdev)
>         hci_request_cancel_all(hdev);
>         hci_req_sync_lock(hdev);
>
> +       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
> +           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
> +           test_bit(HCI_UP, &hdev->flags)) {
> +               /* Execute vendor specific shutdown routine */
> +               if (hdev->shutdown)
> +                       hdev->shutdown(hdev);
> +       }
> +
>         if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
>                 cancel_delayed_work_sync(&hdev->cmd_timer);
>                 hci_req_sync_unlock(hdev);
> @@ -1798,14 +1806,6 @@ int hci_dev_do_close(struct hci_dev *hdev)
>                 clear_bit(HCI_INIT, &hdev->flags);
>         }
>
> -       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
> -           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
> -           test_bit(HCI_UP, &hdev->flags)) {
> -               /* Execute vendor specific shutdown routine */
> -               if (hdev->shutdown)
> -                       hdev->shutdown(hdev);
> -       }
> -
>         /* flush cmd  work */
>         flush_work(&hdev->cmd_work);
I confirm this diff works for me:

root@i500-pumpkin:~# hciconfig hci0 up
root@i500-pumpkin:~# hciconfig hci0 down
root@i500-pumpkin:~# hciconfig hci0 up
root@i500-pumpkin:~# hciconfig hci0
hci0:   Type: Primary  Bus: SDIO
        BD Address: 00:0C:E7:55:FF:12  ACL MTU: 1021:8  SCO MTU: 244:4
        UP RUNNING 
        RX bytes:11268 acl:0 sco:0 events:829 errors:0
        TX bytes:182569 acl:0 sco:0 commands:829 errors:0

root@i500-pumpkin:~# hcitool scan 
Scanning ...
        <redacted>       Pixel 3 XL

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
>
>
>
>
>>
>>
>> >
>> > Kai-Heng
>> >
>> >>
>> >> Mattijs
>> >> >
>> >> > Kai-Heng
>> >> >
>> >> >>
>> >> >> Thanks,
>> >> >> Mattijs Korpershoek
>> >> >>
>> >> >>
>> >> >> >
>> >> >> > Regards
>> >> >> >
>> >> >> > Marcel
