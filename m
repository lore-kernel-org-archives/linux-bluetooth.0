Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FF2ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 00:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiH3AJf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 20:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH3AJe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 20:09:34 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CB28275A
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 17:09:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y29so5684329pfq.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 17:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=NbjExELLVmLI13UxhnagNm/vckO/Ybqa3sn007l7HT4=;
        b=RQNJIulAn/ULUdwP/cyP37GBqtq51TqFBfFd6CLAVpHDQEiVkeNz9ro6hMff63Nnk0
         IyUYBskyWvlreFiSQilsgActwG6QywNHsv6g1NgbrrhIlZ7TNosxITh8+AxX8oqiyEXs
         MC/uvwqhuJO3A2CiFzxZnn0iSERQ2W41xfBCEyfLTiLBFdBYDMfC498apTLD6TXgSKYf
         fO9rYEV49eUZ7CBgmBoPTSbotrOK1ynmrkMbeot96uXJ3fQRDfhdMoPLLlwYgODD0qWs
         tC0edK6xf+Z1HNAYcUqgbPJhC0WIP3LGEm+MO6nsqIDySbLPeV2SW75p5bJm6hAFhX5P
         7kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=NbjExELLVmLI13UxhnagNm/vckO/Ybqa3sn007l7HT4=;
        b=VN4RoODRmuHoHH0YLWVaZbv77oj6wHbXwu5JO/kMaixrhEOkoHHjgXLjdFDnSKtr4J
         sDwWmadf+wSShQMMzAYpdk+k7/8GkMjTj0srODAkwGPVaNAC53eeTC0J3r1Q2BWEhSey
         pziA1FspCqkPcklyNOz0PJEwrDJR2cQcOPk8+Qaq5mFqHEsEAJx7HSeQJcK0dbzsdQ9I
         JTZcXWL6nLCYBALTM4/LHZV0f9dWMCwtDLOfub4XvFhaRabddmjdmSylmmSSvppTSYAa
         m95lfHYa455Fr14EnFIt+XpmJs5jqF06y7RmXIoCV9+lINmD5KibmidcO/SxSVpx8gTu
         dxoA==
X-Gm-Message-State: ACgBeo1GVTorHmykaoDToBUmXzZbQRM9z9dBQHy73M1/OSJbPcC8sB6r
        XpRTprxo9PJaTO4TrG3RTUyTyJ0cRUEOgg==
X-Google-Smtp-Source: AA6agR6LEBZPrqYzOK2/mboOvlTE5YFaUObZW5yOaJCQMusfVDk41ovE+9ETMpFwoPTXWM6+fX9q0Q==
X-Received: by 2002:a63:5517:0:b0:42b:e763:3bc3 with SMTP id j23-20020a635517000000b0042be7633bc3mr8057401pgb.310.1661818172988;
        Mon, 29 Aug 2022 17:09:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.108.58])
        by smtp.gmail.com with ESMTPSA id t4-20020a17090ae50400b001fb350026f1sm7165337pjy.4.2022.08.29.17.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 17:09:32 -0700 (PDT)
Message-ID: <630d553c.170a0220.17747.c626@mx.google.com>
Date:   Mon, 29 Aug 2022 17:09:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4167219392799977871=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: Bluetooth: btusb: Add a new PID/VID 13d3/3578 for MT7921
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <575471871695aaae73ebc15eee73411ee53f4bb4.1661596165.git.objelf@gmail.com>
References: <575471871695aaae73ebc15eee73411ee53f4bb4.1661596165.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4167219392799977871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=672210

---Test result---

Test Summary:
CheckPatch                    PASS      1.40 seconds
GitLint                       PASS      0.53 seconds
SubjectPrefix                 PASS      0.32 seconds
BuildKernel                   PASS      44.61 seconds
BuildKernel32                 PASS      37.17 seconds
Incremental Build with patchesPASS      54.37 seconds
TestRunner: Setup             PASS      622.01 seconds
TestRunner: l2cap-tester      PASS      19.37 seconds
TestRunner: bnep-tester       PASS      7.46 seconds
TestRunner: mgmt-tester       PASS      120.04 seconds
TestRunner: rfcomm-tester     PASS      11.12 seconds
TestRunner: sco-tester        PASS      11.17 seconds
TestRunner: smp-tester        PASS      11.04 seconds
TestRunner: userchan-tester   PASS      7.79 seconds



---
Regards,
Linux Bluetooth


--===============4167219392799977871==--
