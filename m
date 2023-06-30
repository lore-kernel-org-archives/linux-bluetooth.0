Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBB9EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 22:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjF3WZT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 18:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjF3WZR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 18:25:17 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9926C3AB6
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:25:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so3846492e87.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688163914; x=1690755914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tsyn2aeFJmWCIt+CIIRNtExvH43vvahqiLuTVZJsDz0=;
        b=cInpvRpSMp8WnRZ2lmudAcA9iizP6+TlYWH4aBl1ew0jHGF9iUdYTvHrB8cgXp5KLb
         T554EdmcJIo0mprKyuzoRek3X5NBzeVucWn4aACwR4XD5DxHV4BOr+Y8QuXvKDwOTagP
         zFClpD1u/uLV0exhgUbIzoXxn4BCdJmJHXxfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688163914; x=1690755914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tsyn2aeFJmWCIt+CIIRNtExvH43vvahqiLuTVZJsDz0=;
        b=j1HszC8jfoSHOdeEIjuZqWwcrsk5CVWhEni8snmNxs30vPW+5KBODGSqqMluhzwwIs
         +QmuxsGjU0jLoV5hNfDcavm76L3kXOK2omkikbAVdOddI+3l4q0gXzFJw6bvO5e9Bs4r
         Sh2gr4B6cEzuFOTLO3+b7I2jlEXU8bKj8evb0gXVZvF7EbkhdO9S2yZpEIObeIUy58Ib
         0G0xsgCeKOTEQKdBqsJzq9NZUT8hJ1XYTCwn/96J60jZHv67G4DdVnMdbl741NjpHrH0
         trARP4tk3pM3pTbnWxXMjl0tgTvWdmZbh4O4w8gDDkjaeawf++4c8Q8NBjYc471Q7xKX
         aPvQ==
X-Gm-Message-State: ABy/qLbcosEKkra0mHJceMgFakNyChnq9QNQ/Lu4xw6oOxZ6i2VjrGfN
        MzSh1VWUnvQBf2T1hzV8sToIRQgqlYaeWjpLAjt+fg==
X-Google-Smtp-Source: APBJJlEBbRfFGttpMB/GgubwNNBoDysZdJCviYiquemaPUnHi0+2p3zRq3J8QobM05M+QbP75hQklg==
X-Received: by 2002:a2e:88c8:0:b0:2b6:ca1d:ee88 with SMTP id a8-20020a2e88c8000000b002b6ca1dee88mr3051888ljk.12.1688163913678;
        Fri, 30 Jun 2023 15:25:13 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id c15-20020a170906528f00b00982a352f078sm8414813ejm.124.2023.06.30.15.25.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 15:25:13 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51db8a4dc60so1141a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:25:13 -0700 (PDT)
X-Received: by 2002:a50:c242:0:b0:506:90c4:b63b with SMTP id
 t2-20020a50c242000000b0050690c4b63bmr22665edf.4.1688163912665; Fri, 30 Jun
 2023 15:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230630150906.v2.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
 <CAGPPCLDybSapT7ncUfskHw+ykqcUzbWiayM0YtAW_2RDbB1Qzw@mail.gmail.com>
In-Reply-To: <CAGPPCLDybSapT7ncUfskHw+ykqcUzbWiayM0YtAW_2RDbB1Qzw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 30 Jun 2023 15:25:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XyZ9Zsc3zLcN3iSGRaBLQsQA36MNgXwcW7vj_+gBRkSg@mail.gmail.com>
Message-ID: <CAD=FV=XyZ9Zsc3zLcN3iSGRaBLQsQA36MNgXwcW7vj_+gBRkSg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_sync: Avoid use-after-free in dbg
 for hci_remove_adv_monitor()
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Miao-chen Chou <mcchou@google.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jun 30, 2023 at 3:20=E2=80=AFPM Manish Mandlik <mmandlik@google.com=
> wrote:
>
> Hi Douglas,
>
>
>
> On Fri, Jun 30, 2023 at 3:10=E2=80=AFPM Douglas Anderson <dianders@chromi=
um.org> wrote:
>>
>> KASAN reports that there's a use-after-free in
>> hci_remove_adv_monitor(). Trawling through the disassembly, you can
>> see that the complaint is from the access in bt_dev_dbg() under the
>> HCI_ADV_MONITOR_EXT_MSFT case. The problem case happens because
>> msft_remove_monitor() can end up freeing the monitor
>> structure. Specifically:
>>   hci_remove_adv_monitor() ->
>>   msft_remove_monitor() ->
>>   msft_remove_monitor_sync() ->
>>   msft_le_cancel_monitor_advertisement_cb() ->
>>   hci_free_adv_monitor()
>>
>> Moving the printout to before the memory is freed.
>>
>> Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>> Changes in v2:
>> - Move the print, don't stash handle in a local.
>>
>>  net/bluetooth/hci_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 48917c68358d..7e2ecf8a55d8 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1980,9 +1980,9 @@ static int hci_remove_adv_monitor(struct hci_dev *=
hdev,
>>                 goto free_monitor;
>>
>>         case HCI_ADV_MONITOR_EXT_MSFT:
>> -               status =3D msft_remove_monitor(hdev, monitor);
>>                 bt_dev_dbg(hdev, "%s remove monitor %d msft status %d",
>>                            hdev->name, monitor->handle, status);
>> +               status =3D msft_remove_monitor(hdev, monitor);
>
> Thanks for catching this. But that log also prints the value of "status".=
 So, moving "status =3D msft_remove_monitor(hdev, monitor);" after the prin=
t will print an incorrect value of "status".

Ah crud, you're right. :(

OK, I'll send v3 which will be back to v1 for the first patch.

-Doug
