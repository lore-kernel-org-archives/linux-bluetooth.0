Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921B0C76196
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Apr 2023 22:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjDCWAE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Apr 2023 18:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjDCWAD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Apr 2023 18:00:03 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C817D26A2
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Apr 2023 15:00:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d13so28600107pjh.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Apr 2023 15:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680559202;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cgr416xV92sLbcTWEFloqNiv9zbHyn90EtyqAQ09Ep4=;
        b=nKJ3oIbGts2k5W96FoTCVyt3Lv7cGhkqZrGLmMe3X/NtRUTn1hhRPXm8jgqn7E9YOe
         TS5Kx6P4M7YVjPCaC7MHEZJq0qt2btsHVrZc6u5QTPkegh3mzQ2emrYXDdhxjW6STCBU
         cgpC4Z82jmpRwzOtawnKzapGNGJ18kEMVeikc4qRrwGPt1zhyvzhSmpYWqxIY99WpzVi
         41idQdh3AXgJUXWBoEuWi5IZ1AvNEQFLbGe6EsKcoQZvRLSETad+hezNQe5kkTCeIyL8
         7cM1B5hIXXnMnoZmMnib0zxslwXN8uNA7OMAc4Naf1PRgh3wQOnjrFBDa+RUZz/UwZiv
         nEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680559202;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgr416xV92sLbcTWEFloqNiv9zbHyn90EtyqAQ09Ep4=;
        b=lBmXOFt0i0hWDTt3YzXwOqP/O1k/yFcievPVE31fiEyEk0I8SugnxUSwCE/a5ya6tj
         TKTAxLpX0Oti/cmc7fBOxWCqltKIWm9+R55/zYnXglmX/Vyza5ogDwQvGniQTNsgPRa0
         KSYAXVWx1fV+DGD7k2tRnR4g+ipvFn7HMPhiUsxWXAAIS9GVFWS8HX5H4+yGe5xZtajD
         i+QLiG9KD1arTYqJYsD3zMg2VqKN5Tlmqh/6J6T4zYPJ5RfW3xnd8OUTXKd/uPY+a5BC
         Znabae4yhj1xPV5ggNqPpOpAiONEcmsqXaDgvTB/UfDfVaWAqVDv4xW/mB2XUOlgET2G
         r4pQ==
X-Gm-Message-State: AAQBX9cp1e/PLUCa9SJzVOo0l8ieGR78jroCbFZvzFzrwh4i97lLM9TY
        nvLwHO+49hxl68oEhfH24Sd91yC3XvU=
X-Google-Smtp-Source: AKy350aZVpaV+gQYDASxvT1R7oOV6NkFZb0jr7pwhQu6+bDys33trNWOhppEkGl/cW1KKAml6DoBWg==
X-Received: by 2002:a17:902:f304:b0:1a2:9288:e0b7 with SMTP id c4-20020a170902f30400b001a29288e0b7mr383374ple.56.1680559202031;
        Mon, 03 Apr 2023 15:00:02 -0700 (PDT)
Received: from [172.17.0.2] ([13.73.36.249])
        by smtp.gmail.com with ESMTPSA id jf19-20020a170903269300b001a065d3ea3bsm7066107plb.295.2023.04.03.15.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 15:00:01 -0700 (PDT)
Message-ID: <642b4c61.170a0220.f680d.dbe3@mx.google.com>
Date:   Mon, 03 Apr 2023 15:00:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8928427189541550268=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_conn: Fix possible UAF
In-Reply-To: <20230403212752.2005496-1-luiz.dentz@gmail.com>
References: <20230403212752.2005496-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8928427189541550268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=736562

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      37.55 seconds
CheckAllWarning               PASS      40.54 seconds
CheckSparse                   PASS      46.01 seconds
CheckSmatch                   PASS      125.98 seconds
BuildKernel32                 PASS      36.22 seconds
TestRunnerSetup               PASS      516.35 seconds
TestRunner_l2cap-tester       PASS      18.33 seconds
TestRunner_iso-tester         PASS      18.43 seconds
TestRunner_bnep-tester        PASS      6.17 seconds
TestRunner_mgmt-tester        PASS      122.58 seconds
TestRunner_rfcomm-tester      PASS      9.89 seconds
TestRunner_sco-tester         PASS      8.88 seconds
TestRunner_ioctl-tester       PASS      10.41 seconds
TestRunner_mesh-tester        PASS      7.83 seconds
TestRunner_smp-tester         PASS      8.90 seconds
TestRunner_userchan-tester    PASS      6.45 seconds
IncrementalBuild              PASS      33.86 seconds



---
Regards,
Linux Bluetooth


--===============8928427189541550268==--
