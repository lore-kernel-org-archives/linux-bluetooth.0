Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B127C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jun 2022 16:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356019AbiFAQLa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jun 2022 12:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355125AbiFAQL3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jun 2022 12:11:29 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1482A5ABD
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jun 2022 09:11:28 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u18so2240273plb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jun 2022 09:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=VCiV7BzSnn/ibCvTilUPCDkgzrxf40ay1XBi4NxVIec=;
        b=B1g15Z7C55OX4l2v+ltK66LmoIXY0ye/cx7Xi6NI2UejcvVPAZ1Q50OmuutrqOfCg0
         fhJRYXGArGjvg5hU91oZibq/y1DMoj4UdM3VcliqLvK7Gmd0e2Pb8LZolOeCOCbRFB50
         MPNuwMUxnUEfrgTLwdNPJkJ+cXpko4OTP9dRVC1ynqRgNoyH2sleiaDVxRFSiloR1uMz
         46pzunl9UFbk2SA9gjHp3VCgtAVDCg3Bq5kDLdW0hxVRLhLfoSmyTCuTgHjMrjZ2EWHp
         1RjOsq6DnrW0e29u+/OWSNjR8gnMdL95PdsHjQgkmR8ofNUtMSV+IGgYYKw1+zyoszCB
         3gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=VCiV7BzSnn/ibCvTilUPCDkgzrxf40ay1XBi4NxVIec=;
        b=SPYlTNyiIhFPvrsWzEcbmWxjsRwOtyXKqpPn/AqOKfvZGqJpmpLtT5llbeVbGZEcvn
         4/LQwmztXiy/yR4Ln1E85jRIlJnwFeKkzmvvRsQbPyM7/8Mb+lMeh56p2cmrhwsbQtKt
         N8BaQipfzkeC+CHL8L5vBYPTC+SxmpyPwobUfqdg/rxg/RN/x9ifsZicMfN881hMitHh
         Q8AH7RPnJeTbZxxlz2oGVms0lmfClkhBRUqjHHh27NBY5tIAkePfYcmgcURgm8YokkCU
         r7WrA3hqojWqeWekDX/Twy3+//pxWbHlAWOG+tGtQhtH2Ja2KePKNRFd4v5ZzxZJvrkU
         yg9w==
X-Gm-Message-State: AOAM533bTbspqcg89xOvo2DbpHXayD2rXJJEPmK/S0rgdz7TTGGjgpjb
        ZNwSBTgsD9GfaH9wG80raz+BXOvSWQI=
X-Google-Smtp-Source: ABdhPJxbUXUHWWZWh/nKVhjEbVudu5sCWOJgvxc5Z7r78XG8l+KAD5AgtTI9zpyfOcqLIWsNVE8NDw==
X-Received: by 2002:a17:90a:6b45:b0:1e3:3cfa:3104 with SMTP id x5-20020a17090a6b4500b001e33cfa3104mr9808089pjl.113.1654099888103;
        Wed, 01 Jun 2022 09:11:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.134.131])
        by smtp.gmail.com with ESMTPSA id i19-20020a17090320d300b00163f8ddf160sm1739113plb.161.2022.06.01.09.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 09:11:27 -0700 (PDT)
Message-ID: <62978faf.1c69fb81.b9d8e.41ed@mx.google.com>
Date:   Wed, 01 Jun 2022 09:11:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1149335855576733091=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, alainmichaud@google.com
Subject: RE: Bluetooth: clear the temporary linkkey in hci_conn_cleanup
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220601151115.1.Ia503b15be0f366563b4e7c9f93cbec5e756bb0ae@changeid>
References: <20220601151115.1.Ia503b15be0f366563b4e7c9f93cbec5e756bb0ae@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1149335855576733091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=646601

---Test result---

Test Summary:
CheckPatch                    PASS      1.10 seconds
GitLint                       PASS      0.56 seconds
SubjectPrefix                 PASS      0.42 seconds
BuildKernel                   PASS      37.30 seconds
BuildKernel32                 PASS      33.55 seconds
Incremental Build with patchesPASS      44.53 seconds
TestRunner: Setup             PASS      558.21 seconds
TestRunner: l2cap-tester      PASS      17.90 seconds
TestRunner: bnep-tester       PASS      6.14 seconds
TestRunner: mgmt-tester       PASS      104.45 seconds
TestRunner: rfcomm-tester     PASS      9.84 seconds
TestRunner: sco-tester        PASS      9.45 seconds
TestRunner: smp-tester        PASS      9.48 seconds
TestRunner: userchan-tester   PASS      6.28 seconds



---
Regards,
Linux Bluetooth


--===============1149335855576733091==--
