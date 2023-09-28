Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0058CE7B0F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 08:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjI1Iox (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 04:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjI1Ios (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 04:44:48 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D471AC
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 01:44:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso9695904b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 01:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695890687; x=1696495487; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9ceCtGLjtYq8+gnPMgru6KiXADMn1D6xQ0hi02hQ2/4=;
        b=KTFJBR0Eqxx7w5KwX0XrSbmmV2b+neJqFtuA27vKgyrmmnojNFLKHZh2Xy55RAwpRK
         9fgw15pvOEG7JzyEkoiZ/v1n58D86T+UVMMAeZiRrcFJmnfeRZw5qPNRKgeyCfAhJXJC
         Q90+7QNXGIpdll9vzDiBTUU+jyQxlltaH/FP+U1c/oq+J+tMnNT43ikzHXuJVvxLcHNr
         hn6Ex6AVToa2MPiVfrELcbKkzLJ7a7RSH9mjxbFbTe3YawDqiPVmkN/r9tYxx3SruVMz
         ajpNmVc6lB63nKehJlzABOeIJpdNVYqnjm7w99W3sdku3q5qi0lDrZk8+ELSB0qzcAns
         1r3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695890687; x=1696495487;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ceCtGLjtYq8+gnPMgru6KiXADMn1D6xQ0hi02hQ2/4=;
        b=CaQgH8YEBfpk3uiDTeyGX2TSYOXTMrRM/ATHhdDs/WJWz+Q1mPwvpQF+IN09h3vXq5
         4865UvW0dO8qqnI2LoVAB8yV+OaX/aPOcun15y53ODsw5jGZUEfN2bsH6qkCEZQ5TPdu
         y5JDN0depL5tWPnQ0rwREzK30rkZ/mMpa4STygFjfssPNis2AW7UZ1ndij+JVNlt+ku3
         TAK8mZ4aQgK0nzspzqW5NwIWObhWFOK7L7YJskU6BTR3r4XtyhxHddmin3NvnPGANxKN
         XRS4i6m69v+ZwiKpi5yCVWQbXPGFCw/gV5VHFm4gZFS79E3RPNi4L53ps7VCllNlB2A/
         sSRw==
X-Gm-Message-State: AOJu0Yz6qsAVp5PlQWt5WVpglc+DUcD6LL+vnexy5LRYWxshFuQtb1re
        TRbz0CgiItisO2kikXztjlh1DCeIWaY=
X-Google-Smtp-Source: AGHT+IEhgsfWd2saf0STZaRmU/61D2bJuCLcavRjuehDbsN1/eRdfjvT4tbWxDWHIlb1ZHXeLRkVEQ==
X-Received: by 2002:a05:6a00:4a09:b0:68e:2c2a:aa1d with SMTP id do9-20020a056a004a0900b0068e2c2aaa1dmr742118pfb.11.1695890686663;
        Thu, 28 Sep 2023 01:44:46 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.162.52])
        by smtp.gmail.com with ESMTPSA id fe18-20020a056a002f1200b0069102aa1918sm12969135pfb.48.2023.09.28.01.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:44:46 -0700 (PDT)
Message-ID: <65153cfe.050a0220.74eaf.4e3a@mx.google.com>
Date:   Thu, 28 Sep 2023 01:44:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6044713305127549953=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID
In-Reply-To: <20230928080208.5517-2-claudia.rosu@nxp.com>
References: <20230928080208.5517-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6044713305127549953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=788382

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      40.58 seconds
CheckAllWarning               PASS      44.55 seconds
CheckSparse                   PASS      50.68 seconds
CheckSmatch                   PASS      135.91 seconds
BuildKernel32                 PASS      39.58 seconds
TestRunnerSetup               PASS      594.11 seconds
TestRunner_l2cap-tester       PASS      35.07 seconds
TestRunner_iso-tester         PASS      68.93 seconds
TestRunner_bnep-tester        PASS      12.57 seconds
TestRunner_mgmt-tester        PASS      251.29 seconds
TestRunner_rfcomm-tester      PASS      18.89 seconds
TestRunner_sco-tester         PASS      21.87 seconds
TestRunner_ioctl-tester       PASS      21.58 seconds
TestRunner_mesh-tester        PASS      15.72 seconds
TestRunner_smp-tester         PASS      16.76 seconds
TestRunner_userchan-tester    PASS      13.24 seconds
IncrementalBuild              PASS      36.76 seconds



---
Regards,
Linux Bluetooth


--===============6044713305127549953==--
