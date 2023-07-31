Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C904C001DE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 10:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjGaKqT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 06:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGaKqS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 06:46:18 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBEB1A7
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 03:46:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686b879f605so2810148b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 03:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690800377; x=1691405177;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qqxV0tqjBQs9609OSuCPEzgsJEE6dwVjdH6r/bcvGWE=;
        b=KkARoV9vUDMQ5s3m8cDC7iUdWF3PHPhxokiV775qWJXt94kGA5o+NXVzmYtF6mpWzD
         obqKdwEdoy+Y0TQYYiIWDglCxvuXLbk3/zSCmec5ro3tXXAxfiGWqAJYWLu3DfKDpnF9
         6nwCCp6/1ZKnJswzT1X/7+c0tkrr+PtzDB4xCVbiOCnm4YbU7QnC2JsjH7AdovFE9k3T
         PNdibfvkAeI/sbhjQKmt5vY8Z3a2C9cpWk+qeNo4OId7afkpm99CXHu+A+yvQTyF8RoG
         UuSHez9Vt7iNxIL5sfX2I7bklIC6LDpff+yOUg+KZNaCWTphNZGML4bLFx5hjFeXzJkj
         /XcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800377; x=1691405177;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqxV0tqjBQs9609OSuCPEzgsJEE6dwVjdH6r/bcvGWE=;
        b=jLWlBthpy0Xj8GugeAgYrRl033Lqf73g+ePFYzngVKhzr2RozwWlp40IK6PgjELns8
         ZwiY+xwXSBHLcrJ/k5vYoa6ETzyLtMRG8FQ7mr4zbdGG4vtbj3X5IUnScgNJYgnOAD4o
         DVAJXo29fRe8BB3HavKldM7Ylr+VTFUTlGGxiKNbCmIU3uMRuckg30cGRCEPiqaVkUIx
         pJkIjn+lQtIM12pA6eod1wUR3eydNVwnMOw3WZvzl8e0zwDMyclxfiFuLGqVjC/IVcBz
         /wlnYiyqV3gaWP0FmVaI6go6rtJCbUo2vEDTdCZRh3vGvyfkD9JGSG1Q+llLsgX3HKvp
         LRJA==
X-Gm-Message-State: ABy/qLb9pfBfqAwlcBZxEhCunVWfTK3mwMqHUd7Nf8SYrtWu+GIovVXh
        MMdY46FVcwyhcyBfpihZcanm051Qim0=
X-Google-Smtp-Source: APBJJlE/ADigPY3hi19WeTGwuee8dUpSpOLJl1X8A5RpckqVCPR0L2UjVe4B53bqRglR+5AXL0mzRA==
X-Received: by 2002:a05:6a20:1615:b0:137:53d1:3e2 with SMTP id l21-20020a056a20161500b0013753d103e2mr10469114pzj.41.1690800377302;
        Mon, 31 Jul 2023 03:46:17 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.100.245])
        by smtp.gmail.com with ESMTPSA id n19-20020aa78a53000000b0064fde7ae1ffsm7353309pfa.38.2023.07.31.03.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 03:46:17 -0700 (PDT)
Message-ID: <64c790f9.a70a0220.f25d7.cf54@mx.google.com>
Date:   Mon, 31 Jul 2023 03:46:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0681918794439196849=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [BlueZ,v2] main: Fix integer configuration option parse failures
In-Reply-To: <1690795722-29873-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1690795722-29873-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0681918794439196849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=771110

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      32.64 seconds
BluezMake                     PASS      972.40 seconds
MakeCheck                     PASS      13.63 seconds
MakeDistcheck                 PASS      187.41 seconds
CheckValgrind                 PASS      311.54 seconds
CheckSmatch                   PASS      411.05 seconds
bluezmakeextell               PASS      123.87 seconds
IncrementalBuild              PASS      797.78 seconds
ScanBuild                     PASS      1256.69 seconds



---
Regards,
Linux Bluetooth


--===============0681918794439196849==--
