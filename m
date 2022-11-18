Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750D2C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiKRFIC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiKRFIB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:08:01 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D0E9827B
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:08:00 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id c129so4313869oia.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y95dYx8xvQ1UAuXcBksBZuQtSGQmo1Imkn0fhn7Z5+I=;
        b=pDMZ2ADJPWTbvO1bLnEQ/Lv1CyesQ3X2MhN+ZFoV7K0M2TOOiFAYJNZAPy9CwlXgfk
         ibakE3ik/yWcKqSvTB8O+bRmEOjDtbFO8bRGJzcxACClFP/vQZ6j3yTdl6Z+1A5uH7bb
         NU9PF91SjstbX5FHg1Kcp8zTgOiAulZ0BiaspacjQ9y72niTDVso8JMbpyBfZuRDBHDZ
         QXBlbnIrNT6NMERTt3ePpzM47mENiHbAPYwFZ5iXo7LdxGNuzM1VwJy7bzSNzYTs/Xp9
         PmXvmagjJzsZ+GaZi2+d1FUGG4kKZc7m8lPU3V9kU2KsZ1WFCmrS5QyiUULVVXfczn61
         M/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y95dYx8xvQ1UAuXcBksBZuQtSGQmo1Imkn0fhn7Z5+I=;
        b=5GIeAqBUfwMeBk+s5/3/6V7nMl/w0jeOXI4USx9NsEniksTAPbAdflQ219UHovTtbL
         zJlYy7f68mMaovqEN5ivNB7k/X1/IZ/D3BuV46UPiEgn+z6zmzlgbgihh41oTvRqcZxA
         YdMkBe0ByFnNpje0g32bkOdjKXxbAeHLG+TecSTtSaR9/ufXJtDyqk+PxFTOlUZVeMU/
         VZt6kbesN9QJDbxUpx6oUQff2ZTCQY54KaQPNQIFRK/zJDCI4owv5qMGcCvYk3BlmllR
         1JPmtpyf3JjPvXMpiUz6SaWVFZ1dujI5wlFAsTpsst4TpIUNhyvi7w6OcZgxmAORAtlA
         WllQ==
X-Gm-Message-State: ANoB5pkDWo9HN96aZK3IocToUae1p09cyP9muZmkjZTqNLdGbKSV22XG
        MbiGmdlstte/t25TXAQeGgqt7lCCrwk=
X-Google-Smtp-Source: AA0mqf42Gtr1vlxJ8DRy2dtDBZTJsWBh62vqiCI05eUBmuRjjhzt54g9xZUVDXtkP60U5XSXWsFfBg==
X-Received: by 2002:a05:6808:309f:b0:354:92b5:4078 with SMTP id bl31-20020a056808309f00b0035492b54078mr5391859oib.185.1668748079643;
        Thu, 17 Nov 2022 21:07:59 -0800 (PST)
Received: from [172.17.0.2] ([104.214.69.39])
        by smtp.gmail.com with ESMTPSA id g19-20020a056870341300b0013b1301ce42sm1446359oah.47.2022.11.17.21.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:07:59 -0800 (PST)
Message-ID: <6377132f.050a0220.fb9a2.66e3@mx.google.com>
Date:   Thu, 17 Nov 2022 21:07:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5228422221444588215=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: Add hci_nxp BT submodule with controller Power Save feature for NXP BT chipsets.
In-Reply-To: <1668616931-21987-1-git-send-email-neeraj.sanjaykale@nxp.com>
References: <1668616931-21987-1-git-send-email-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5228422221444588215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695943

---Test result---

Test Summary:
CheckPatch                    PASS      3.12 seconds
GitLint                       FAIL      0.58 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      48.78 seconds
BuildKernel32                 PASS      42.42 seconds
TestRunnerSetup               PASS      569.04 seconds
TestRunner_l2cap-tester       PASS      20.29 seconds
TestRunner_iso-tester         PASS      20.30 seconds
TestRunner_bnep-tester        PASS      6.95 seconds
TestRunner_mgmt-tester        PASS      135.41 seconds
TestRunner_rfcomm-tester      PASS      11.14 seconds
TestRunner_sco-tester         PASS      10.49 seconds
TestRunner_ioctl-tester       PASS      11.99 seconds
TestRunner_mesh-tester        PASS      9.27 seconds
TestRunner_smp-tester         PASS      10.87 seconds
TestRunner_userchan-tester    PASS      7.90 seconds
IncrementalBuild              PASS      38.80 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1] Bluetooth: Add hci_nxp BT submodule with controller Power Save feature for NXP BT chipsets.

1: T1 Title exceeds max length (96>80): "[v1] Bluetooth: Add hci_nxp BT submodule with controller Power Save feature for NXP BT chipsets."
1: T3 Title has trailing punctuation (.): "[v1] Bluetooth: Add hci_nxp BT submodule with controller Power Save feature for NXP BT chipsets."


---
Regards,
Linux Bluetooth


--===============5228422221444588215==--
