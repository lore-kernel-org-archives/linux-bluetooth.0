Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6073C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 09:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348230AbiBKJEY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Feb 2022 04:04:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348187AbiBKJEX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Feb 2022 04:04:23 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B001F57
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 01:04:23 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id k25so8465321qtp.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 01:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pkeQitvZCye11vT/YLbWqaEyjBdrTVoRnbUVXMIcwxI=;
        b=X7m2cCkdSnPDHWiuqtr/VQBL18QF/9zIoS5AB7UMaaGWGRe/m9l4aXfhfk/YKnz6Fw
         bJvSq9UozyDlY0OTNrrIQpBdA8qB13Gs31DvsLlplQHSlo58zMn+n7VfwnKkRZqnhnaM
         yaMK9EE8da5jyCjwtoDJjOk6iCaDIMpIE8DHH3IiCO5IbOGkqrHck20145ZhUKTuOp+0
         pLxMqeix8DUVWnYiPfb4tEDflsvMe+tXrl/0FS+1NhGP7PzcpSRc5eUwyyFgMjG4oylM
         730GnIPZpOVQlTbZiEHrzJyMmFhE8knMWqx9ROIsJJ3Y80vvM1xFqqRCjRt7PPvM1nIE
         XzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pkeQitvZCye11vT/YLbWqaEyjBdrTVoRnbUVXMIcwxI=;
        b=L+DC7zElA7cqUJIZSHxNQskIwaAVK8ygUAplzyQ7nMJPX/uYOC/gkLB3L7YveE5z8U
         ETE1fWMc13dskFmhx/wqlck4HXWzI7nA11amNXnQ7/rZRj5l3EePbf09wgsBGIOUZxFZ
         htZQyexe36Ihg1UBcrSJ1x0AKCeYcGzysZwsEAO9xA5raZV2AZRI7aAlMMTq2QU80YzE
         f8X1iyhqppTPsOfgwya02u1sR0VlDEtM5OzfK644lG5m88SCHZZyiJMwYxJKDZP71e33
         3GJsBv7CiojG7oVT+2rRBLuM0qtjSd0bxNvJF/+JMIBfUgSDxgTzHscHbVDZZsgG55EN
         A2+A==
X-Gm-Message-State: AOAM533lGjKk5igPBjcotbfsZ1j35kZ0MskjKHRVTndQAAEhYPyCUrMs
        zUguO8u6j74Wa5loRtKkdwQc8nsHbRM=
X-Google-Smtp-Source: ABdhPJw59/tcYBpr4eGADfGCJu1du3SyFZ5HGRzFXGIzmTftLMw9vphcolwvslqvyBPwoNPh4rz1oQ==
X-Received: by 2002:a05:622a:15cc:: with SMTP id d12mr397054qty.261.1644570262403;
        Fri, 11 Feb 2022 01:04:22 -0800 (PST)
Received: from [172.17.0.2] ([104.209.216.66])
        by smtp.gmail.com with ESMTPSA id m8sm3523058qtx.2.2022.02.11.01.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:04:22 -0800 (PST)
Message-ID: <62062696.1c69fb81.c010e.5fe1@mx.google.com>
Date:   Fri, 11 Feb 2022 01:04:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0260316998621527316=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, zijuhu@codeaurora.org
Subject: RE: [v1] Bluetooth: btusb: Improve stability for QCA devices
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1644566196-15424-1-git-send-email-zijuhu@codeaurora.org>
References: <1644566196-15424-1-git-send-email-zijuhu@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0260316998621527316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=613386

---Test result---

Test Summary:
CheckPatch                    PASS      1.57 seconds
GitLint                       PASS      1.01 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      30.36 seconds
BuildKernel32                 PASS      26.71 seconds
Incremental Build with patchesPASS      36.33 seconds
TestRunner: Setup             PASS      470.65 seconds
TestRunner: l2cap-tester      PASS      13.51 seconds
TestRunner: bnep-tester       PASS      6.11 seconds
TestRunner: mgmt-tester       PASS      104.12 seconds
TestRunner: rfcomm-tester     PASS      7.75 seconds
TestRunner: sco-tester        PASS      7.73 seconds
TestRunner: smp-tester        PASS      7.61 seconds
TestRunner: userchan-tester   PASS      6.49 seconds



---
Regards,
Linux Bluetooth


--===============0260316998621527316==--
