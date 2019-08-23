Return-Path: <SRS0=uRBT=WT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31985C3A5A2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Aug 2019 10:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F420C21726
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Aug 2019 10:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikMLIto/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392571AbfHWKw6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:52:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33934 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbfHWKw6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Aug 2019 06:52:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id d3so5396094plr.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Aug 2019 03:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Gonkm/8q51fc4SdRxd8PQpe0Xki37dFxGWur6VybDyg=;
        b=ikMLIto/m/wgbVe+UaDxGzgDL+uRulcFkZBXkragmjxZA+3lybLmjyJrLhBHPyUJAE
         aecrNS6Q0Gn8epCK/qrV1InWZmYJuxz1/OvuH3nJP04jUoyD+AIkVB7tcp24MK/OsMZm
         bFvxWD/heusl9cmtBnL50LMnO1KvN1td0vD0G2HdSUKshg5nJVKAgHdaH3Jug4yro4nN
         ddE7arql9utMeDe4ljqgAlNCtdDgKazwGCwK1oKSLrCkGkKreMY19ZHzs04EhVk1/92q
         Oq+aCKDu2zzIQAnMBAqCfARTqO/2Ys5QSMYuWj4h2+qm+mUKtrN+6OwNU1tUr+BPYmZX
         gphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Gonkm/8q51fc4SdRxd8PQpe0Xki37dFxGWur6VybDyg=;
        b=gS1dQf8GgBYKymhaEHOuLkhB3CH0qVnmkKYIWTVm2Dhojufsc1nhDiqdcE/7hr2oIL
         d44G1CkCeMeiXIhTQ6O6PnS3l1pfHh7NwBA1pA0yFiake/uHosI1yCdcXgL3jCwKQVJw
         CHt4QdF1no7nc0Aodv/pkeC0RnA8IKDsV0RI0OZ/mavu6lsCoS+fvEbetvVQ7QHvvOwp
         +CwDM2+TJxHFlBmptezdgStyOYWg27LPLx+COXXHSij1qGEAIjTmBeFEY9BbM7romEzj
         PZamvOivLLHKROfWsNrqHOzXJLcZGbxaBXUlQvRYhU2OacXdrqXmJ39EShABIsT9+YlP
         hqGA==
X-Gm-Message-State: APjAAAU6fQiauBRvlFn3tVIoatDGIjUdzg9uHn9HKEhSAy6nbV/K8too
        HPL+Mq+J0c9P7V8DrmGzNZA=
X-Google-Smtp-Source: APXvYqyclXegtG94+OmJm/63kiHmYPWwlkI4R6o1b1Wcge2wHG+vvgqmyJkw2fbxFMCIjgL+IylBNg==
X-Received: by 2002:a17:902:20cc:: with SMTP id v12mr3783868plg.188.1566557577542;
        Fri, 23 Aug 2019 03:52:57 -0700 (PDT)
Received: from jhedberg-mac01.fi.intel.com ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id v145sm2548410pfc.31.2019.08.23.03.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 03:52:57 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/1] bluetooth: update default BLE connection interval
 bounds
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <1c707bb9-999b-7ca3-3c91-7b183dacfdd5@gmail.com>
Date:   Fri, 23 Aug 2019 13:52:49 +0300
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A298FF01-96F0-40B2-9124-3B925C960574@gmail.com>
References: <1c707bb9-999b-7ca3-3c91-7b183dacfdd5@gmail.com>
To:     Carey Sonsino <csonsino@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 20 Aug 2019, at 20.01, Carey Sonsino <csonsino@gmail.com> wrote:
>=20
> Update the default BLE connection interval min/max bounds to the full =
range of permitted values (6-3200, corresponding to 7.25-4000ms).
>=20
> Commit c49a8682fc5d298d44e8d911f4fa14690ea9485e introduced a bounds =
check on connection interval update requests, but the default min/max =
values were left at 24-40 (30-50ms) which caused problems for devices =
that want to negotiate connection intervals outside of those bounds.
>=20
> Setting the default min/max connection interval to the full allowable =
range in the bluetooth specification restores the default Linux behavior =
of allowing remote devices to negotiate their desired connection =
interval, while still permitting the system administrator to later =
narrow the range.
>=20
> Fixes c49a8682fc5d: (validate BLE connection interval updates)
>=20
> Signed-off-by: Carey Sonsino <csonsino@gmail.com>
>=20
> ---
>=20
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 04bc79359a17..f4f2f712c527 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3181,8 +3181,8 @@ struct hci_dev *hci_alloc_dev(void)
>      hdev->le_adv_max_interval =3D 0x0800;
>      hdev->le_scan_interval =3D 0x0060;
>      hdev->le_scan_window =3D 0x0030;
> -    hdev->le_conn_min_interval =3D 0x0018;
> -    hdev->le_conn_max_interval =3D 0x0028;
> +    hdev->le_conn_min_interval =3D 0x0006;
> +    hdev->le_conn_max_interval =3D 0x0c80;
>      hdev->le_conn_latency =3D 0x0000;
>      hdev->le_supv_timeout =3D 0x002a;
>      hdev->le_def_tx_len =3D 0x001b;

This looks fine to me, except the commit message line lengths need =
fixing (max 72-74 or so). It seems we=E2=80=99d want this through the =
Bluetooth stable tree, i.e. still into the 5.3-rc series, correct? =
Marcel, do you agree?

Johan

