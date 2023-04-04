Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E805BC76196
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Apr 2023 03:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjDDDGS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Apr 2023 23:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjDDDGQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Apr 2023 23:06:16 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D47134
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Apr 2023 20:06:13 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id on15so9359364qvb.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Apr 2023 20:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680577572;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pEhoq5DY9bttjaVmMv7slcWcrXqgGl9Ko4b4KnhFhBI=;
        b=IjerFr9xSy9Z4zgVJNmqa8TKbBb1aOsk95q5b87j1FJ4n95Ax+muFYuhPn+duzGOSJ
         ASC2+cbtXj1Dthcm09hUO5OBKaU7s3kGx7UTyj94X/OCJtXOGXpSQLp/W9c1SNtB/hS8
         qanXQQVVUagoxesOVx940W/obGZ2m19ayNIY2O0fAe52xoCXwfrd/Nrpp0Ioti8tqPvu
         6piG31qQU8jLZo2kUmpVYPfA5CSlt9ov7j3N2J17EK0OMnLqcu2Dh53J6kz7VTTCUgAI
         Ekz1N9Xa3qFzT/S18lHfwAXYKuHJ4l3R17mR2rqQKEbJza+9DOyDbAXk62+toxgcZ3Qj
         37Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680577572;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEhoq5DY9bttjaVmMv7slcWcrXqgGl9Ko4b4KnhFhBI=;
        b=f0WkdzIXfY/i7Wiv8J1HY2y/2KgvABPwrr0Qdk7bsUvo3C7ThJj3Z5vpidvmDRJDWO
         xZyjJNZNHiscAEyDDmrqcU6rwHIt8MUAj7UE0ysVNsqlEWn1pAjg9kq0/7N6GGEzJTGX
         ElNsa2k3z/N6fvI3C4TapEuJBM6y+NY1Zy8aMztA23lPh4dABmhRHOpQCUv2hxm7aFhS
         kF/80e558vKpKpYfXqSTs3xxn8PKZahhD+FQwIOjKLU4F3ju4JyuikwOSsd2W8/5ssn/
         30HFqNUvuEuNcBr0P+715ShO8Oj/6ebtqD9o+T29+jGu2DSskZo401IGccVznRspU3J4
         /xpQ==
X-Gm-Message-State: AAQBX9fO9Yj7KJef4NkXbO0S1UWz8fzXiHGX9UHil00j7WFq4MexVAeU
        JRonFSqHQLNEzNrsfeO5JIGNqf3MCt0=
X-Google-Smtp-Source: AKy350YBEPlN0HNsr3YRavt2MUM6tLEzN+buqD8XqbF0H1etwWyHH9P55ENHQNxH10ViBSk14UbTsg==
X-Received: by 2002:a05:6214:e67:b0:5c5:c835:c8f1 with SMTP id jz7-20020a0562140e6700b005c5c835c8f1mr1189643qvb.22.1680577572633;
        Mon, 03 Apr 2023 20:06:12 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.65.73])
        by smtp.gmail.com with ESMTPSA id l8-20020a0cc208000000b005dd8b9345a2sm3098070qvh.58.2023.04.03.20.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 20:06:12 -0700 (PDT)
Message-ID: <642b9424.0c0a0220.f143.e11a@mx.google.com>
Date:   Mon, 03 Apr 2023 20:06:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7064092448371291333=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, eddy.zhang@rock-chips.com
Subject: RE: [v2] Bluetooth: hci_h5: Complements reliable packet processing logic
In-Reply-To: <20230404022711.86515-1-eddy.zhang@rock-chips.com>
References: <20230404022711.86515-1-eddy.zhang@rock-chips.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7064092448371291333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=736626

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.71 seconds
CheckAllWarning               PASS      35.53 seconds
CheckSparse                   PASS      40.03 seconds
CheckSmatch                   PASS      108.41 seconds
BuildKernel32                 PASS      30.93 seconds
TestRunnerSetup               PASS      442.02 seconds
TestRunner_l2cap-tester       PASS      16.15 seconds
TestRunner_iso-tester         PASS      16.08 seconds
TestRunner_bnep-tester        PASS      5.29 seconds
TestRunner_mgmt-tester        PASS      108.93 seconds
TestRunner_rfcomm-tester      PASS      8.43 seconds
TestRunner_sco-tester         PASS      7.88 seconds
TestRunner_ioctl-tester       PASS      9.12 seconds
TestRunner_mesh-tester        PASS      6.71 seconds
TestRunner_smp-tester         PASS      7.78 seconds
TestRunner_userchan-tester    PASS      5.58 seconds
IncrementalBuild              PASS      29.74 seconds



---
Regards,
Linux Bluetooth


--===============7064092448371291333==--
