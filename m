Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57980C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 22:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCWWgV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 18:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCWWgU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 18:36:20 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5357627D68
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 15:36:19 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id l7so547743qvh.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 15:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679610978;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xwdl7jVI+duMok/1FLFXeX11Lbl29g9D9qeDWD1bMjc=;
        b=hq8ChdRVRIiA/kQ17DVNEH3UeYCS0N9nGEDlmqjFPhvwkrj0Nf+8CsRb54DMUmp1j6
         tFrua31AbuhvS9v5XrJCSAWlQEVKTIP5P3G1jMavThqhrk4XiZSaCnbRQ7ncwBfs7ZoS
         J+1HMt0mTTSIiILlknPOqnqna7VziCnZTf6rLpcSbS+W7pYQxRHtkVUlex5i1PcqKYy1
         +sKwEIwt9AInAJbOPMq87TmbYkHzdjoaCNYRgMN+mUwmiCykaMtIagFqgpdITiEL64y5
         PeJAL2bUrmPwBDJbQnPBviWx54iIWnMcxsqsdx+hSdtLEAD/Knyx+jM7DfweZd00C1cw
         lR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679610978;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwdl7jVI+duMok/1FLFXeX11Lbl29g9D9qeDWD1bMjc=;
        b=1KqeOTij+WTbSkUn6dF3tBXZ2HT/Ozi0HWDQINK7GP/S5oMAv0a/xPT/l+DPxWvvhD
         hkDJ1tixWiy+zpdsMkmaSJrmCzMJg/npdtsfYTtDNa9e682E59dgmAfNeGZkbpRwhBnu
         ga4c+vwVG2Q0EuxYZc7qdZzxWd92+Nk17+rvJxvyXcHjlZH4gyUV1EcLqdpgPLULtgRX
         O3B/mYsSvwhholb2sYX8o4RgjmQFZZmximJ2BbadSlR3hMLINIC1OdKfEB9WaFYTBSE+
         iEjz1TgKQfSwnkTTedxow1xJ0VYgkmYrJgHwEsNdww/bAJM/rvZDH+kjcDetthsK+Fk3
         J25g==
X-Gm-Message-State: AAQBX9cWeQgUNh6odRfCPxIR8TTBn+o3JyuZyyU/gI6jz5clhNDSF65N
        WqgaT7p9LExWsUNNewNWI8+lRjTIew4=
X-Google-Smtp-Source: AKy350bVh6DCztwtyaX6rGDkbNJxKF0Hn7L+KeiTwOuTrt0gp2hTfwb5kJ/8NzgxEJKrcxrSigHvAw==
X-Received: by 2002:a05:6214:c25:b0:5d9:a36d:3ed1 with SMTP id a5-20020a0562140c2500b005d9a36d3ed1mr823421qvd.39.1679610978222;
        Thu, 23 Mar 2023 15:36:18 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.193.177])
        by smtp.gmail.com with ESMTPSA id eh13-20020a056214186d00b005dd8b9345fasm201941qvb.146.2023.03.23.15.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 15:36:17 -0700 (PDT)
Message-ID: <641cd461.050a0220.c4c4.1137@mx.google.com>
Date:   Thu, 23 Mar 2023 15:36:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7779825648020031325=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jay.foster@systech.com
Subject: RE: [BlueZ] btmgmt: Fix typo in command help text
In-Reply-To: <cdb725d7-57e3-1759-6a4a-53a01dc8cd8b@systech.com>
References: <cdb725d7-57e3-1759-6a4a-53a01dc8cd8b@systech.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7779825648020031325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7779825648020031325==--
