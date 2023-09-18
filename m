Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10E9C46CA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Sep 2023 17:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjIRRh3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Sep 2023 13:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjIRRh2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Sep 2023 13:37:28 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0D1DB
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Sep 2023 10:37:23 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c00c0f11b2so20190681fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Sep 2023 10:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695058641; x=1695663441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBefTqBgVyoSUAhFFxsBE+sgujgWPn4S3aI0Xo/uwRo=;
        b=Axdp0+FN2s6Ki/CL9BRe3+M2E8Qg1xMOYmg37YO1SL2wLAjtwEIULFkXtz8l/VMyMX
         iosffPHi7XQhrbC4LtUK7iVCBAmjKW5SrBqSrw5eMUENamkoytxRZSDAAzE//AKtbMkL
         xPMCMZIGepRKMFGhBFxwKypZ4UrKG5lsxJa5vmhFPKdFgcFfttotQnvQ1QwYEm+XQkwn
         fu8q/aniZnA7IeznXUkfTCuN314VgyMai2h78FvQvXq5VDRTAqe2ma0anLq9r248DAoV
         pQRNMdWkdI8zk4c2bfgwJVmuBRD9hndV0npq7IUuqcHZqqvngBMZMOdO/qXY9DbNaQYu
         /esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695058641; x=1695663441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBefTqBgVyoSUAhFFxsBE+sgujgWPn4S3aI0Xo/uwRo=;
        b=CQJPDf4OQDERciEHNteFsi6qkz96AeO6uek8J+UK8zLs5/4QMOy1LPkECcF/44SU3M
         RuW2ukbijVS5TrHxz43jsWWlJn7FxV3eSU3MUQ7HUiTk0jC4He0gA1/pXhOs6dktcqe7
         X2gAdVLT5elRzcZC0oT/8ENT9k6p1W550jGxZMyAyo/K8ANqtKGfLGig2TzFoV33WTnX
         iISKY4KbR979/e74k8qWx9ezKLvrUZdkAuxfFn8L+arq2K3qkiPzqGdqjc2lnW5kp8l3
         061F274tV6wSx/H6K7EVnhtSTgy8tYL0hhk0YERrDZ0z11bIDDc6OTk+aO/sGbD2O3Jk
         ut6Q==
X-Gm-Message-State: AOJu0Yz2qjq/c5oa31+SH3CZ5WF6oII/cwhXfOIduEMIf4gNUuSmygNq
        /xLK1fU6+rEGdNRDOsIBC1WrVBqx4spuUCvgGMzgwos7LtU=
X-Google-Smtp-Source: AGHT+IH7XTbQQHf5e4te/+oVRKNtPB+T4MaWOH0KJIeJz7oVFuq3eR1CJjLK5vQNwq8dohslI5dNrZsDR2TtS1RJ0x0=
X-Received: by 2002:a2e:9556:0:b0:2b9:aa4d:3728 with SMTP id
 t22-20020a2e9556000000b002b9aa4d3728mr8322158ljh.29.1695058641051; Mon, 18
 Sep 2023 10:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230918093517.2163899-1-kiran.k@intel.com>
In-Reply-To: <20230918093517.2163899-1-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 18 Sep 2023 10:37:08 -0700
Message-ID: <CABBYNZKTQc-aQg+Yxzt7euZ1uDF0eQr_ipkFAOjuq+iPGKH3SQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: Release memory allocated to store supported codecs
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Mon, Sep 18, 2023 at 5:04=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> Memory allocated to store local supported codecs needs to be freed
> when BT is powered off.
>
> Fixes: d0b137062b2d ("Bluetooth: hci_sync: Rework init stages")
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  net/bluetooth/hci_sync.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 1be5763c261c..3640d73f9595 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5074,6 +5074,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>         memset(hdev->eir, 0, sizeof(hdev->eir));
>         memset(hdev->dev_class, 0, sizeof(hdev->dev_class));
>         bacpy(&hdev->random_addr, BDADDR_ANY);
> +       hci_codec_list_clear(&hdev->local_codecs);
>
>         hci_dev_put(hdev);
>         return err;
> --
> 2.25.1

Ive sent a similar fix already:

https://patchwork.kernel.org/project/bluetooth/patch/20230915234742.3739283=
-2-luiz.dentz@gmail.com/


--=20
Luiz Augusto von Dentz
