Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40654EB64D8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 09:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjFTJAX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 05:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjFTJAQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 05:00:16 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32C91984
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 02:00:09 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-38dec65ab50so3279078b6e.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687251609; x=1689843609;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P6H0MRXNIrPMMO+2t/2Rg0Dc5VN2Q075wwI9StE8bUE=;
        b=olnxzfhxB2YIKZYGleivTCmC6I2YRCRpZOlcZ9dt8f+IFBb4MF07BpWy1Qjandz4pc
         AkKf6arqgQ5aLyRtwFNIvaTtY9I+Rp2P7lcWD4oc39GK54c4PD6FDu6ePhjsomEY0axQ
         jnXL9QqyBbqSvD/WzsbdVM6Oguri14vWcqJZI78uKV0ZTzYd6lXKzBBUK/xS5602Xh8L
         URkpQkgtbH7TOGcTLV+LCo2dFEZwLQvUq98vMMEsmc/YqvmQ4y778sn7nTq8S/F/7wq1
         ZJn7ZzMZWXzi0yaI18YfBzQX5wcCgmnhvZdI0XWLHQxrYQzhFuERfNLl61d197n3GrOC
         M0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687251609; x=1689843609;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6H0MRXNIrPMMO+2t/2Rg0Dc5VN2Q075wwI9StE8bUE=;
        b=PUrDtwWx3EUBh1mKkI0SV47/JuQF7afCo7+nWdSJXFSyIIQIfXEvjS2bhzL4L2Yy/3
         YBAgbFf37FhwX7CHaP0pXVCek1iKFkXx8eb6j6bQeHZdTGeER/VJ8bd6PQEf2O6FgTTG
         8GamHkDSBHgRv62TPoapGwuXp8W++WccS+gaWiXHTx+MxVJ3Bk0U8BOg6iowyz4+RzAh
         fIV7gvWsnDocJES8pPHhB4VzPQtr7BCIPJCgud751B60UWkQ6CSx+JbEj1XzeO3LF7n1
         vBAZL6HeRwZe9PbbITdYgIH+ZCeuo/TQ49LTVV6xzpAV48nsvPKgILKBhOzFTYkV6J5V
         adRg==
X-Gm-Message-State: AC+VfDyhQESDxpsZ/1qjqBGxxUTTfH9A7twsXsmo8wRbEmlUuZq6FzTv
        FsVYTqzoDZOlKN0qMWFfcSErMCqNdLM=
X-Google-Smtp-Source: ACHHUZ6oD1Mu8VmmejsWUpHfHVX0v1/E2CzSaGwa63gj1lcAVoUqZnJVJe55iLuxXdTByhaejb2JgQ==
X-Received: by 2002:a05:6808:1788:b0:39e:a94e:11e with SMTP id bg8-20020a056808178800b0039ea94e011emr15045388oib.51.1687251608909;
        Tue, 20 Jun 2023 02:00:08 -0700 (PDT)
Received: from [172.17.0.2] ([52.185.204.64])
        by smtp.gmail.com with ESMTPSA id u36-20020a056808152400b0039ed47f4519sm858766oiw.21.2023.06.20.02.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 02:00:07 -0700 (PDT)
Message-ID: <64916a97.050a0220.3213c.40e7@mx.google.com>
Date:   Tue, 20 Jun 2023 02:00:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8621627488609824182=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, peter.tsao@mediatek.com
Subject: RE: [v3] Bluetooth: btusb: Add support Mediatek MT7925
In-Reply-To: <20230620082523.8879-1-peter.tsao@mediatek.com>
References: <20230620082523.8879-1-peter.tsao@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8621627488609824182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=758582

---Test result---

Test Summary:
CheckPatch                    PASS      1.07 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      35.71 seconds
CheckAllWarning               PASS      39.86 seconds
CheckSparse                   PASS      44.95 seconds
CheckSmatch                   PASS      121.40 seconds
BuildKernel32                 PASS      35.22 seconds
TestRunnerSetup               PASS      515.57 seconds
TestRunner_l2cap-tester       PASS      20.09 seconds
TestRunner_iso-tester         PASS      29.23 seconds
TestRunner_bnep-tester        PASS      6.66 seconds
TestRunner_mgmt-tester        PASS      136.01 seconds
TestRunner_rfcomm-tester      PASS      10.54 seconds
TestRunner_sco-tester         PASS      9.92 seconds
TestRunner_ioctl-tester       PASS      11.74 seconds
TestRunner_mesh-tester        PASS      8.88 seconds
TestRunner_smp-tester         PASS      9.82 seconds
TestRunner_userchan-tester    PASS      7.40 seconds
IncrementalBuild              PASS      37.63 seconds



---
Regards,
Linux Bluetooth


--===============8621627488609824182==--
