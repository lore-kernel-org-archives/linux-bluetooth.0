Return-Path: <SRS0=eiFZ=A2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57A1C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 18:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EAD920672
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 18:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHDzb8T6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGOSfG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgGOSfF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jul 2020 14:35:05 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33ADC061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 11:35:05 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g37so2226191otb.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 11:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0eqcagrE5c8qsi0gBLE230gaYYz1327tuB+N9Gr+eeY=;
        b=ZHDzb8T6xX/0jc3o5jbYyiHR47vANcug8kpk09yFHIo566bE3eg2zVo8Yb01KsFLpo
         Hl/skSTpX8ThWz4SAmYPCz3TGa0dAiJpL1U7S3ONIwtx9SPAj7i45TsAIpbnTfrtrMj0
         MUnb4F/4nsUv/OD6PbBaMbp/mLgy9XUt7XBpVB5h84FoYuR2VzYnLaHrsiAijkrGM/HL
         JIYRYqiG7U6BD9Sa2YKAf/ssHwqhjwjirt0yPkZe9oivt49YghF0UnlvVu6/OS2i+qnR
         T5QtkjHq/RUIRI62wOWAp68LG+flIYxVLgWdGuYyuAFNszNkN9AwDUDGREw7TDXPs9VG
         PJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0eqcagrE5c8qsi0gBLE230gaYYz1327tuB+N9Gr+eeY=;
        b=oC63PGL0x/JOQxN6MkhLt2XimrmQA4go9vwhU48YZYgmLlXbTqvUxvaA+SHGJMI+w7
         I+b/e7RsjcTDo+dxpUdtVp3acaI/UFjTMEK2NOTci9dhEtjnyCG6Wa7Fb8wnHvtntXQO
         uftG/BX/wog72DrSU2H59nCYuReSTfipEGfR/CtL5Oo/oIluAAHlyJMVsFqWLmd7PaNQ
         50KHDaSA3EWwXLevOVGJ+TUSSfz23zZXJxatRDrun+f+k6uivVEU6uaGBtw8yHZAzs8V
         8KPnMEzfJ8JSUK7b+dOtolRIj9aTqw+/PkNh71+kVNVV+7hSSMkKTVAC1aHnkm8e9Dug
         mcbQ==
X-Gm-Message-State: AOAM530npZTHIS2U6H99fjzdabC5N9awhYu4P0Yoez/bYJmF06r8Z/RA
        zwkDumAe4SGBBB/UCWIBSWBRkqvJyH/FqzPLQcU=
X-Google-Smtp-Source: ABdhPJyZAv5ZO4u/WzjgvfFAIwO/HOEMHFMtQbDsKy8VV30nadyS9Ml4EGwaN7bxlcByK+stPDoDYugk0zblqWXsINc=
X-Received: by 2002:a9d:5e18:: with SMTP id d24mr944874oti.88.1594838105141;
 Wed, 15 Jul 2020 11:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <0df5bf3eac160de28b9493a8959510980a8a8e8b.1594803508.git.ps@pks.im>
 <50fd2c75ce196196f879f8373555cc30bfc75154.1594834970.git.ps@pks.im>
In-Reply-To: <50fd2c75ce196196f879f8373555cc30bfc75154.1594834970.git.ps@pks.im>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 15 Jul 2020 11:34:53 -0700
Message-ID: <CABBYNZK8_Di=sn=_EBTGR6sdw5hpSVy4+0K_e_EHwNN-DUY4MA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Fix update of connection state in `hci_encrypt_cfm`
To:     Patrick Steinhardt <ps@pks.im>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Patrick,

On Wed, Jul 15, 2020 at 10:45 AM Patrick Steinhardt <ps@pks.im> wrote:
>
> Starting with the upgrade to v5.8-rc3, I've noticed I wasn't able to
> connect to my Bluetooth headset properly anymore. While connecting to
> the device would eventually succeed, bluetoothd seemed to be confused
> about the current connection state where the state was flapping hence
> and forth. Bisecting this issue led to commit 3ca44c16b0dc (Bluetooth:
> Consolidate encryption handling in hci_encrypt_cfm, 2020-05-19), which
> refactored `hci_encrypt_cfm` to also handle updating the connection
> state.
>
> The commit in question changed the code to call `hci_connect_cfm` inside
> `hci_encrypt_cfm` and to change the connection state. But with the
> conversion, we now only update the connection state if a status was set
> already. In fact, the reverse should be true: the status should be
> updated if no status is yet set. So let's fix the isuse by reversing the
> condition.
>
> Fixes: 3ca44c16b0dc ("Bluetooth: Consolidate encryption handling in hci_encrypt_cfm")
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

Acked-by:  Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

> ---
>  include/net/bluetooth/hci_core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index cdd4f1db8670..da3728871e85 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1387,7 +1387,7 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
>         __u8 encrypt;
>
>         if (conn->state == BT_CONFIG) {
> -               if (status)
> +               if (!status)
>                         conn->state = BT_CONNECTED;
>
>                 hci_connect_cfm(conn, status);
> --
> 2.27.0
>


-- 
Luiz Augusto von Dentz
