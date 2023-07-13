Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D34EEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 11:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjGMLEB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 07:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjGMLEA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 07:04:00 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7538C211E
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 04:03:56 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6686ef86110so323621b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689246236; x=1691838236;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0/u6x88aVGImb7eJ/pXBOEBUEehtLkYIRGT+zxidSGU=;
        b=gFX/M2K6P4mKDHJ5syXHbOKOIAqu0pzxZBb7hV8QOslVUPBbXC+B05QRVaQ2DeZxji
         4BThRzEzGgwKtB2wJE2nvCKJKX0EqeFLFId73XyXNr8y0ZdD0/ErVI3BPoitL8uR6s8f
         8awFDMKcMuePsnAXK5BxqIQHI3XzTsJu089cgGXUq0AlfSTkVTgf23KW78fjF8trvpbk
         dxdDDB4rthF65Pi3kczW1mZYtPMXRPXzwckLF5F0WK10t1rwQO8iV7WHuXnN5RinZu/z
         g8BlbFyb6zAVs6VITWTtkkDcr5cV53ecSwqZlRvzR8Ly3malDC2wRIYBkMjF3Pq5EtDy
         iUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246236; x=1691838236;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/u6x88aVGImb7eJ/pXBOEBUEehtLkYIRGT+zxidSGU=;
        b=FemJBhni6reIDHv5Gx3TzQvtxC5WtpCD2gf6PNRv7Gva/TqBkP5yCzgBoHsWakL4G/
         phCVQUaPftzeDwQ8zDC/h39swdVpn82mGbx3XNGAI7drS9LM89A2Sn6zxwRZfnVnImFU
         /EuMtQmvApgSUO3WG3CmP3Vjc/3TopI9LHDG+YgsXmHy4OluxF+oh3+Jor7x0t6xdg3c
         0xMXaoYTrQt1ihLYNGxp7BHeTOZzJHeipILtfzN4IrOYdbKrSZtHMfUDUfMFsTf7aNiy
         YYeU5zpN+gIZXjsnaCU4cPKpEQdHrAN6vJuDKygGoz5nMdQqO161HuaBeXvTWtkV8mIj
         Bucg==
X-Gm-Message-State: ABy/qLaPAZmgfnuOkkixW11dRztDXcyUGDOYy/B4hnQvXr6hs9DGkZlV
        OrvYG2Cjn3N+mVYxOM2TlPO+GgkvbxY=
X-Google-Smtp-Source: APBJJlFsuN1IkF7USUsECZ9SzuCnXiJr+eNU1JoBavbadmvvWUWz7VkhzAUUSIiD4f3HEQHw8gN3IA==
X-Received: by 2002:a05:6a00:3a1d:b0:680:f6fe:8908 with SMTP id fj29-20020a056a003a1d00b00680f6fe8908mr870607pfb.9.1689246235716;
        Thu, 13 Jul 2023 04:03:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.134.167])
        by smtp.gmail.com with ESMTPSA id t9-20020a63b709000000b0055be951145csm4822813pgf.36.2023.07.13.04.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 04:03:55 -0700 (PDT)
Message-ID: <64afda1b.630a0220.5ad52.8e62@mx.google.com>
Date:   Thu, 13 Jul 2023 04:03:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5398037001983512857=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tomasz.mon@nordicsemi.no
Subject: RE: [RFC] Bluetooth: btusb: Fix bluetooth on Intel Macbook 2014
In-Reply-To: <20230713102514.699277-1-tomasz.mon@nordicsemi.no>
References: <20230713102514.699277-1-tomasz.mon@nordicsemi.no>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5398037001983512857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=765251

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      33.17 seconds
CheckAllWarning               PASS      36.45 seconds
CheckSparse                   PASS      42.01 seconds
CheckSmatch                   PASS      112.99 seconds
BuildKernel32                 PASS      32.31 seconds
TestRunnerSetup               PASS      490.59 seconds
TestRunner_l2cap-tester       PASS      23.36 seconds
TestRunner_iso-tester         PASS      42.54 seconds
TestRunner_bnep-tester        PASS      10.79 seconds
TestRunner_mgmt-tester        PASS      219.78 seconds
TestRunner_rfcomm-tester      PASS      15.99 seconds
TestRunner_sco-tester         PASS      17.07 seconds
TestRunner_ioctl-tester       PASS      18.41 seconds
TestRunner_mesh-tester        PASS      13.44 seconds
TestRunner_smp-tester         PASS      14.46 seconds
TestRunner_userchan-tester    PASS      11.18 seconds
IncrementalBuild              PASS      30.40 seconds



---
Regards,
Linux Bluetooth


--===============5398037001983512857==--
