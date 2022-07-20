Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9D8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jul 2022 18:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiGTSO4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jul 2022 14:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiGTSOz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jul 2022 14:14:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2608D65D4A
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 11:14:55 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id q5so15693257plr.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 11:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=B+svS4h067IBBp04mDZzdVteE1LO3LhYGp+MLYMLIH0=;
        b=R1jWzorolJp+n9GpnsXYjo76EiKw8k+BdqQQt+V2J2PPIDL3W53hVgU3VdgyDH291Y
         rwQNnhCgfox+bh69hNTUDdoSU6MY7n/gcRAAfTmj3VwHqdQUlS8y43UdaeAn0Lbc3W2d
         RNvjGwSIKGMHjfNmjJRCYcamDzM/u7UjewFZcka8DX7UHPEWGJGWYBnarJ9ow7kQ31hn
         PaYXC2s1aYbathIcY3nwYNSIOgiROe6WogVPBN+a8/JIqDG/Hg44+YzRgAJ9eriSObX3
         +0EMsyybmOhVwPvU9iptQvyhBLqa2466MqyZP0s83FDUpNq5wPqjIdNDGmw+37HHJmQs
         rS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=B+svS4h067IBBp04mDZzdVteE1LO3LhYGp+MLYMLIH0=;
        b=O4AqBVmNAJeueN3ck4iIFw23AkxdV2BJ4BnsBo0zZiQEHtaKWgFJjKalHfeVBJBJUu
         UJ7AyGInYi2lkK/NvvNPF59cPhlwjKABFBImcUqplZfRDI+6JIdSg5+OOIpQqyNMJDNQ
         sIfH/HkdgplxJzQ+/8F+j066bRiSe28YqDW86vitVr+i97Men8dpExFM6vV9+Ow4mGlx
         ICCFCsDnknlgqkxrqXBAJ5HmP5Lh1b4IhVprWDnz8QM0/Hb2fJgx7p3U6EbleKumYHJz
         a5CIeiJfaR0XfxUhV3nNZ6kvCaEIfVKQCMyWiFouAW94oXaP88AKvhZjLhT5bxe+fd1Z
         HvBA==
X-Gm-Message-State: AJIora+drXFBiC5HTc4Kfp7TLG7Dvlr2mfZ526aE3HzIBlUdeqGTaO8Q
        6Cg7xxu+2rL2Vh3qNkediqDFy205qNA=
X-Google-Smtp-Source: AGRyM1tHyVhAo2uGT9C5q1zPRIleWNuSM2FnsEkwk2aGG4C0OBXop+4G1YH+gzwY6OHc/KAEwoWnuQ==
X-Received: by 2002:a17:902:e5d1:b0:16b:ece4:79e6 with SMTP id u17-20020a170902e5d100b0016bece479e6mr40287993plf.83.1658340894311;
        Wed, 20 Jul 2022 11:14:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.19.115])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b0016be1b6dc80sm14448549pla.82.2022.07.20.11.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:14:53 -0700 (PDT)
Message-ID: <62d8461d.1c69fb81.96e3c.5abe@mx.google.com>
Date:   Wed, 20 Jul 2022 11:14:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4530625302651004324=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_sock: Fix cookie generation
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220720172704.157170-1-luiz.dentz@gmail.com>
References: <20220720172704.157170-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4530625302651004324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=661548

---Test result---

Test Summary:
CheckPatch                    PASS      1.26 seconds
GitLint                       PASS      0.42 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      47.78 seconds
BuildKernel32                 PASS      42.85 seconds
Incremental Build with patchesPASS      57.10 seconds
TestRunner: Setup             PASS      697.75 seconds
TestRunner: l2cap-tester      PASS      20.82 seconds
TestRunner: bnep-tester       PASS      7.43 seconds
TestRunner: mgmt-tester       PASS      123.93 seconds
TestRunner: rfcomm-tester     PASS      11.76 seconds
TestRunner: sco-tester        PASS      11.37 seconds
TestRunner: smp-tester        PASS      11.30 seconds
TestRunner: userchan-tester   PASS      7.84 seconds



---
Regards,
Linux Bluetooth


--===============4530625302651004324==--
