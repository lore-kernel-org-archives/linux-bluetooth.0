Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60906C00A8F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Oct 2023 01:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjJXBJf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Oct 2023 21:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjJXBJe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Oct 2023 21:09:34 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAAEDD
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Oct 2023 18:09:32 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b3e7f56ca4so2390626b6e.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Oct 2023 18:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698109772; x=1698714572; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+5Gks7mxZo58MFDd/VVOchDrRc8c7XqkkUDNR16P5Jc=;
        b=QCFM5gD4EDjPoPJX2kYCBl/FPfOYzqU0ULFI9Af/67jdxtNy4pvEtU+LW1lT5P427P
         7o9UPSvGsVXgPMLJ2EqArjMQpFAuRWYJxcj8YtnrONWXviDTnPvf7CKruk0RmuzB2ZOd
         xtlamJ8PB1++Z2NXW0sHl+NV6z8EKS4+cIcMq9HaWJd1u1Nm3LSyYWR7rAV8871HFeGp
         N0hJ8/US6gNYl2bz8u13mJtJ3bD9d4Xts2G7R0xOB4guA37uLBE1WJeAozm3/FgkHFhO
         LiS4Y2Wo+lp+pQ9089S/UwFuZrVvRLADE4LMhyvt3sNk+Gd8RthbfXIhcRhbKxFUuNhS
         d3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698109772; x=1698714572;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5Gks7mxZo58MFDd/VVOchDrRc8c7XqkkUDNR16P5Jc=;
        b=bnnDWbskK8DM7Pa24QYSvz9VuBcUUl5VQdq3y4UsaqPHh8qzM6BnnYoI9964f1IkBD
         9qt84/OJ2/gBgcvagpbK5L0xcf0Wpr45ey8WonymuhNEpzTqD6xD7KE1jKn7IjCLvLjq
         ZPbJcXbar52ntS6F68SjmR8bcWJttXhLa+KyPxw9C4V4TBXV8MNLCU1ST6a/SaBwouPA
         1kio9JsBAbkH+ukpImSw1rWUJug4CZt20+8Xjq/B+Lph4SqT9+d/bT2NbFu/0ka6UQOZ
         E8jLWeTk4Js0R2wnbrA2SAgu2/oyYt64pHJXsLvV9gXYt+C1UceXq+sJFZvGtrZgcWnh
         X7HA==
X-Gm-Message-State: AOJu0YwczcKw+LeX3jTqEncmVG5Zdyx+U3GcqpJVJ/FGzo3Jt0EsvTAc
        tYdghZ8OfI7pNqPJqoHCmmGMqzqq8fU=
X-Google-Smtp-Source: AGHT+IG5rWCjJrNDhuACkJDFNVnWDFxomgEXEpX02Wbnxx7G4ZG0mhuNuqUZb/sbZDJzCkx0DPSBGw==
X-Received: by 2002:a05:6808:90:b0:3a7:2690:94d5 with SMTP id s16-20020a056808009000b003a7269094d5mr11449330oic.8.1698109771948;
        Mon, 23 Oct 2023 18:09:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.43.157])
        by smtp.gmail.com with ESMTPSA id l17-20020a0cc211000000b00668bb8be252sm3199591qvh.60.2023.10.23.18.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 18:09:31 -0700 (PDT)
Message-ID: <6537194b.0c0a0220.18c37.c285@mx.google.com>
Date:   Mon, 23 Oct 2023 18:09:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1801249553337073416=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: Fix not notifying when connection encryption changes
In-Reply-To: <20231023233839.3700728-1-luiz.dentz@gmail.com>
References: <20231023233839.3700728-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1801249553337073416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=795840

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      34.62 seconds
CheckAllWarning               PASS      37.38 seconds
CheckSparse                   WARNING   43.43 seconds
CheckSmatch                   WARNING   115.98 seconds
BuildKernel32                 PASS      33.60 seconds
TestRunnerSetup               PASS      521.86 seconds
TestRunner_l2cap-tester       PASS      31.27 seconds
TestRunner_iso-tester         PASS      51.63 seconds
TestRunner_bnep-tester        PASS      10.69 seconds
TestRunner_mgmt-tester        PASS      217.66 seconds
TestRunner_rfcomm-tester      PASS      16.05 seconds
TestRunner_sco-tester         PASS      19.51 seconds
TestRunner_ioctl-tester       PASS      18.44 seconds
TestRunner_mesh-tester        PASS      13.62 seconds
TestRunner_smp-tester         PASS      14.60 seconds
TestRunner_userchan-tester    PASS      11.22 seconds
IncrementalBuild              PASS      31.63 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============1801249553337073416==--
