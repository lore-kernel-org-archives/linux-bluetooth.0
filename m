Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7EFCDB465
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 15:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346296AbjJSPhq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 11:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346349AbjJSPhp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 11:37:45 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CB413A
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 08:37:43 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41995d42c3bso48657791cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 08:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697729862; x=1698334662; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VXxs4JG6DwFEeNSDsyeKTRX2f5+y3GWfnoNa+6xJIQI=;
        b=ZJIWfEWuCXHDuvu/DWtHY17PWt2ICCicdV/ga6pgM46Rc5SLb3EstKEd6CRqTNpL7m
         FfFt/6U3ppvK53513RVVk5/c0s8WcJnHGwt6DDTmKdNsPD9RPmFHA+VINTyIhqQryOS5
         mV64dNyCIBhabiSx5Cvfi9a0uamVDnOY707ED6bIarh0lj5lSAfcoWZ7EXg53OICO6Z2
         1WAXDdhnuqgWdXrT1nSG0MzASyEG4U30QEjgGnRKfD7hNwlNVHv3pPw/UZIO/tKLHy2w
         HF41v7aOfTBbk9n2gcYU3m2IRvxmSgMKtnHRPDu2qq6UZ6T6byJZAUekH7AigDTigoWK
         YzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697729862; x=1698334662;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXxs4JG6DwFEeNSDsyeKTRX2f5+y3GWfnoNa+6xJIQI=;
        b=BE4lKvbZcQqVMed4aGotTkbYqOb5f90HXzFk6dAzQULDnzuCYfcMjzZ2meR6EKOiO/
         TOEZ5uPy26InlqzSivYCyRb/fg5yjdTdgr4Oyp3rufAGjaYr5zf/dXsV455Ph423Ri+j
         lJcxJeHYtKOQbLg4un4MbUv+3Vq/nBMIBxjSn7piQfZFYoHqjUS+ZPFjFPdSNPZGACzc
         Q64Z9PUYwhQfnt0rzm08PGTcIlkr1lNi83jIDgHFBRrrpM+oTs4SYA03r0t7nImt1Wok
         /vpPU+lfPRh7tq7+KM52FBAPuh3AAZ0kwptnEaeFxSCpu4u7rN7jqQ77NOVWDIg2wwUq
         m40w==
X-Gm-Message-State: AOJu0YzWVmV+a/TM/01fU8i2AtxDuddbpXyUWy3y7Z/UssYgXe1qCISc
        C/mHUxzgDpztzQkW5u/mV/MVCjl/zmI=
X-Google-Smtp-Source: AGHT+IEEOhL0N81g5GFZKvmJw+OniwDaPoKjVNcTPz6FP+G9ZPcpMDNyum+dQNnTsyDhdFF3ASkiXQ==
X-Received: by 2002:a05:622a:1653:b0:41c:bb79:ad45 with SMTP id y19-20020a05622a165300b0041cbb79ad45mr2999857qtj.12.1697729862483;
        Thu, 19 Oct 2023 08:37:42 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.202.164])
        by smtp.gmail.com with ESMTPSA id fy11-20020a05622a5a0b00b0041aff9339a2sm810144qtb.22.2023.10.19.08.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 08:37:42 -0700 (PDT)
Message-ID: <65314d46.050a0220.2f0a0.489b@mx.google.com>
Date:   Thu, 19 Oct 2023 08:37:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4481604802700865333=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Allow binding a PA sync socket
In-Reply-To: <20231019144922.4700-2-iulia.tanasescu@nxp.com>
References: <20231019144922.4700-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4481604802700865333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=794778

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      34.62 seconds
CheckAllWarning               PASS      38.43 seconds
CheckSparse                   PASS      44.01 seconds
CheckSmatch                   PASS      117.28 seconds
BuildKernel32                 PASS      33.64 seconds
TestRunnerSetup               PASS      529.91 seconds
TestRunner_l2cap-tester       PASS      31.65 seconds
TestRunner_iso-tester         PASS      50.77 seconds
TestRunner_bnep-tester        PASS      10.62 seconds
TestRunner_mgmt-tester        PASS      221.58 seconds
TestRunner_rfcomm-tester      PASS      16.36 seconds
TestRunner_sco-tester         PASS      19.67 seconds
TestRunner_ioctl-tester       PASS      18.61 seconds
TestRunner_mesh-tester        PASS      13.52 seconds
TestRunner_smp-tester         PASS      14.47 seconds
TestRunner_userchan-tester    PASS      11.31 seconds
IncrementalBuild              PASS      31.74 seconds



---
Regards,
Linux Bluetooth


--===============4481604802700865333==--
