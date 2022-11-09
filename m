Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE10C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 10:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiKIKEv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Nov 2022 05:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKIKEu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Nov 2022 05:04:50 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66846CFC
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 02:04:49 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id hh9so10047851qtb.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Nov 2022 02:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9beNnUVgB1NUjnvBF4ufj3jwZoR3KYpP/ajHVAjOa7Y=;
        b=oERiB2TtRYurv2KtrNL7929dPhvF2bKGD3VgCTPuNwiwXHwQARK9fghLgGg3RS8fiP
         C8i1g00DjLAmTx+FpzMiOoKP3YQkKOUWjntRXpyKL2pCnTpMLrnpREqs6sTPJSlaTt50
         QW1EDV7bc6fC0kaaCubb2HqOlaweUwfUkE+ifEqK0WApc53OfANF3dhWnvZ5aaFhbD/G
         1YSh26ChrBmtHABFm15NnOMpHAV3ezCywuocnzpy/MaNOZfA1qQjYwxAIP+P6DFBvXxd
         HnDP76c9yQmNs2Ef4L1aJd7fKby/96A16q02Cs2q1HxsKxvsKXoxQlF6wYaSg0OMH4JB
         jwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9beNnUVgB1NUjnvBF4ufj3jwZoR3KYpP/ajHVAjOa7Y=;
        b=46H+ujNPVZJua3tyyZMIUOrhNVm75BLRcJiXlRLKOmbFKYm3MCXIwQ6R9S3AZbhyi1
         Mph64qWyRy3tSA7YUoRdAtjO5oYgFCLLYNahBdR4NzzRLirauO7DTt6Ro+V5qhUj03Hp
         lzMQ53E4/d6TSKq1dy8p2vIRNzXOo1cLpQvmPDYnpbhUk2YKk22Rg0n/InJad2pTrEvi
         S79E8bYyFQpsEuHTLmY0u/aps6ZQRS6w0fE8b7+3R0bKuaSaIH7RlW/9+JS4AVsTuJ5V
         rB7cyNQRCYn7xsxXSuFDNhStQ2UTLW+wITlut7+olC6MPRouMqKqXqZNixc2wQ0r0mWs
         Cgcg==
X-Gm-Message-State: ACrzQf3Rt1dYx4YETRBOKslRYYeO5OI1kEIaaCEv2oFgeaBC29diMYJ9
        pPO8KAUIOst9UX0jQXqGRPdmVA5pqeJR7A==
X-Google-Smtp-Source: AMsMyM4XZv3rZWyc7ErqiJHoNyRKhlrXdJ9aKR7u/rUZFGtQzqV5t0zzd5OQQS6+zsrGIMvModsk4A==
X-Received: by 2002:ac8:7651:0:b0:3a5:528c:f326 with SMTP id i17-20020ac87651000000b003a5528cf326mr24947898qtr.586.1667988288395;
        Wed, 09 Nov 2022 02:04:48 -0800 (PST)
Received: from [172.17.0.2] ([104.45.198.228])
        by smtp.gmail.com with ESMTPSA id bj10-20020a05620a190a00b006fa313bf185sm10805895qkb.8.2022.11.09.02.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 02:04:48 -0800 (PST)
Message-ID: <636b7b40.050a0220.571b5.ac1c@mx.google.com>
Date:   Wed, 09 Nov 2022 02:04:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2354133710631904279=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bobo.shaobowang@huawei.com
Subject: RE: Bluetooth: 6LoWPAN: add missing hci_dev_put() in get_l2cap_conn()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221109093726.3132203-1-bobo.shaobowang@huawei.com>
References: <20221109093726.3132203-1-bobo.shaobowang@huawei.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2354133710631904279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=693552

---Test result---

Test Summary:
CheckPatch                    PASS      1.69 seconds
GitLint                       PASS      0.93 seconds
SubjectPrefix                 PASS      0.87 seconds
BuildKernel                   PASS      33.96 seconds
BuildKernel32                 PASS      30.86 seconds
Incremental Build with patchesPASS      45.61 seconds
TestRunner: Setup             PASS      509.62 seconds
TestRunner: l2cap-tester      PASS      17.54 seconds
TestRunner: iso-tester        PASS      16.42 seconds
TestRunner: bnep-tester       PASS      6.55 seconds
TestRunner: mgmt-tester       PASS      107.40 seconds
TestRunner: rfcomm-tester     PASS      10.47 seconds
TestRunner: sco-tester        PASS      9.83 seconds
TestRunner: ioctl-tester      PASS      11.17 seconds
TestRunner: mesh-tester       PASS      8.13 seconds
TestRunner: smp-tester        PASS      9.90 seconds
TestRunner: userchan-tester   PASS      6.85 seconds



---
Regards,
Linux Bluetooth


--===============2354133710631904279==--
