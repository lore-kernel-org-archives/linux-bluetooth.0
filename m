Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C11C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Mar 2022 04:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244001AbiCKEHb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Mar 2022 23:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiCKEH3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Mar 2022 23:07:29 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82AA13EBA
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Mar 2022 20:06:27 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id k125so757027qkf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Mar 2022 20:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=GGHOCdeB69Q5l07XZHz8L+wEusc2cHCpWGfafHIxN+s=;
        b=RGM4TowjFAI/5GRJW3qJ4NAhoK9LhbE56gp0I57tHBkPn8OMjYA0H0XRv+/2D/X7la
         WAcgjDCFNbyfNXb+jEp1eH6xkws5jSXEzE5QYwGPEe3fXV3BxOV/sQN8GCjx8WMtbSlY
         l2qcb8K6FBmOFryxrvqe6ssBMYUR0y4jWwFs5MCUzljWp6oKuCccFwk4QK/75naYuwNd
         7+D+8aMyKOzpY3a8IQ6jFd6u1mNOFWV0RHhAy1pFKEODnzeY/LrYmLvPAJF56blw3Grw
         KCwCN9CKAVHDyh5RFPuAkwCnD3DZAESIJHxo1YdLr4D7I6YwpclRwdgIdz+1SSpG6AiM
         jgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=GGHOCdeB69Q5l07XZHz8L+wEusc2cHCpWGfafHIxN+s=;
        b=XUX48aZUBamaAlxOkIqmCUwwPZa6DOd8GpPtzpaarh+kAytFCnB6yiNHzvAT0UlYxr
         YNGIiioX3UFKNf0cJ4r6YTY1y3tI//UTevU6jb1zX0egDU4SubTzxAfmGGaVDk72kFqz
         dW9DThwCdH1R9EdcgQBzPISjURpxcOCQvnd/idJLFfdRqeVZQ7c7zFnyz+lvfoL5WE+g
         ksew91oGOXjAbS/k6/kGSJV0t86LbtN5EvHuSKzzbqHEb2EB37RDTuMFQJXkyVBQqcHd
         ZCbKsuVQFnJ95oT3cFhSUcJHtfAvmgMoPkOsjFzC4DMQUx6qdvZjPmpNi6b5hyNfNfpf
         lZKA==
X-Gm-Message-State: AOAM533KG6iZTj+yeTwD+k5R9IIvqrFsl7Vm3w7qdx1f9vGTfWDLOt+e
        dc4L+UPNKapCht0+14IIKOq2j/GR/SIDiA==
X-Google-Smtp-Source: ABdhPJxDjQzLzaJyr7fNoeYZn0H9lSB6Pk8fS5Qr7wyUWJJxM6b+yDXF0JLNXJ6Ss6o+pqPVi6ut+g==
X-Received: by 2002:a37:9a83:0:b0:67b:31be:2ac2 with SMTP id c125-20020a379a83000000b0067b31be2ac2mr5477196qke.416.1646971586710;
        Thu, 10 Mar 2022 20:06:26 -0800 (PST)
Received: from [172.17.0.2] ([20.231.124.63])
        by smtp.gmail.com with ESMTPSA id 13-20020ac84e8d000000b002e068382bf8sm4775431qtp.63.2022.03.10.20.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 20:06:26 -0800 (PST)
Message-ID: <622acac2.1c69fb81.be8c3.c94b@mx.google.com>
Date:   Thu, 10 Mar 2022 20:06:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4976147610890282436=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tangmeng@uniontech.com
Subject: RE: [v2] Bluetooth: btrtl: btmrvl: Fix firmware filename for rtl chipset
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220311032720.28499-1-tangmeng@uniontech.com>
References: <20220311032720.28499-1-tangmeng@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4976147610890282436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=622477

---Test result---

Test Summary:
CheckPatch                    PASS      1.72 seconds
GitLint                       PASS      1.05 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      41.97 seconds
BuildKernel32                 PASS      37.66 seconds
Incremental Build with patchesPASS      50.31 seconds
TestRunner: Setup             PASS      635.50 seconds
TestRunner: l2cap-tester      PASS      18.84 seconds
TestRunner: bnep-tester       PASS      7.80 seconds
TestRunner: mgmt-tester       PASS      125.51 seconds
TestRunner: rfcomm-tester     PASS      10.03 seconds
TestRunner: sco-tester        PASS      9.74 seconds
TestRunner: smp-tester        PASS      9.75 seconds
TestRunner: userchan-tester   PASS      8.34 seconds



---
Regards,
Linux Bluetooth


--===============4976147610890282436==--
