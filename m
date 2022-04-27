Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3ABC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Apr 2022 13:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbiD0NeU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Apr 2022 09:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbiD0NeS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Apr 2022 09:34:18 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3913B5F66
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 06:31:04 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x77so475969qkb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 06:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=H33uaYK0sdPKYgyh21wlb+Mm0LRWKP4yoim2kV3lTIA=;
        b=g+2q4YoJvvmnWq6jPN44tyhRukFcfGTmWx5NGN8lqhRAomFhp+LhJT5JTBu510MVE1
         CgwaMWW9jvKb2/jhL0HfUWiw/wtBhthbrLJODT4gUA8qMhkSvokb3u7u9So6ElukDY7i
         jswe+6cfUGFFgn3Od1DBv+qzpk4aB7wUWTDNXhi3jymDdgM24IOxraHjjio4/weJmqJm
         x9XR53jbbMYaOoJbC+Rv4i96WmDxaW8eu/6qyImaHQcYkmYqYBGuEZ3UlB/Yy6SwzKu0
         3WAylZCh77JjrVeWFe+hIQG/XHQNOynz3kTxufj/Ec5SPEWQMqIy1qx4DNflsV9owVo+
         iaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=H33uaYK0sdPKYgyh21wlb+Mm0LRWKP4yoim2kV3lTIA=;
        b=AdUjk3K3HZS2mcocQR0RaPgayLyi56wKlDArx1Lj03EO53VVrCxNmDQ+VMEaL/ejhh
         iCpBoBoejqlOQhbzc1//LMqtZXxAaPZwu2eI53O+o1cVkUFjfMGYfIjdTT3hJURpyahM
         QCVzg8Lg6I2Deyu+9dKw1/PjuWk62qmMDueOW5WkLvAuqCiI8GyUTmCmNkiaO06CLU3Y
         hx6ukoNyvaBkCFHK9sJmK2BlZVHt19+wyV87OM83jwM1i5HWP9KxCFYey+HmuYR19VFO
         ZOSSTvD61Fs9X9Q0ryFxFYSpIrlaDnwBVFrzdtWnc8qelRdeNI0UCU0kMYO2xp+id/N2
         D01A==
X-Gm-Message-State: AOAM532IIW8NwuXaw57fbUdlcNgid5YYDOznwtt8Am9FcRxwE3oqnqwx
        Rj+XSyhlTRlpTEvxT9+uuayhi2Qsm2wwAQ==
X-Google-Smtp-Source: ABdhPJx7ysGqeb9cPl41a/UdnULpiLgP/deCPb062AN0X3co6t+mTbbjm7fg0hO3DqUiPsOdm8c+mg==
X-Received: by 2002:a37:9487:0:b0:67e:81c3:506b with SMTP id w129-20020a379487000000b0067e81c3506bmr16229647qkd.254.1651066263142;
        Wed, 27 Apr 2022 06:31:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.239.113])
        by smtp.gmail.com with ESMTPSA id x24-20020ae9f818000000b0069eadcdc218sm7744268qkh.135.2022.04.27.06.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 06:31:02 -0700 (PDT)
Message-ID: <62694596.1c69fb81.7a8d2.bbf7@mx.google.com>
Date:   Wed, 27 Apr 2022 06:31:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8018821937207800654=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ismael@iodev.co.uk
Subject: RE: [v2] Bluetooth: btusb: Add 0x0bda:0x8771 Realtek 8761BUV devices
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220427125947.10429-1-ismael@iodev.co.uk>
References: <20220427125947.10429-1-ismael@iodev.co.uk>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8018821937207800654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=636179

---Test result---

Test Summary:
CheckPatch                    PASS      1.60 seconds
GitLint                       PASS      1.02 seconds
SubjectPrefix                 PASS      0.90 seconds
BuildKernel                   PASS      32.48 seconds
BuildKernel32                 PASS      29.73 seconds
Incremental Build with patchesPASS      39.22 seconds
TestRunner: Setup             PASS      490.87 seconds
TestRunner: l2cap-tester      PASS      17.34 seconds
TestRunner: bnep-tester       PASS      6.38 seconds
TestRunner: mgmt-tester       PASS      104.89 seconds
TestRunner: rfcomm-tester     PASS      9.93 seconds
TestRunner: sco-tester        PASS      9.71 seconds
TestRunner: smp-tester        PASS      9.57 seconds
TestRunner: userchan-tester   PASS      6.46 seconds



---
Regards,
Linux Bluetooth


--===============8018821937207800654==--
