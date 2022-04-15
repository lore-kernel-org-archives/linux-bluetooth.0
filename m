Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B878CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 06:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbiDOGFq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 02:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbiDOGFo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 02:05:44 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F32A8ED3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Apr 2022 23:03:16 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id e10so6085497qka.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Apr 2022 23:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ImSbcf6qenKpb4pp3gYHEjrVCY4pBE9q2+GOmyq0kjc=;
        b=P0vWufb0sC3n89OXD6rfWYqIzb21YWr8Y7xFu1NWodE9ww/JXlVjFy3nQWp9cbCDfa
         /DQ+bkiwSVi9GMPvlrVKktMoTYYgtHL7NxflgobItHvLEvFMELy/ZtT5hCJuHm+x4jKS
         UJDAtdAPdaUgw7+v6pgjUSka8zuigGVEmT1dA+mA+0hXD08/4+p6UtAXmiGXDiOKG7NZ
         zo15VVlqIDCPi2sYaN1owTumhtjdMTFi+M+frZ6hifGPIChXv10bYqNLSKbCeu1xJ1/Q
         D0KTf7aOzm3WmxWQ6zYUOvydLUr+YVr3JICsTwPZIxkux9+krhrZ7HIhHGgcpu1G6RIp
         f9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ImSbcf6qenKpb4pp3gYHEjrVCY4pBE9q2+GOmyq0kjc=;
        b=0O1tIn8VpfgjQWVBk2X9SpzEtSuRW+BJzHYKk3FmpX1r/XBsfd18Qkm1C2Yn26KcUa
         +orWZJeiWt5fPrp8leqbrvoeN9fC/QpL2dl1rnoN2N49cFRZnnnpZJ5SS/4inYQAYTFh
         h0YsRGopfJzKzcqGDXGIk8J9apa+Qkose2vjCv48AqXzp9zw9oTMLiGO0ee+JSPQhE2J
         gwmWWKlPje+RyW6qXl6kqKQpjx6E443ol6pXa7KBsDmb1k1a5GqOxHli73z5JDqQXKNk
         wvKKVUn+2aNNL5qAyDDrnKBHqWBJpU5oxiVt5JqDMqCAs1xvVu18d92Mo05N/0EwMlcr
         xEMw==
X-Gm-Message-State: AOAM530FCS6Spv2wmpLzS2Ly/dyz1/QtPkgwurDdN/7tER2E3l7ayOBl
        JjLzmuCsOZMrcKWkix2EXHQ+DDrc1mwY3w==
X-Google-Smtp-Source: ABdhPJyCxeli+cWSk2jljeMM0MBfF9Lrfq3YDoaEl4RiHAZB14NRkFdMrO0jgJLdsMGFJj7PysVKjw==
X-Received: by 2002:a05:620a:2946:b0:699:c582:f319 with SMTP id n6-20020a05620a294600b00699c582f319mr4544856qkp.118.1650002595345;
        Thu, 14 Apr 2022 23:03:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.96.32.148])
        by smtp.gmail.com with ESMTPSA id u5-20020a05622a198500b002f1f02b7465sm35219qtc.17.2022.04.14.23.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 23:03:15 -0700 (PDT)
Message-ID: <62590aa3.1c69fb81.b5e2e.01f8@mx.google.com>
Date:   Thu, 14 Apr 2022 23:03:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0674114316412027762=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ismael@iodev.co.uk
Subject: RE: Bluetooth: btusb: Add 0x0bda:0x8771 Realtek 8761BUV devices
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220413125415.20293-1-ismael@iodev.co.uk>
References: <20220413125415.20293-1-ismael@iodev.co.uk>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0674114316412027762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=631879

---Test result---

Test Summary:
CheckPatch                    PASS      1.56 seconds
GitLint                       PASS      1.01 seconds
SubjectPrefix                 PASS      0.83 seconds
BuildKernel                   PASS      32.14 seconds
BuildKernel32                 PASS      28.58 seconds
Incremental Build with patchesPASS      40.22 seconds
TestRunner: Setup             PASS      473.15 seconds
TestRunner: l2cap-tester      PASS      16.01 seconds
TestRunner: bnep-tester       PASS      6.47 seconds
TestRunner: mgmt-tester       PASS      107.67 seconds
TestRunner: rfcomm-tester     PASS      8.18 seconds
TestRunner: sco-tester        PASS      7.99 seconds
TestRunner: smp-tester        PASS      7.93 seconds
TestRunner: userchan-tester   PASS      6.60 seconds



---
Regards,
Linux Bluetooth


--===============0674114316412027762==--
