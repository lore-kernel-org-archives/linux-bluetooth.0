Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F9EC6FD20
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Mar 2023 18:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCXSqB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Mar 2023 14:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCXSqA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Mar 2023 14:46:00 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795BCF1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 11:45:59 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id oe8so2237893qvb.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679683558;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zWVENB2rmeWWq4vYutxQuO2MIpzysjN6c3iuF12uOZQ=;
        b=Acl7HCgP3Q7L2oSLWYJUee2Zr+bUbAkLqnwjUf4Qek9zHnklzlvDwWFfPzh+Zww9hG
         2OiYhiwE/raxCRmGv3yR9bYIBzMhUXMmJ0FmqXBOzQNSJsLOHUUqFzjQnDQ99dur1eHC
         CtGd/ITffxrSutwyzt5p6cE3f5hijTGNr6UGaSBhE/hLjdQizlYpJfEL+lR2kuWIrPTB
         kZRr6m22B3q9jTrrCsLMVkQKoEmZ6oFsV4YzxS6SByIpd3Zxoe8Chxdx1dvkvKdRBSpu
         dfkVV46LncMUxxE4N0ZtmV/PWaIW/nKao1HDv4e8vgLrVt0di4vnU6mZqcIz89M8ch1V
         +I7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679683558;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWVENB2rmeWWq4vYutxQuO2MIpzysjN6c3iuF12uOZQ=;
        b=iMZc62RtrdExxgylnQQI7WIoy/txVCk9ROWvYPg5qAYQhA/KxGlGBuD7YBFPGI4TIe
         tn2OZlwuMc1FNREjPdsbHDYwosYNHUcOD7PzNWYXQswOFCYlS6127V3nKirDMbGq/Kad
         qB3/KrPV7FNeL8BIv1W2k4dkcF00mE9l5oWzwHLL89DfyVAk8b5qeEpKyq6eFMdhyiQa
         WhoH5I6GVdc7av1fhwJqMX4Bfg6LKipb1L+xMrMMr4qwmP38LE60KLr+yINPg/T0FlpL
         gVU33sCuZ+DAaseCMpMDODQN4n+m/Fv1XHbm3uNr965jxH1YCtosn4fb/HJBJKztOcU+
         dOPg==
X-Gm-Message-State: AAQBX9fwbYxI20jdtV2bkyOfG5vr7H0ts00ECbGYXgj03+cvMbrHjABq
        r89QAlkqLB+Hkcq8M67w6HLYib5AZVI=
X-Google-Smtp-Source: AKy350a+wS+JJ1cxUL7ye6uQsuqZ8UYqUNTXvo5YA+UIM81Q5+04dmmxj5cGcSiv/Pbxp9jLeLHTDg==
X-Received: by 2002:a05:6214:2604:b0:5ab:e259:b2a9 with SMTP id gu4-20020a056214260400b005abe259b2a9mr7456088qvb.14.1679683558396;
        Fri, 24 Mar 2023 11:45:58 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.216])
        by smtp.gmail.com with ESMTPSA id mu10-20020a056214328a00b005dd8b9345aasm865559qvb.66.2023.03.24.11.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 11:45:57 -0700 (PDT)
Message-ID: <641defe5.050a0220.2a27a.3d31@mx.google.com>
Date:   Fri, 24 Mar 2023 11:45:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7516062515917169119=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [BlueZ,v3] mgmt-tester: Add devcoredump test
In-Reply-To: <20230324102227.BlueZ.v3.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
References: <20230324102227.BlueZ.v3.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7516062515917169119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=733636

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       PASS      0.38 seconds
BuildEll                      PASS      32.39 seconds
BluezMake                     PASS      1002.32 seconds
MakeCheck                     PASS      12.50 seconds
MakeDistcheck                 PASS      181.00 seconds
CheckValgrind                 PASS      295.50 seconds
CheckSmatch                   PASS      391.26 seconds
bluezmakeextell               PASS      118.25 seconds
IncrementalBuild              PASS      812.47 seconds
ScanBuild                     PASS      1230.99 seconds



---
Regards,
Linux Bluetooth


--===============7516062515917169119==--
