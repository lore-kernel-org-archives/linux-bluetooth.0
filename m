Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D2DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 11:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiBXLFm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 06:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiBXLFl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 06:05:41 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D425E290584
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 03:05:10 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id bm39so1472577qkb.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 03:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6vQgYie7kmIVL8Zn61mnX0BOQi8H2/575aXjn+daxKE=;
        b=GeFYk69hJKzwsGLmqThBUQYbLu0m+av3VuIIzlsxCInN//F5a0DbHJRVcdxMTMqv2Z
         i5JycShAY5u82uQ7hoXjnhZOrN8ybAuoOwraAuaz9QwYA4wRUgKSehATePlUFVVHcCJi
         l/CKL/ct4XxGmuJx2UVbJcBoQzxKDtno3RY11OkyXzIqrQEnqGsdszHelTBDRfQK3+nC
         1xxYa9Yk+ypg+ASZTF59xX8vLe3bFeXfW+Av2BJOW3GQiB6m38xzEDYwSgG+LuJ+bv2Y
         2tmPgTpRuDdlZyRbrIJiWQjapG9jIBYjl8Bba3lgRSEpvVRVoSQr9mHZ2+Dlhr/Q6OTg
         pP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6vQgYie7kmIVL8Zn61mnX0BOQi8H2/575aXjn+daxKE=;
        b=VI/oU1YmJnGLPfHBDql8m2K0RErNpXVs33MSA/s4tv2dslGOGJXMCdD9tUTOx7SPs/
         GK4e3NaOID9RkDRAgTzJFDXVcJyXKXjAnF0jx21feiOB89DpWGozKX4ErO+hzxoN7i+l
         dAuA+8LdTUj23dNF45EGReEwKo7fg9g9nC6KpSaabZUqV7WrEKlf5FGVvGmaXcXlY3vb
         LCJX4p0X6NIhMH7J/jqhjtiCqKsNIRc4jo0dNcXuNkmXVlrxdl4GmJFUnTgYZnL1amci
         NnbZEHFrTs+JZxrciuXigs64QwGgfqLOYlvZXub30YpNnq61VX7Z+Q0yL77hOue5vKi+
         gc8g==
X-Gm-Message-State: AOAM530lfQeq30ErQkQdWnMvCzS4n3SdvibSJEdD54RxkUupYgmKU2v/
        7JWPbUqrufbNSrPMucyhiSpLBqLG2KK9TA==
X-Google-Smtp-Source: ABdhPJwhABZziCw5kD9HUm57Aoh0eY0nWTTyaAWLaVrywI4WxRZDNnlj2aVuJmQaHgL7VMylKOOdOA==
X-Received: by 2002:a37:2d46:0:b0:649:503:24e with SMTP id t67-20020a372d46000000b006490503024emr1147222qkh.258.1645700709864;
        Thu, 24 Feb 2022 03:05:09 -0800 (PST)
Received: from [172.17.0.2] ([52.168.8.225])
        by smtp.gmail.com with ESMTPSA id s11sm1430944qtk.82.2022.02.24.03.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:05:09 -0800 (PST)
Message-ID: <62176665.1c69fb81.44f21.9298@mx.google.com>
Date:   Thu, 24 Feb 2022 03:05:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9029779757101649183=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, gavin@matician.com
Subject: RE: Bluetooth: fix incorrect nonblock bitmask in bt_sock_wait_ready()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220224100641.2449550-1-gavin@matician.com>
References: <20220224100641.2449550-1-gavin@matician.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9029779757101649183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=617495

---Test result---

Test Summary:
CheckPatch                    PASS      1.94 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.83 seconds
BuildKernel                   PASS      36.68 seconds
BuildKernel32                 PASS      32.49 seconds
Incremental Build with patchesPASS      46.70 seconds
TestRunner: Setup             PASS      556.83 seconds
TestRunner: l2cap-tester      PASS      15.42 seconds
TestRunner: bnep-tester       PASS      7.09 seconds
TestRunner: mgmt-tester       PASS      118.87 seconds
TestRunner: rfcomm-tester     PASS      9.20 seconds
TestRunner: sco-tester        PASS      9.41 seconds
TestRunner: smp-tester        PASS      9.20 seconds
TestRunner: userchan-tester   PASS      7.50 seconds



---
Regards,
Linux Bluetooth


--===============9029779757101649183==--
