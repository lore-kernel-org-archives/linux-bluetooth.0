Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA2DC7618E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Apr 2023 09:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjDXJ6T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Apr 2023 05:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjDXJ6S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Apr 2023 05:58:18 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169D21FCF
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Apr 2023 02:58:17 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3ef69281e68so6556751cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Apr 2023 02:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682330296; x=1684922296;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VwYt2YKLHK7mfqFfyadomrc4UeXRsjn1evRKLrJZwmM=;
        b=iaxQandCx6I/KTyUHTtSmI36f1ENoBYPgsXXf2PPdU5utlmDfHVcGWvQ4dL4ylbJ0s
         ka9PwAMW+qwkG1mo9LtDc+D6w8hhkuAAanNEbnpBbc06qPMXkDs4extnKA8wc2KiWfkD
         pXVZXSKublpxl5xKdYpwg9uJJtsZr40o3O6qzFmrFhyfBdhr+6rQGpsM2PyflAmO7ysv
         qkhUlyZdAPvbGYAYc5cKWz0ipTdslHmudqbaP/zlcYnFlFcDN7lJxCFTaY5yXGQ4zURf
         aDhLMpcCXdclV3X/AfwoiqL4YYpKd7+6FVV2j8oCYp1cw0W0d2JGo21d/dMd+MKkiX8X
         tCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682330296; x=1684922296;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwYt2YKLHK7mfqFfyadomrc4UeXRsjn1evRKLrJZwmM=;
        b=AHR3cmKgHmRFFqUMtczmFE57LviHbt9YG8l9IiH9JOzTjJKs33eOdCDrmWDno+49AK
         ncMMaj6x7n0EE3aM7yc3x09JMSZVD7rZ2CcuWeCK/ahfJlXxqIR9h2MwGQ8IlZc31Uow
         tAYS3wlTeVaDhOMTt3Zl2Q9IRTqUUUb0QvystCXGJnkEG8M+Pn51EbtBRip6gkuuSS+/
         EXwlexx3tLEiU+TMM5fk8E+RkWT0gJgCCVIspjqxmYGjfE9vpkuXxDx+Go7QCtqJ/umE
         +vcBLpiyRdS1+zn63o5KVk4z4HE2a7COpEMxn0TdgZr52IXXWuGqMB3kw1mL5xK50JRE
         lZYw==
X-Gm-Message-State: AAQBX9cDaGNhu/P9bADkcfqYOew3srK2W1ZdDdm6ZvhHy5PpQLe+9A/S
        WzoK8SIMFnhSNsZ67gbt0c3QPY5skco0Tw==
X-Google-Smtp-Source: AKy350aB9Is7FDFhlR8xBZn90a5H8+ZXbfzIvfXRMxFzDEv75ztgOR+uCHaWZBKmOvLIjeLjuDpVrA==
X-Received: by 2002:a05:622a:1ba2:b0:3b8:6a92:c8d6 with SMTP id bp34-20020a05622a1ba200b003b86a92c8d6mr21688316qtb.60.1682330295781;
        Mon, 24 Apr 2023 02:58:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.44.101.1])
        by smtp.gmail.com with ESMTPSA id o16-20020ac872d0000000b003ef5ba0702fsm2732194qtp.7.2023.04.24.02.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 02:58:15 -0700 (PDT)
Message-ID: <644652b7.c80a0220.5715a.79a4@mx.google.com>
Date:   Mon, 24 Apr 2023 02:58:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3508479303627642850=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v3] Bluetooth: msft: Extended monitor tracking by address filter
In-Reply-To: <20230424091857.3652-1-hildawu@realtek.com>
References: <20230424091857.3652-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3508479303627642850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=742640

---Test result---

Test Summary:
CheckPatch                    PASS      1.57 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      33.24 seconds
CheckAllWarning               PASS      36.46 seconds
CheckSparse                   PASS      40.50 seconds
CheckSmatch                   PASS      110.23 seconds
BuildKernel32                 PASS      32.09 seconds
TestRunnerSetup               PASS      447.64 seconds
TestRunner_l2cap-tester       PASS      17.22 seconds
TestRunner_iso-tester         PASS      21.66 seconds
TestRunner_bnep-tester        PASS      5.68 seconds
TestRunner_mgmt-tester        PASS      117.79 seconds
TestRunner_rfcomm-tester      PASS      9.35 seconds
TestRunner_sco-tester         PASS      8.77 seconds
TestRunner_ioctl-tester       PASS      9.99 seconds
TestRunner_mesh-tester        PASS      7.31 seconds
TestRunner_smp-tester         PASS      8.48 seconds
TestRunner_userchan-tester    PASS      6.28 seconds
IncrementalBuild              PASS      32.53 seconds



---
Regards,
Linux Bluetooth


--===============3508479303627642850==--
