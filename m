Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3257DC32771
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Aug 2022 08:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347352AbiHSICH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Aug 2022 04:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347367AbiHSICC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Aug 2022 04:02:02 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BCCE42D1
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 01:02:02 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u9so4000441oiv.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 01:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=vIjtnwUfJdAvj+R3xwxKY5tjmCzNT3QdYdEk8R9S3oA=;
        b=Wr3Xi289rRAo7MFiQpUAyKIe0gZUng1+GMgqWSP/Vm4L+l/7kBFChp7Z2c9V+9t+Sp
         kvXgt4iU1eS69RAMPv+TBK3vcMAkMKeMG8xUxDMQQWbJK1kJVRK/1pjtQX/It2Rn9ICL
         0ysHCVPrXdzkm0TLvSMp+Mek7siI1RhRqDIS044qCC+vuNFdnHcQu77U2wbFvhHqLW+Z
         Sp3/EC9AF1IE6DPTnEUO1aL8jAQlVQGrxajnqXYaWYmnUU+euj+QV28B6izEULJmJsGb
         idgajmBPtpJA6qhVln6b+MI8XgLKN2+OEbKIwWJ7iTYPZgZpSADypfunm7mifSiZb2cs
         XT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=vIjtnwUfJdAvj+R3xwxKY5tjmCzNT3QdYdEk8R9S3oA=;
        b=dwmVFDdjszWCr729MrDHotAy091K7CsDSsnH6cytvJ+6fzA17+txAldhcrSOz8K1WT
         7AzI961HB8gYVbrqrTovFfd/vfMxz7LnYL5xDj0XYU6Xg/9pVxzpdrJoRQyxqfnfhvXC
         H8SYipi3fX+PLZIteGx88HbZoT7bLhlSv2ibciK/61M4i0xQFV4dQGWOmyRSsCpS6L9w
         g5ClV+kogZDRNsHah5PG0YnPD7BjYKR30u0HpIQHeNTD3EmG3zfjlMtltw+4gmyk1KyF
         Qa3OPPesr1hKT0rP4OyG887DfTet9ihHDV9hSgEXT87l5OYhu0CiFduZkpF/kXDzoA0a
         hqrQ==
X-Gm-Message-State: ACgBeo2Ggj+PN9A6UpBFOwl0eBINM612ZA15f7Gal2xHQKD5yGOSJndm
        luSBsSN1LWBWHzm56UET3xGxmLaakUo=
X-Google-Smtp-Source: AA6agR7YCXu1c1EG43MJCYXUDJr65B+jPiguTaVmoKGMd3zxqURhA0Ut+sJ+Gm63Ypv1GOVqR+4ySA==
X-Received: by 2002:a05:6808:2103:b0:343:2b03:959b with SMTP id r3-20020a056808210300b003432b03959bmr2929754oiw.229.1660896121277;
        Fri, 19 Aug 2022 01:02:01 -0700 (PDT)
Received: from [172.17.0.2] ([13.84.174.135])
        by smtp.gmail.com with ESMTPSA id w15-20020a056870338f00b00118281a1227sm1081305oae.39.2022.08.19.01.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:02:01 -0700 (PDT)
Message-ID: <62ff4379.050a0220.e43a9.4b34@mx.google.com>
Date:   Fri, 19 Aug 2022 01:02:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0925604000918532520=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: Add support for Magnetor
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220819074815.22016-1-kiran.k@intel.com>
References: <20220819074815.22016-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0925604000918532520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=669122

---Test result---

Test Summary:
CheckPatch                    PASS      1.17 seconds
GitLint                       PASS      0.70 seconds
SubjectPrefix                 PASS      0.61 seconds
BuildKernel                   PASS      34.06 seconds
BuildKernel32                 PASS      28.81 seconds
Incremental Build with patchesPASS      41.30 seconds
TestRunner: Setup             PASS      483.59 seconds
TestRunner: l2cap-tester      PASS      16.90 seconds
TestRunner: bnep-tester       PASS      6.17 seconds
TestRunner: mgmt-tester       PASS      100.31 seconds
TestRunner: rfcomm-tester     PASS      9.56 seconds
TestRunner: sco-tester        PASS      9.35 seconds
TestRunner: smp-tester        PASS      9.31 seconds
TestRunner: userchan-tester   PASS      6.37 seconds



---
Regards,
Linux Bluetooth


--===============0925604000918532520==--
