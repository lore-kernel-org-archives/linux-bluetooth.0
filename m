Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA6DCD6E54
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 10:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345805AbjJKKiJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 06:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJKKiI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 06:38:08 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2C692
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 03:38:07 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-419c8911049so44454171cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 03:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697020686; x=1697625486; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+X2v3JYBRXV8Qd33DYI9+4bHx3Tbc97NvvSC+hOqIaA=;
        b=E3WfXEcl/H1j2usJcyUtNrtvCDIU6CvF0FN4JHkeuSSsxLf1YcgUMuBV9LJs5QoWre
         Vx+YdBoo3ihWBzZj95Brg1BlhDoaEnA5u/dVLijEURUd8blwg+wbBt4u8DcqVla8P3px
         HOHVP433V8mqtYhDP3xbaGm029Cmn4Ks+5uHIpTGjl2IPIKo9cfMmsZOPZQEsbTOXg6a
         n89k1ItypeieH83S/xDb6nm+xGycHJyZ1mDDjavv8KOS3aj8RTkTtr64dbc2URWVCkQ0
         jx7SsQr5HDxK5PI38G/YmAFTprIhkwJvBcRJ75QfygPfIlCgHbZi4AC0l1+tUOdLIe68
         Rd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697020686; x=1697625486;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+X2v3JYBRXV8Qd33DYI9+4bHx3Tbc97NvvSC+hOqIaA=;
        b=QBInZYPBDU+dFyoP8Vv89sLuURQvkVCb7oleX5tvWnEJ55LDfd2Tf6WyHbSKxbtkRQ
         TeNDiR7Be/RXXsccmUAavObXZnfWEbOsZfzJmU4lQCQtmJwD86glpcgp9LmBYr3GiHei
         pRrC72a/CO+PHADqZJ4xUOFBPTQlTNobVKgckihZCviT4f4rOqj7TPpCqSDPv3KWNBcI
         XP6cdOpEYM57ZmjKfFKqQvCSKh+Je/GvQ4gp7y5ptMrdZExITH8N3hF5VjN1CyOWDyDn
         YmdYoLaf9huPCPFAT+ME3OW2J2odBJvMHYlQ46yzjmnAWY54dqSI54zzDy4yre7iCm3r
         E9rw==
X-Gm-Message-State: AOJu0YwGgNpvNHSzBiaUJQj9PiPrfCrNAyD1YokFlROvjJdfFUIRgzwL
        wwQ/yZYfSgNJfQMVrBAIY2FbQ5XJ9n8=
X-Google-Smtp-Source: AGHT+IEjjcogQQrnpwd2sUfEi8ztxEo88/KxIWxf1fiH+hdZAx3DBgh+eVFpnX23Jwblr64bYo/Mkw==
X-Received: by 2002:a05:622a:1c2:b0:418:1aed:ad5f with SMTP id t2-20020a05622a01c200b004181aedad5fmr25310340qtw.7.1697020686653;
        Wed, 11 Oct 2023 03:38:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.68.124])
        by smtp.gmail.com with ESMTPSA id 8-20020ac85648000000b00419792c1be7sm5281690qtt.30.2023.10.11.03.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 03:38:06 -0700 (PDT)
Message-ID: <65267b0e.c80a0220.b0eb2.5d5f@mx.google.com>
Date:   Wed, 11 Oct 2023 03:38:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5861704273090397787=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, william.xuanziyang@huawei.com
Subject: RE: Bluetooth: Make handle of hci_conn be unique
In-Reply-To: <20231011095731.1947052-1-william.xuanziyang@huawei.com>
References: <20231011095731.1947052-1-william.xuanziyang@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5861704273090397787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=792120

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      33.89 seconds
CheckAllWarning               PASS      36.58 seconds
CheckSparse                   PASS      41.67 seconds
CheckSmatch                   PASS      117.20 seconds
BuildKernel32                 PASS      32.48 seconds
TestRunnerSetup               PASS      505.08 seconds
TestRunner_l2cap-tester       PASS      30.01 seconds
TestRunner_iso-tester         PASS      53.87 seconds
TestRunner_bnep-tester        PASS      9.82 seconds
TestRunner_mgmt-tester        PASS      210.95 seconds
TestRunner_rfcomm-tester      PASS      15.18 seconds
TestRunner_sco-tester         PASS      18.52 seconds
TestRunner_ioctl-tester       PASS      17.00 seconds
TestRunner_mesh-tester        PASS      12.57 seconds
TestRunner_smp-tester         PASS      13.68 seconds
TestRunner_userchan-tester    PASS      10.48 seconds
IncrementalBuild              PASS      31.30 seconds



---
Regards,
Linux Bluetooth


--===============5861704273090397787==--
