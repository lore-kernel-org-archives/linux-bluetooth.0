Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BDDC001DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 00:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjHDAv4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Aug 2023 20:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHDAvy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Aug 2023 20:51:54 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DBA18B
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Aug 2023 17:51:52 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40fbf360a9cso11712751cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Aug 2023 17:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691110311; x=1691715111;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eir6AZuAHqPT5rm3D5S9vI3lutq56l29pJd1mSKtiAA=;
        b=sJ/DTa2YbjVSQUPPczyj6F/2qXmM/0/tiFpXOrI7DjvG1YMCzqb9Qhs28eupxpeaDI
         xueETaj+IWUMvGBDl+vpAvLH4coHgCtgBrLpH4RrPonfyAK5LrdPHf1A0G67XZ6Y7dpP
         1MicwIFwr9j/VIY2n9C5vn4KDZdsMBvWYWficLe9jktK97ep/la5N4V1asfxq7DfIptw
         ZoJ7uN21eTgE7nzoltVAKWbyR9DCSRl/GYC7iwznr07xPd4c7qUa+8B00ag2TQHwema3
         Yjce/zU662B2/Z+zMgp+TxHjGNjODdgDCNvgYECIa93lcvW/kwWVfo4ngsxrx0kp8eTJ
         ABug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691110311; x=1691715111;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eir6AZuAHqPT5rm3D5S9vI3lutq56l29pJd1mSKtiAA=;
        b=cbD7QdnE04D2wmL14ysxhLvH725LfH+j07DGq2p4fBWdPmMzc3Mm+NMLKL5K7SSKoo
         0/1ExochZcTxobWF/QhloK0nBfhP96+CWzTHMvuarsTLob3k91kWnbkCw3IRLyyVmHSY
         IZ8DaogbhFzg2wOYhefz/MmvsmowmvneLsBC4xAef+2tQk8/MQfFeiDf/qK8P/vMQAW9
         mUHjF998XUL8kRBbh1PwLFhZ0QqtewFWc3paDudORtu0cShGxOnb1hBlxdfQevyy9u8a
         Zh/6Gp/B6IOrGSus56lxdE5G0FE7OWZwB2Dw9FFJGE25KfdQnkEk7cR6cDLZ0Lkfqn1w
         rJrg==
X-Gm-Message-State: AOJu0YxxKASdSzZeNCtTAondR1YxawwrW/P5tBPtE/OuRnR9xyap3TmJ
        Rr/Af7gRpbkNlJTurVXLELW85i8jzKE=
X-Google-Smtp-Source: AGHT+IFFqTgUyH9mWtsUitpq5G17vZTAqs66HY32qK6f6VGxKcUcc/vtu/C3Z1ig3SOhCgSmt9nCbQ==
X-Received: by 2002:ac8:5f90:0:b0:403:e958:b456 with SMTP id j16-20020ac85f90000000b00403e958b456mr437584qta.19.1691110311233;
        Thu, 03 Aug 2023 17:51:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.76.123])
        by smtp.gmail.com with ESMTPSA id z13-20020ac875cd000000b00403bf34266csm305971qtq.30.2023.08.03.17.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 17:51:50 -0700 (PDT)
Message-ID: <64cc4ba6.c80a0220.86838.1fe5@mx.google.com>
Date:   Thu, 03 Aug 2023 17:51:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7424869268426980819=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/5] Bluetooth: hci_sync: Fix handling of HCI_OP_CREATE_CONN_CANCEL
In-Reply-To: <20230804001115.907885-1-luiz.dentz@gmail.com>
References: <20230804001115.907885-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7424869268426980819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sync.c:5389
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7424869268426980819==--
