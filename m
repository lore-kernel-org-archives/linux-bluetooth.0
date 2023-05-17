Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49423C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 May 2023 11:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjEQLfF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 May 2023 07:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjEQLeu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 May 2023 07:34:50 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4184B5246
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 04:34:43 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae4e49727eso7921455ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 04:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684323282; x=1686915282;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Jawsv804WhTV39aoKEjkX2n0F8yFjViYz/3PMnHCvzo=;
        b=PBx+P4SKez+pFE34/iDrXE0uTXYSyy5Ij3DT+hSnh3zM+ZdNK9zL9XiJp5uhJmccCK
         1uq1n9YhfWI9rP9AFn+NKWTN4xsi70yhysBLlOws5eRLSUnQEjzkta7eTGBZKDXuMMZ8
         CQ3tFDxfJ6MbNc2Qo1zqcl7tC8WYVsctRLE3e+l6EngnHhjxnO2bNkaE8UajLhWK9kbx
         U7kgWqEInmppmrzvvkY34/+sbs+QEAo2LTrnqmNlFJ9a1Ga70ydF67G2DM1iqpl6drtP
         tADSzlPGn4DP0iCsvbBNEXA4SFou4dj8VSQu0lPtJjWCe7EQwUBsuYYXYHcg6cExbbof
         oUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684323282; x=1686915282;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jawsv804WhTV39aoKEjkX2n0F8yFjViYz/3PMnHCvzo=;
        b=e/fCDu7ptVCnSXrkg5r3ynjVrxDgU9R1LjMJtcMhW1f+w6kIpfUoM1tYArR//m49Hj
         M52AR7plrZfkgHgXVmN18uSmE2ZvgbzbnzoN/suB/VhLL7XRIud3IzDhrJqQzm7yf/Q1
         mgPsxIVfifi7c3N18vhYMLEaHYB0CQD0sZufsYSdweyTMj3kIBYEFukUJybHpRDzDmRc
         +jehM6C2vaPtdAJbjCoivxHRjDJf5RmJaX8WIQwrrfSPQ51sCT9rQElTZEZ1OhMFuJcT
         KpONWKu+002P6v5BMRPnovd3dGl1s77YR0ue6JxBF3WUp+Yus9Orp3MKdPQCYaeC0gWQ
         XHgQ==
X-Gm-Message-State: AC+VfDybTFJXuLjZD1H4jXNDGt/0H5ylw5CeKa29Kz88a6YDZbmDeWWp
        Izad6zg32DXKwEwVhka/MVK3e++7qGk=
X-Google-Smtp-Source: ACHHUZ7Xag3Nker2AUSfEbOPEaM+QWfU54RBSaa6FN4YfU6OMiJ5cmjvbVUc9hGtJYPlk+bjljpPfA==
X-Received: by 2002:a17:902:db08:b0:1ad:e198:c4f2 with SMTP id m8-20020a170902db0800b001ade198c4f2mr23100566plx.18.1684323282241;
        Wed, 17 May 2023 04:34:42 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.14.130])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902728d00b001a217a7a11csm14282148pll.131.2023.05.17.04.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:34:42 -0700 (PDT)
Message-ID: <6464bbd2.170a0220.728d9.b2ae@mx.google.com>
Date:   Wed, 17 May 2023 04:34:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7156402454557268547=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: [v4] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
In-Reply-To: <20230517104426.14055-1-quic_tjiang@quicinc.com>
References: <20230517104426.14055-1-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7156402454557268547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=748375

---Test result---

Test Summary:
CheckPatch                    FAIL      1.56 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      39.34 seconds
CheckAllWarning               PASS      43.29 seconds
CheckSparse                   WARNING   48.95 seconds
CheckSmatch                   PASS      132.11 seconds
BuildKernel32                 PASS      38.76 seconds
TestRunnerSetup               PASS      542.27 seconds
TestRunner_l2cap-tester       PASS      19.88 seconds
TestRunner_iso-tester         PASS      25.41 seconds
TestRunner_bnep-tester        PASS      6.78 seconds
TestRunner_mgmt-tester        PASS      132.31 seconds
TestRunner_rfcomm-tester      PASS      10.57 seconds
TestRunner_sco-tester         PASS      9.79 seconds
TestRunner_ioctl-tester       PASS      11.54 seconds
TestRunner_mesh-tester        PASS      8.51 seconds
TestRunner_smp-tester         PASS      9.73 seconds
TestRunner_userchan-tester    PASS      7.21 seconds
IncrementalBuild              PASS      36.58 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
WARNING: DT compatible string "qcom,qca2066-bt" appears un-documented -- check ./Documentation/devicetree/bindings/
#279: FILE: drivers/bluetooth/hci_qca.c:2372:
+	{ .compatible = "qcom,qca2066-bt", .data = &qca_soc_data_qca2066},

total: 0 errors, 1 warnings, 160 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13244615.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btqca.c:629:17: warning: restricted __le32 degrades to integerdrivers/bluetooth/btqca.c:712:24: warning: restricted __le32 degrades to integer


---
Regards,
Linux Bluetooth


--===============7156402454557268547==--
