Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D24EEAA7B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Sep 2023 22:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjINW5T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Sep 2023 18:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjINW5S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Sep 2023 18:57:18 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F652707
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 15:57:14 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso50216139f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 15:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694732234; x=1695337034; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zwd6RhasK8Zc2nsytL19XllI+0Y4q7zTik7llKyMbGc=;
        b=H5jQyfD9QGd28+86Wv9NNuCMzS4zksB9yCod7ycg94MTlD4R01XnviCs5mb8KdFiUW
         cqUkUJiVSz1tslI15f9kN18Smc1l6L4yGZB16vhb1lwlcyXPiKZElSM1H7KOf0ZCDyRC
         sq+nVqCkm/VLG9FN5Asn/mXWvAZFnHUnRm/7tVZ5Mua/hrgVXBEUtPy7EAkwryfJKMcd
         4zJsdJa0pfEbGdGyBlWKGjVf+HGZ7nxBrz0ZQjALiRlSpoBTu9WiA2d+KY6CrIU4/30M
         nd3FgLUd31Gi9vAFZT9eL2Y/sXVB9vcxiIzPwdN21m4TbSV26QXcChqtpcbnQG0p6W1C
         S75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694732234; x=1695337034;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zwd6RhasK8Zc2nsytL19XllI+0Y4q7zTik7llKyMbGc=;
        b=FnvbHtpslTxwnlAYlUK9IwVCr1NSjDf03SfEevjzKTN79IG0S334v6s+yZaGXgwkaW
         oHg5V8c4FdrmiFgEHfzCjnzZEto0Eu+FrEMWcTE9swxNC/ZsnlMT8kVTmUJJMPjdsy4m
         9EZ1gbLZXmoFCPgB7dhN6OMTlsA3Rkr89hz5+K+PCF5tPyoAdCzpO2cjy3T0CkjEWpFC
         nO47AG/T3Lssh6Uy51VbnD+c5yIEuYXt0rQLPXYnWGXfyx0peOpLT1ugPVcqkyaj1jxi
         D1YlM7PoLzf5owSxy20B0OY3MO1QM2xjjGnL7DJItdTEn2i3T0k/PbEEEhZD2CSm9Xhb
         GZDg==
X-Gm-Message-State: AOJu0YxlBHqSvUEKJTyPOTWlEbwdwjYdRSyT2BhhKYhR29xwOm6/BUUA
        rJx6mT0AmvItQfCg+mo/t58KDLNbMoo=
X-Google-Smtp-Source: AGHT+IGdIDYCFaNSFe934I1KNx9evdWVNzy3G39vhhrzc1yZSYAfK5AelRqsZ1Ab6WSIzSQK5Dxe9Q==
X-Received: by 2002:a05:6e02:d0b:b0:349:3756:b1ce with SMTP id g11-20020a056e020d0b00b003493756b1cemr185692ilj.2.1694732233664;
        Thu, 14 Sep 2023 15:57:13 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.92.127])
        by smtp.gmail.com with ESMTPSA id gk1-20020a0566386a8100b004302370a169sm685532jab.157.2023.09.14.15.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 15:57:13 -0700 (PDT)
Message-ID: <65038fc9.050a0220.fad8b.0e6d@mx.google.com>
Date:   Thu, 14 Sep 2023 15:57:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5674957565847617878=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] l2cap-tester: Add tests for closing socket before connection completes
In-Reply-To: <20230914211003.3339238-1-luiz.dentz@gmail.com>
References: <20230914211003.3339238-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5674957565847617878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=784343

---Test result---

Test Summary:
CheckPatch                    PASS      1.01 seconds
GitLint                       PASS      0.59 seconds
BuildEll                      PASS      29.02 seconds
BluezMake                     PASS      990.55 seconds
MakeCheck                     PASS      12.45 seconds
MakeDistcheck                 PASS      163.39 seconds
CheckValgrind                 PASS      261.03 seconds
CheckSmatch                   PASS      369.51 seconds
bluezmakeextell               PASS      109.74 seconds
IncrementalBuild              PASS      1706.63 seconds
ScanBuild                     PASS      1133.44 seconds



---
Regards,
Linux Bluetooth


--===============5674957565847617878==--
