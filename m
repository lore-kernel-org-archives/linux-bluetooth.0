Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF1FC7EE26
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 May 2023 01:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjEWBRp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 May 2023 21:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjEWBRn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 May 2023 21:17:43 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E2C91
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 18:17:41 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-19a7b2f7914so2251388fac.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 18:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684804661; x=1687396661;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0QIW6HsjpUuO5tc8nLRx8GXsjZOdwls2rk7kKV9jd0=;
        b=bylhWXI0TYABhTt544AOzlZxNSn2Z9LOgZ8LqArwP/hpTwGj+PfzwUb1SYGM2uKXx6
         WtNIYEhc/ZMolhuq8Dh6ZVPDMhwEb3g8610bRIS9ahU6OEHUCuTk+C4tPmWzpNmOIAOK
         GmrQYbDFBmcd+0/aCfeiC8Z6taT/UNZyr+y1te4evIG1ijs+hh5reAbGSmlWR+MaDjFl
         uR15T08UgVciLczDVZ+2ZRcd6so08urRcFIiuI54c4uKHdkawPpTwgSO0PdjoEkpy7kM
         vMVvlH77EFd1PoC0Y2CJmKIyawaWjRL+XquUnL9dlQRrCVHwICKgU9tQinvoZ8Nj73ud
         bYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684804661; x=1687396661;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0QIW6HsjpUuO5tc8nLRx8GXsjZOdwls2rk7kKV9jd0=;
        b=NN6R5xpcy8qjvQhetw/rEDJxOicfHsz9tYzuuZsGIXSJq2prLqKaF/bFScl6tQCt4s
         SMy40dH6zzlr/biJ6xawDOUeqtPVQdWxOAsYVKydVEGsn425KwiTB/cM9JpUHwhN58WC
         SKk7V6TQsAUN39BTmX0CysuPMjea8R3EjPaglDB9RowgdPAg6Tm5RblXu8LtWff2cs5h
         MhfkZUWq5iL0loxCnyn7m1mFhdEsu5HEJhAkxP5Mz2y/sFPv+BndFJXsu1pvpHTCwQBV
         j7OWjc6W2773bwCbpxQvZtu6Y26Tesx/iPgRmQ01yeM+7Tav+fK4v9LcpJW4lOk0Ot6y
         QtJw==
X-Gm-Message-State: AC+VfDyu8kZuWJSzQ17Wu4lYanDZnXnRbmnZ5cUyhqbR4XCCjT3gTXIE
        FfcKAgTCyX3XPBNpJWP3DgrQEefmjmw=
X-Google-Smtp-Source: ACHHUZ5dkWSRbas+HJdWeRB88rlrSKEMP14KBIOXmBTjYR82GNohz9GH/UvQaOi1YdSjjeXGmKKtyg==
X-Received: by 2002:a05:6870:c811:b0:18b:1936:30ee with SMTP id ee17-20020a056870c81100b0018b193630eemr6837218oab.56.1684804660921;
        Mon, 22 May 2023 18:17:40 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.24])
        by smtp.gmail.com with ESMTPSA id f9-20020a056830204900b006af74d59a3esm1920832otp.4.2023.05.22.18.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 18:17:40 -0700 (PDT)
Message-ID: <646c1434.050a0220.4dce7.8a8f@mx.google.com>
Date:   Mon, 22 May 2023 18:17:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0473493330472342417=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: [v2] Bluetooth: Fix l2cap_disconnect_req deadlock
In-Reply-To: <20230522234154.2924052-1-yinghsu@chromium.org>
References: <20230522234154.2924052-1-yinghsu@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0473493330472342417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=749991

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      43.74 seconds
CheckAllWarning               PASS      46.42 seconds
CheckSparse                   PASS      52.72 seconds
CheckSmatch                   PASS      141.11 seconds
BuildKernel32                 PASS      40.88 seconds
TestRunnerSetup               PASS      586.64 seconds
TestRunner_l2cap-tester       PASS      21.12 seconds
TestRunner_iso-tester         PASS      29.31 seconds
TestRunner_bnep-tester        PASS      7.97 seconds
TestRunner_mgmt-tester        PASS      143.13 seconds
TestRunner_rfcomm-tester      PASS      11.72 seconds
TestRunner_sco-tester         PASS      10.72 seconds
TestRunner_ioctl-tester       PASS      12.37 seconds
TestRunner_mesh-tester        PASS      9.30 seconds
TestRunner_smp-tester         PASS      10.29 seconds
TestRunner_userchan-tester    PASS      7.91 seconds
IncrementalBuild              PASS      39.00 seconds



---
Regards,
Linux Bluetooth


--===============0473493330472342417==--
