Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72645C00144
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Aug 2022 00:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiHBAFL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 20:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbiHBAFC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 20:05:02 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E972748CA4
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 17:04:38 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id b7so8286050qvq.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Aug 2022 17:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=X/h8PSPqziEQ0OwIOfziT119yG7xIrMPFuGmgKFc150=;
        b=MsXdi21y1pyScd0iKGGPSzYMy8V3R9UBsmoDPWFIXAP/AHpYBqS0IVKk8WYYJOfT2t
         J+wlV52iSU2rogjHrn+olSWjn0hKJmuVorfklmnR434mpabjB9lv09jSaRnHth0Kn+y/
         qNU0sdvb5ObwGNyHFaZ40KR+7+MkNjUkw/PNywItQRQ7mh1ec7oWNRjFHVGCvT3K+mfG
         2fyblHBdL1VLp2rzI2BL8WgsCnGD0wf45tSeULnLx8DXr1Z0tne2au7yn+fqIzlLvrgq
         O/0V6gWTdq9j0upflw/NqFHDDjqr0DUjn9tGi/66OuDBwineBYEhFgMLDNoEke0mT02T
         sz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=X/h8PSPqziEQ0OwIOfziT119yG7xIrMPFuGmgKFc150=;
        b=Z6yNc+XAfA11aT3JJst3gRNGc0Q0wO9y2qiJUxXI2vmanSlBhCoTdVw87isaoqSHuw
         lmsgOY5Ke6rcHyjxTF5XGtsFwPgroAdPartWs9fk8ilVd1wEODRkoDBItAEC5KAlJERx
         J/AFpcQzB9bzMgNRkK5wCwewATI8VxpnoqtjiME29WiVGRIQ6wx9zL9PoIMAbZDzcjuh
         YUHe8pShwlFgnc5GS6vvuHj0BiBVFP1pWtR/TOmLRJ1j/mZk9NfVsWVeUu/Iz3pFmcfb
         ILd/YB5xPeZ1AONuqSn5jIszwbUjBtrOez+UhrF0zVVnojZWhV9YDYA3E3ZoX0GSNeYA
         Dk2w==
X-Gm-Message-State: ACgBeo0kcldxOR7eZ9c9wr/6xOq+5VIPYcvXLhvTQFvoW9SMXP7Ebol0
        Rzdyxp3/Orh1QixTuzdfKryXkuW/jm0=
X-Google-Smtp-Source: AA6agR6/SjQIal0NFPKEmrg/LIaavcn8r8DKn1Zi25Y30WRVl6hpyqzUtVPnPFNtRmVr4O2F6/G5BQ==
X-Received: by 2002:a05:6214:4110:b0:476:d05d:71b3 with SMTP id kc16-20020a056214411000b00476d05d71b3mr2726188qvb.62.1659398677144;
        Mon, 01 Aug 2022 17:04:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.1.162.82])
        by smtp.gmail.com with ESMTPSA id z10-20020a05620a08ca00b006b650d2279csm8823789qkz.123.2022.08.01.17.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 17:04:36 -0700 (PDT)
Message-ID: <62e86a14.050a0220.7cb75.8000@mx.google.com>
Date:   Mon, 01 Aug 2022 17:04:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0570494523697936739=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm regression
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220801225702.2278772-1-luiz.dentz@gmail.com>
References: <20220801225702.2278772-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0570494523697936739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=664639

---Test result---

Test Summary:
CheckPatch                    PASS      2.76 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      35.02 seconds
BuildKernel32                 PASS      29.23 seconds
Incremental Build with patchesPASS      40.79 seconds
TestRunner: Setup             PASS      484.64 seconds
TestRunner: l2cap-tester      PASS      17.78 seconds
TestRunner: bnep-tester       PASS      6.74 seconds
TestRunner: mgmt-tester       PASS      101.36 seconds
TestRunner: rfcomm-tester     PASS      10.23 seconds
TestRunner: sco-tester        PASS      9.72 seconds
TestRunner: smp-tester        PASS      10.17 seconds
TestRunner: userchan-tester   PASS      6.57 seconds



---
Regards,
Linux Bluetooth


--===============0570494523697936739==--
