Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EB8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Mar 2022 00:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbiCOAQh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 20:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiCOAQf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 20:16:35 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818EC4131B
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 17:15:25 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id h2so12822811pfh.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 17:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=P0bRXywVvJpi0XQYqM59iV86C/3j8BxdqLwPIcUg3Zo=;
        b=LSwfozPAT/YERnLspx/7toOEmhRQzvQOxC8Ft/2APPefrJ32qv+mOb6MPscKxnY5xP
         0iZhYU2nxwOUU9vTYFi2o5USX2su0dmbsYaInr3z3dJQgmmX9eFdOrUg0C341cvhLKwU
         Qx4JemupQswF0PHTllqkUEjDkSJao7zIlyV4qv9F9MVozbKbCCFyOg2Z7yraprD4ecEq
         AfA5J2rMO0o3hXFnYigUaIFTYglfISaKr28wWROuyn1dFFHRT293LMwMB/aQK24+S8ZQ
         mjRTN1Gd8bC9/NsMw5Lm95lEuCS5FSrNMNlFhhNLQ0zxssmaZ4M02ohdQ/O8q07R696z
         SM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=P0bRXywVvJpi0XQYqM59iV86C/3j8BxdqLwPIcUg3Zo=;
        b=Ol8c7o0xo2lphM7eEW3GgPnJjbYOcf5hsFcDXentt6UWM7swrfEq4FV6ab2IoiC/GY
         uh0JHwuQYOl7M/77Q5gihLAXIxJ63coIdUl68DiFkm86lrj5lM1REUfRh8vOgbfErG7E
         /yT50yGfs/Brt7UPcRq8oOfJxlZya2lGVrROis5c065LmyDkI+GcBLex4XDAQ10FVmGe
         cCChiClYvKQNcEfLe/gy4lObf06XqSXn9C0og0ehvinmcTApeoLiATdpisIRNQ8CSAfA
         9lJjyfraONYCkheV+wdGwQOB/ySzc0PsFsvyrMksuNqm2ElzCKeA2b7QcNr9MZltd+1l
         UBjQ==
X-Gm-Message-State: AOAM532/vf+oNkx5QjquK6Tjq/N1VZtdV1IQv3ype37xZQXot3985WO3
        d7VebekkYSYgm5HG2K5/DsrTm5vPeeE=
X-Google-Smtp-Source: ABdhPJyhDgV0p116jHUfWefNAq8znOgZ6J/P+q2zU8QvuGbS7/wui0AaffCxLyfE6MW3ovEP0+xuEA==
X-Received: by 2002:a63:7d04:0:b0:378:fb34:5162 with SMTP id y4-20020a637d04000000b00378fb345162mr22210362pgc.487.1647303324682;
        Mon, 14 Mar 2022 17:15:24 -0700 (PDT)
Received: from [172.17.0.2] ([52.160.98.84])
        by smtp.gmail.com with ESMTPSA id 18-20020a17090a001200b001c6320f8581sm503092pja.31.2022.03.14.17.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 17:15:24 -0700 (PDT)
Message-ID: <622fda9c.1c69fb81.91a3a.2164@mx.google.com>
Date:   Mon, 14 Mar 2022 17:15:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8415091204037560382=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] gatt: Print error if gatt_db_attribut_notify fails
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220314215010.23822-1-luiz.dentz@gmail.com>
References: <20220314215010.23822-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8415091204037560382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=623328

---Test result---

Test Summary:
CheckPatch                    PASS      1.36 seconds
GitLint                       PASS      0.91 seconds
Prep - Setup ELL              PASS      49.35 seconds
Build - Prep                  PASS      0.52 seconds
Build - Configure             PASS      9.55 seconds
Build - Make                  PASS      1419.91 seconds
Make Check                    PASS      12.00 seconds
Make Check w/Valgrind         PASS      510.87 seconds
Make Distcheck                PASS      265.65 seconds
Build w/ext ELL - Configure   PASS      9.87 seconds
Build w/ext ELL - Make        PASS      1390.20 seconds
Incremental Build with patchesPASS      2873.48 seconds



---
Regards,
Linux Bluetooth


--===============8415091204037560382==--
