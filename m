Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28900FA3743
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Oct 2022 12:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiJ0MGt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Oct 2022 08:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbiJ0MGs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Oct 2022 08:06:48 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECBF8E99A
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Oct 2022 05:06:47 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id y67so1690311oiy.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Oct 2022 05:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mU5sdY3tyACM+tcMqkP8WP2x6N/WMAxlyxjU4RHudRQ=;
        b=E6U06B1JT+3JeOlWVXTiE3+1Yxy5RCsyjPfIwaSGQNnYRQeLHAP1IzTBQVwBB23pbd
         QSsjXpJF2SfNJzKQ3t85l3Ze/Pd+lV+R1/Zy/U5mbkVu0Qvn8Bg0z3dJb0X5O3SKxQ1m
         tMQXCaYZxiWCkUHcK33XUr3XD+PQxxTp+t+0MQpDqg22cOVt+WX+r0QVpxYypiS51GOb
         VdaUSHlkM/ntGsySpCbADECU+GzqpaW1169/Vg1jJ1GBz96pNnMfGiaEDA1Vc6ltFmq0
         mBUU4mnC6JK9vvP6qSywkm56bUf+Do6hxmpp2vdTF3b/asHA4IqtmUBE4JsgFJqxbSwY
         8H9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mU5sdY3tyACM+tcMqkP8WP2x6N/WMAxlyxjU4RHudRQ=;
        b=F2BEcBIefaALPYG7yMp3L7pgJ6e39VDtQ1o8Vd+JbZpCfGl2Af8i0DhMidD36deYxG
         nu00ih/pmR8/tyTYQEL6sBLTSPHDoZlNphmh6Ona/6fCe0liTDi/SQJGQmFewT3h47NP
         7BWJZCYvGIfAyBHiSjISR3mNDostwmTXvWlEbM71y3M1vs5gyKchYEGbIH9dm4c3nN7F
         pN9nOTBIt/Z6ia3lxsBDiShN4f/iU66EM8bWycY7iJaxqx+p5uBcmRAqzfFYuBiNEKX4
         61wE3goZ+erlW+rx90O9Kz7hribdLygItFIhzFXWvhmZNNj6vUeH2Tu9ektinQzEVTvf
         y8gA==
X-Gm-Message-State: ACrzQf3X20G6DgjeAi8R30KhAijJkO7TYhEAqlgGpn4E1+yVPJNFkQ/B
        WQBl14sAUHK5va/+Ig8XC3jbomMFlUw=
X-Google-Smtp-Source: AMsMyM4Eomm8MZhXqRdksEtd7dvPh0/RDemhMqBZlJW8fNv4Spe72du+nusm4doOcFX0bJvia7W4ZA==
X-Received: by 2002:a05:6808:13cc:b0:359:8e25:127d with SMTP id d12-20020a05680813cc00b003598e25127dmr4617822oiw.177.1666872406995;
        Thu, 27 Oct 2022 05:06:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.45.42.155])
        by smtp.gmail.com with ESMTPSA id q21-20020a9d7c95000000b006618e23df48sm403302otn.39.2022.10.27.05.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 05:06:46 -0700 (PDT)
Message-ID: <635a7456.9d0a0220.a0414.11c9@mx.google.com>
Date:   Thu, 27 Oct 2022 05:06:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7702969617113519205=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: btusb: Fix enable failure for a CSR BT dongle
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1666868760-4680-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1666868760-4680-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7702969617113519205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=689388

---Test result---

Test Summary:
CheckPatch                    PASS      1.31 seconds
GitLint                       PASS      0.79 seconds
SubjectPrefix                 PASS      0.60 seconds
BuildKernel                   PASS      40.13 seconds
BuildKernel32                 PASS      36.08 seconds
Incremental Build with patchesPASS      54.02 seconds
TestRunner: Setup             PASS      608.14 seconds
TestRunner: l2cap-tester      PASS      19.54 seconds
TestRunner: iso-tester        PASS      19.79 seconds
TestRunner: bnep-tester       PASS      7.61 seconds
TestRunner: mgmt-tester       PASS      119.94 seconds
TestRunner: rfcomm-tester     PASS      11.91 seconds
TestRunner: sco-tester        PASS      11.06 seconds
TestRunner: ioctl-tester      PASS      12.73 seconds
TestRunner: mesh-tester       PASS      9.40 seconds
TestRunner: smp-tester        PASS      11.09 seconds
TestRunner: userchan-tester   PASS      7.88 seconds



---
Regards,
Linux Bluetooth


--===============7702969617113519205==--
