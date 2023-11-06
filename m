Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D90EC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Nov 2023 16:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjKFQQU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Nov 2023 11:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjKFQQS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Nov 2023 11:16:18 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6581BC
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Nov 2023 08:16:14 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c5071165d5so62644741fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Nov 2023 08:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699287373; x=1699892173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVwdwenXFfY2EE+9wZVcCTiv1FNAfoxHSAl7MDJgIN0=;
        b=NlGfVnbofvN4MT098goO97aWkyXjVFTHY/kL2xMqX604VGwjKK7Cqg6Ma6fsnaPIbU
         T+0vWrxNnyDvpvJ66RfKQE7HyXj/auk5tUKgBMUH4X0xEH2BTmItoqTuvcPQDaDkKG07
         IjqXdvQReSOUzHXxgSyUbsqpz1pXLuDkyBXayYJR75HAjxqMXsdtrk4o4dPHPzy+c0P0
         Z6wjYGtE4ppJkKk3pFjJAPOWIKY9/QiaLELXVnZZj75ySv59VJWVQ9XVDhhKGnpD6FlG
         o5rTrQtjFR7OkQI0FeoozeMerLyJw+Sn5oxzQagmcta7/4uF/vqsiUr2Mx6iBZEEVwah
         mq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699287373; x=1699892173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVwdwenXFfY2EE+9wZVcCTiv1FNAfoxHSAl7MDJgIN0=;
        b=GpNL0pZ0lFsRAAVmrJrNOYHOM5vuZK4PzBUQZIY+7na0kRbo51ka57OAweB0Y7pEjo
         7B7W3LJ4iqDpBk5xId6KKM/T8/tTSLGGZGOpYo0dCDKhI9mXsBTtKJOX7xhwlQOyzGu7
         ri6hnyJmpic+sdx+4OBL8yUrvp06n9VRjZFIwt2OsKZ0I/PiamqIJ0bpCXYKAMNfOngH
         8kemAiBj3yKLktRcpG5BR4PAaV728tm7Xo6AX57P1YmBpjTldle7yCqqFAWuCmBNkzLQ
         Ny2pdcAz4S9vqeHqPV0TM49Uju3mjDPxd3isBBVaGkZTNJvJX4ArY8SZrT5e3BW8iGVk
         wCjg==
X-Gm-Message-State: AOJu0Yx3Ho+UxVpf4cKTHIV4y+4OOZPjy26GgIO3nHbEHYIvk7XWZYx3
        8KkuGFcsGv1xSbJ80yMg/BRQ5F+Lwlq3X2u0qEM=
X-Google-Smtp-Source: AGHT+IFGAzsam4kPZRUAaY9oqDjMHFK7lLyHnyw0o3hBMjEcjVR5SISe4v4Lg3CeO+w9Uc2nwIqpo45/18h4YfvAQf8=
X-Received: by 2002:a2e:494a:0:b0:2c5:1a89:41c0 with SMTP id
 b10-20020a2e494a000000b002c51a8941c0mr21895988ljd.23.1699287372661; Mon, 06
 Nov 2023 08:16:12 -0800 (PST)
MIME-Version: 1.0
References: <1699251565-28759-1-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1699251565-28759-1-git-send-email-quic_zijuhu@quicinc.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 6 Nov 2023 11:16:02 -0500
Message-ID: <CABBYNZK6UNm9SWhmJtvp-bzObTk-UR7GhK2U16ffFEe-bdpOoA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Bluetooth: Support SCO offload for QCA2066
To:     Zijun Hu <quic_zijuhu@quicinc.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Nov 6, 2023 at 1:19=E2=80=AFAM Zijun Hu <quic_zijuhu@quicinc.com> w=
rote:
>
> This patch series are to support SCO offload for QCA2066, ALL BTHOST
> needs to do is specifying both Input_Data_Path and Output_Data_Path
> as 0x01 for HCI_Enhanced_Setup_Synchronous_Connection, does NOT need
> to configure data path by HCI_Configure_Data_Path at all.

This part it doesn't need to use HCI_Configure_Data_Path seems to be
non-standard, if so it needs to be handled by the driver, also it is
probably a good idea to explain how it works, what are the commands
used and the result traffic using btmon to collect the HCI trace.

> Zijun Hu (2):
>   Bluetooth: hci_conn: Check non NULL before calling
>     hdev->get_codec_config_data()
>   Bluetooth: qca: Support SCO offload for QCA2066
>
>  drivers/bluetooth/hci_qca.c | 19 +++++++++++++++++++
>  net/bluetooth/hci_conn.c    |  2 +-
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> --
> The Qualcomm Innovation Center
>


--=20
Luiz Augusto von Dentz
