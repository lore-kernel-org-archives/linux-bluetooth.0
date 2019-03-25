Return-Path: <SRS0=CZwu=R4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7095FC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 12:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEC720850
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 12:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkWiKzkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbfCYMDI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:03:08 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:41299 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730653AbfCYMDI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Mar 2019 08:03:08 -0400
Received: by mail-vs1-f43.google.com with SMTP id g187so5175888vsc.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2019 05:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=i4Bm3xhFpT51ClzruRyIh+xl4cgRxLuiGnDJqFP6klk=;
        b=QkWiKzkN/bZDf43fss2Dfw5ujVOqiHc9IQ9NtI7r7pcj6t3dFj5pTyaU5g1kq/2uks
         ejEOMU3paVSjDS//e1Lr79wowoatrU6m1sP59YODZ/bOAvJ2ANt4k/1dVZy4/tWqJ/qn
         PMLHe+zWarle4L48oBuwRxGuTY2k+ViaEZ4AbAPJpZ+ucleDAdRgQ1TLulHJHnYaMlOi
         d6rOCvqJPlGGe1hWmaGQGV1DnIs7RMA/2zNlSy+VQAqts+wqw82qYHUnzR88F5ayhgIF
         DOjboo0wKdYQP77boN9Z9wkuvbSRLGwcFKSgPilYXQEW+nyPg8GLGiCwAgOgeO/BhKVe
         jXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=i4Bm3xhFpT51ClzruRyIh+xl4cgRxLuiGnDJqFP6klk=;
        b=AUEH/w4AauxJIDR64erLT+sggBdvb4YfotitLNVUVJz9F1dCkpKQBPH0TEbsCtDvvK
         wUAWFMo7ZpzayDkNMxEK+p33FN1vfWimz1jVi9mYI6rQz6WIF4sNinDd9GXgURWWIY9X
         uHvh+OvEns7+7nifJbMxT7zdoejQNLoPC716PM5shP2Q9r/xsM+Wn36G9kzA7Yu7Yb8u
         EmAHAHlrNwPSsAf0Q6k3dVjrjQI1zQRjGlP3bwjKvQd/wFmNLPJVjL9mtBj+Y8v6RwGk
         XRawhWkAb06+xi9rG79qfoo0kwfr6POkgdAO6PtWMfwncKqkybQXtw80wQApZV4eDuBS
         lqJw==
X-Gm-Message-State: APjAAAUJYKgHqiDRvmtRKq+X4XNNpx6d+cg2lo5owU1qawORZ6dkO6mp
        PhEAkJgISZXf2DXCkF5bY1XQvwiPjkk/LExxQtZRWLxC
X-Google-Smtp-Source: APXvYqws8+PSQfaGgSUXOfwb0+xCOFRau5NIG0Xxe6qxDR/FEJyPs8cyHdNCQe5Xe8rEFOJnZFh4EROwr0o+T7spAgk=
X-Received: by 2002:a67:e3d1:: with SMTP id k17mr249641vsm.86.1553515387438;
 Mon, 25 Mar 2019 05:03:07 -0700 (PDT)
MIME-Version: 1.0
From:   Alexandre Augusto <alexandre.a.giron@gmail.com>
Date:   Mon, 25 Mar 2019 09:02:56 -0300
Message-ID: <CABLzjm-SLs_AzgS2S=3ogN=P9Jk9OjBuSMaNFTpXawrAsNfe+g@mail.gmail.com>
Subject: Information about HCI LE Rand command
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I would like to know, if possible, information about the bluez LE Rand
command (ocf 0x0018) at HCI code. How does it generate the number? Is
it vendor-specific (or secret)?
