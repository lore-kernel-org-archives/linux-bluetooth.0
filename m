Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC6FEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 01:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjF0BEO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jun 2023 21:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjF0BEM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jun 2023 21:04:12 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC7A12E
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 18:04:07 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6348a8045a2so25711946d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 18:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687827846; x=1690419846;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TYmfyg0QZZtJLgrOM5uGoiWLkucTNvo+ZzPhPHCKQz0=;
        b=pt8VdLvAPIr4NIV6LYkVR5R/jCGv2iGoKxLztJeCcvX6Ninj5d4Z8fzHVkE2bcCLxw
         NELGsboV6FEfS036+dNgedH05qI/wbHhrdGKeG2dl5LmKf9aYfikyCg8c2z4U8ebMvoH
         O52gejDLB88fe75QfIw7TtXOG8qaUaCCvzq99kvyHgcH5r1dSDv3mSYCDoeQDfs3nlLw
         XbeO7BRg/7U8c9W8S9d3D3gTCwZYyQCW1GEPW8JxUVUaTXoEpdbWjWiPYC1rLSeA/IH2
         fbuaDRroKy+5d21en4DPR/+s6q4G0ZSmxuAJpu1qNLP7bWLKuhrCbrdKft+dZVRgfZNk
         xH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687827846; x=1690419846;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYmfyg0QZZtJLgrOM5uGoiWLkucTNvo+ZzPhPHCKQz0=;
        b=NgXYbdoI2q5OtKgodsAIdO7lojsLXbzh3kdcQMq8UnVIyYoDeD8c5ncb6zy5ncTXD6
         1riCbAz6Ca9rx6zVTXNzmPDpnnzF1T39Kj40hcKe5ACRmJbOjF0Lyqu8iNvFakDAa2hl
         IipHP4JmQck5tnyi2jgncSrix0qu7A+WreNSS3oKIEl8u8VWjTgPue6X8nO09G7+YuWp
         YTnolO/2ED/KipG+jAxtIIp19RSSnNFSrpOrtamd6Kv6dRsTrHkY+UmfRq2Z3rMtteWE
         6D6p3s7j77WtsVRvrPmUUzhYB49YxWkih6ZWp8YblnbljbN9EaFNsNyOYagmAbPufTxA
         xC+w==
X-Gm-Message-State: AC+VfDzZkY9ne7o3Pax0vxp0VFofQdHBw6SOk3CQSgELU/O4cBXSwyO6
        nZW4XZiMpib2zPygoh0jT51Ksz9R6UQ=
X-Google-Smtp-Source: ACHHUZ6TFgGdbN/DVS0nY/pYOXbFbTSKKuoOHLxedhMCPOhysWGILF4vbvLk3A+OGOtjVYYbjy9WOw==
X-Received: by 2002:a05:6214:2242:b0:626:1adb:e10b with SMTP id c2-20020a056214224200b006261adbe10bmr36666811qvc.13.1687827845861;
        Mon, 26 Jun 2023 18:04:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.37.31])
        by smtp.gmail.com with ESMTPSA id r17-20020a05620a03d100b0076087149a19sm3251148qkm.83.2023.06.26.18.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 18:04:05 -0700 (PDT)
Message-ID: <649a3585.050a0220.8f0c5.6905@mx.google.com>
Date:   Mon, 26 Jun 2023 18:04:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1106576090823113236=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v5] Bluetooth: hci_event: Fix parsing of CIS Established Event
In-Reply-To: <20230627003142.2274828-1-luiz.dentz@gmail.com>
References: <20230627003142.2274828-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1106576090823113236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_event.c:6822
error: net/bluetooth/hci_event.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1106576090823113236==--
