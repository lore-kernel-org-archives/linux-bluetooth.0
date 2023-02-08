Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4455DC05027
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Feb 2023 10:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjBHKgM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Feb 2023 05:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjBHKgI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Feb 2023 05:36:08 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248DA4859E
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Feb 2023 02:35:46 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e204so6779287iof.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Feb 2023 02:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nPWVcGLa3bZxE+lw7mX9Kj5qHbydwbWOrF8CCuHrVuo=;
        b=TWL5evY03XbfjrQUXUA7S/VXmzyYLJjX9PFrrHOqVCzZXFhqhs/R6t7VrOhNKR/7CX
         1/1lj4JRVuF6YvkHui5C8aew3tOGncE41fkXMVcq1IHFzlsVWhSZ7NmsSfpPZCehFcAG
         YUYLkONd4kNtQ/JQ0tV1PCSXnr6Kfpq9TzoFFfrTrt7vzpydldrQp0NI4tdHyRMoMYLn
         z4DkORVZ4aa0of1qRFMNEelOejx72VBpDkJ0XyGxO037bEFJ6+0XNgbzcRNW6ibzYL+K
         aRBavgScZz+9ozSvMZnA+aslY7OhxJqRJJ/TTK9XeG7RX0uyEELwGG5m9g1Bj89A0fLY
         v3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPWVcGLa3bZxE+lw7mX9Kj5qHbydwbWOrF8CCuHrVuo=;
        b=j9oGKlQ94F8G+L7HQJuzMutW/GXRa+Lj8CGi6wuOopVg1qXhauES77QgmnqH1y4jH8
         uIiNjk6rh2vRbFBiAVt5LLLvpDox2IYIjEbB8z4zvGFXuOi6qqTqYluLupbSCfI6ocoe
         pAr2STdVOOSrF0yefIlaEtBS8mSUeIGqKQGyKWavQ92fsK3H6uDLt2erRCYYFAw5rz04
         LfR4qe8z6pJc3X330X/JMmzOmVs3rVA4GPYtnBAg9xunclwkIEh5U/PYwIOd3lHL3YPZ
         /63vYgsfcwk9jUSp3HYk/0pwmyPBcP8/l69qcRN33D5K+znw1/TBPXHu3ei1YSuFvU5G
         wRLQ==
X-Gm-Message-State: AO0yUKW6f/TSyAB/hJtSxp917tSUqqLtfD4lh5E1CA2dykwQ9+G9rfdt
        eARpH2TQspTdaTyiTpDSppOItaiGlZ4=
X-Google-Smtp-Source: AK7set8mqFie0aHo1Br/4mIhPpg8/4f46S4QG2DQlAWFoT5F1Gw+S7yTvBpd6GOqgJxG5+4AOXZlYg==
X-Received: by 2002:a05:6602:3292:b0:6e5:25a2:c63d with SMTP id d18-20020a056602329200b006e525a2c63dmr5230443ioz.21.1675852545047;
        Wed, 08 Feb 2023 02:35:45 -0800 (PST)
Received: from [172.17.0.2] ([40.77.92.115])
        by smtp.gmail.com with ESMTPSA id y14-20020a05663824ce00b003b443977af0sm5241779jat.7.2023.02.08.02.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 02:35:44 -0800 (PST)
Message-ID: <63e37b00.050a0220.29677.c489@mx.google.com>
Date:   Wed, 08 Feb 2023 02:35:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1561465228630630147=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: [v1] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
In-Reply-To: <20230208094038.13670-1-quic_tjiang@quicinc.com>
References: <20230208094038.13670-1-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1561465228630630147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=719878

---Test result---

Test Summary:
CheckPatch                    FAIL      1.55 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      31.36 seconds
CheckAllWarning               PASS      34.50 seconds
CheckSparse                   WARNING   38.42 seconds
CheckSmatch                   PASS      107.08 seconds
BuildKernel32                 PASS      29.93 seconds
TestRunnerSetup               PASS      433.09 seconds
TestRunner_l2cap-tester       PASS      16.29 seconds
TestRunner_iso-tester         PASS      16.63 seconds
TestRunner_bnep-tester        PASS      5.41 seconds
TestRunner_mgmt-tester        PASS      109.34 seconds
TestRunner_rfcomm-tester      PASS      8.78 seconds
TestRunner_sco-tester         PASS      8.01 seconds
TestRunner_ioctl-tester       PASS      9.36 seconds
TestRunner_mesh-tester        PASS      6.88 seconds
TestRunner_smp-tester         PASS      7.94 seconds
TestRunner_userchan-tester    PASS      5.67 seconds
IncrementalBuild              PASS      28.19 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
WARNING: DT compatible string "qcom,qca2066-bt" appears un-documented -- check ./Documentation/devicetree/bindings/
#271: FILE: drivers/bluetooth/hci_qca.c:2324:
+	{ .compatible = "qcom,qca2066-bt", .data = &qca_soc_data_qca2066},

total: 0 errors, 1 warnings, 153 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13132788.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btqca.c:637:17: warning: restricted __le32 degrades to integerdrivers/bluetooth/btqca.c:720:24: warning: restricted __le32 degrades to integer


---
Regards,
Linux Bluetooth


--===============1561465228630630147==--
