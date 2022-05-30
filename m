Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFD7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 May 2022 17:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiE3RWG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 May 2022 13:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiE3RWF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 May 2022 13:22:05 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFAD6AA74
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 10:22:04 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id w19-20020a9d6393000000b0060aeb359ca8so8054767otk.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 10:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Z19uYLxkxW5bvb1KzeslM0T7BNlzR5YWn/RjDAxWrNc=;
        b=Pjjc2MtomtTOv/iCl0d3BbQYIXadTJ9YVhm7P4WZppUu8RhfPeGrZKK2mezq35n0P8
         fwGOArCSXIiXqwemWJ6Tz0l5l+a0YJelgrY2QaeldoQvATSgt9FsV+uHhaVPN+POHSE9
         PxQdoQm3vEkdll0vKXAOTdT4bmdwIUgWudBGZhY4cejhCIQy84nxlLV7yDw2q1HNsdRs
         rJT34tuFKgqlYa4h5FTB9cpaz1i+3Qq5pajcQnqQduWN9rV8z+dbGO54ZojQqWXoHXM+
         bKof1eL0z3nKEG6BJNjhDD4eD7h0olj0M2VJcmvTYr1BulRP3NJfbZ0dM0mU/PqbBszF
         Czcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Z19uYLxkxW5bvb1KzeslM0T7BNlzR5YWn/RjDAxWrNc=;
        b=XvGmby5e1ZLunMEG0I8WTaddFm48lGGlZrrKcCoGRpFZuf7AHQ54D4RaGuVV0IirVg
         V2Cbg35TQvBZnAdqIGhi8EeycSgDQzdjjH9rwz5Qxghz9sgHOztIqTKZkGVufzQMGX3H
         XUhdCE34lwfR3dnaB9UjtXx+UO4YZKKluo7xdkVPrzSiWxAcj+SLJtYcEGlq1fT0yljv
         KK9vUDUTpPKVGH1FJrtAsnAcixuwp0lftSWlaDDSIROOjCOeEPpyjf2aL3FKfoGlLUEz
         waf2BpDImNcWBLW2WC1JQnMGCc0JJ8HXIneyBtirpaSz3qh2V1kQ+NpvH7TECRglgfZ1
         B0Ew==
X-Gm-Message-State: AOAM532ie7MP2rNySomkqWns0Z2nCU8CX61sT2ZRF589v9JUeKUUzvix
        fVPq6KRXSLkFZahgffAeanTZZWD7OSc=
X-Google-Smtp-Source: ABdhPJxsWEguW9lJJ8vcGjfHh7vJPL7gmyzroNe0FJM7ctzM3hy1Ug2RU4Lqcz8lvWEFEeLs2qVZpA==
X-Received: by 2002:a9d:71d5:0:b0:60b:74e:dbb5 with SMTP id z21-20020a9d71d5000000b0060b074edbb5mr16545332otj.119.1653931322688;
        Mon, 30 May 2022 10:22:02 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.146.114])
        by smtp.gmail.com with ESMTPSA id a5-20020a9d5c85000000b0060603221274sm5140287oti.68.2022.05.30.10.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 10:22:02 -0700 (PDT)
Message-ID: <6294fd3a.1c69fb81.bb72b.276c@mx.google.com>
Date:   Mon, 30 May 2022 10:22:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2695841886685508065=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hakan.jansson@infineon.com
Subject: RE: Bluetooth: hci_bcm: Autobaud mode support
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <f395ffd03a6594ee11975b708721a33ccf8a4871.1653916330.git.hakan.jansson@infineon.com>
References: <f395ffd03a6594ee11975b708721a33ccf8a4871.1653916330.git.hakan.jansson@infineon.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2695841886685508065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=646037

---Test result---

Test Summary:
CheckPatch                    PASS      2.94 seconds
GitLint                       FAIL      1.47 seconds
SubjectPrefix                 FAIL      0.65 seconds
BuildKernel                   PASS      35.43 seconds
BuildKernel32                 PASS      31.25 seconds
Incremental Build with patchesPASS      48.75 seconds
TestRunner: Setup             PASS      552.97 seconds
TestRunner: l2cap-tester      PASS      18.88 seconds
TestRunner: bnep-tester       PASS      6.90 seconds
TestRunner: mgmt-tester       PASS      114.46 seconds
TestRunner: rfcomm-tester     PASS      11.12 seconds
TestRunner: sco-tester        PASS      11.08 seconds
TestRunner: smp-tester        PASS      11.06 seconds
TestRunner: userchan-tester   PASS      7.66 seconds

Details
##############################
Test: GitLint - FAIL - 1.47 seconds
Run gitlint with rule in .gitlint
[v3,1/2] dt-bindings: net: broadcom-bluetooth: Add property for autobaud mode
14: B1 Line exceeds max length (93>80): "    https://lore.kernel.org/linux-devicetree/e6e83743-1441-dc53-fd1f-cdfb9a24932a@linaro.org/"

[v3,2/2] Bluetooth: hci_bcm: Add support for FW loading in autobaud mode
21: B1 Line exceeds max length (93>80): "    https://lore.kernel.org/linux-devicetree/e6e83743-1441-dc53-fd1f-cdfb9a24932a@linaro.org/"


##############################
Test: SubjectPrefix - FAIL - 0.65 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============2695841886685508065==--
