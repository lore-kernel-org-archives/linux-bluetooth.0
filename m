Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2441C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Nov 2021 20:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhKVUiN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Nov 2021 15:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbhKVUhd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Nov 2021 15:37:33 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA3AC061756
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Nov 2021 12:34:24 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id v2so13305782qve.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Nov 2021 12:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=KOv5niFBj185Jf5IyFy4+Iov3BePW5408UovkXbOztM=;
        b=Kj3C/iUVHDpDO6VFo99x1PWGicGgWyUmBGeE1T5lvYIQlfM7hZu6MneDp5e/xnJb/D
         CCJPhctfgiHNjhCWajHfUHmvyUG5l3nchGNRBZiWXERXIp+IU4LJAaqvi3WtvWjzOp9/
         huKtCMi8k6EmtsHsIHMjWWAIcq+mn3r8p6CLpYowT0rUJgfxhLnGNYxwARsDtBz5tqyE
         TI1lSvOnFHPhkJgul8pJ0yO/xIfnbNyxz01lGy8SXUlz5w9R1+Ywc6C28639+q/p5Z0w
         DRYe/ubvznqGVOW4K50E13MXz+O8Vn/t5nRhRY3nS6Yu/YuACByn8JnqRr0UGGSEGeeT
         hAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=KOv5niFBj185Jf5IyFy4+Iov3BePW5408UovkXbOztM=;
        b=BCtFgYvJbdvu+LoCxNtzl4rR8QHEHPIpXg0ZimZpMGmW7Cr4JeeEWWDDvlXfrjS+Xs
         az0490R3VkWNJMD7Dq6DPWgCft+x+x2izriLrFqf/XsdOCqDTB8fEfCqXI/S5XwCT11W
         0mM8nMGA0cf2peNyAh49dmwD30JpH0XeevAnbNNkrcRfkrJGJfUfcrTSXfVZa4NB7IbQ
         WXC7DhTnRLvehJRAbGuCJShbs7rnfaPm/aI9VBgAjOn7Jm3+maB6x9cIgMTMSchPAfzl
         PfcmeHoDjJW2EgtccqHRLPY55j4wA16pt3LPVriTgWH6osqhysN2wf9H99KwazFYhsfU
         uh1g==
X-Gm-Message-State: AOAM533F0VQ8IaljflMG0fgMvL0xEgpwyIVJxTplomag5qvU5HkT5X6I
        weDMqMSD1KUcql9zXE5dzkY8dE/coJDMztv9
X-Google-Smtp-Source: ABdhPJwG9dTbHM54vd7wK5eQITkQQKVCScwwDVyamz38uopTTUh/RiDZ1tSuqxVnV6CSrDeOpX9OnQ==
X-Received: by 2002:ad4:49cd:: with SMTP id j13mr103493258qvy.20.1637613262965;
        Mon, 22 Nov 2021 12:34:22 -0800 (PST)
Received: from [172.17.0.2] ([20.119.170.46])
        by smtp.gmail.com with ESMTPSA id 22sm2464303qtw.12.2021.11.22.12.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 12:34:22 -0800 (PST)
Message-ID: <619bfece.1c69fb81.a54d9.caf0@mx.google.com>
Date:   Mon, 22 Nov 2021 12:34:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5090898264745071958=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] uinput: Remove local copy of uinput.h
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211122194218.2191284-1-luiz.dentz@gmail.com>
References: <20211122194218.2191284-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5090898264745071958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=584127

---Test result---

Test Summary:
CheckPatch                    PASS      1.57 seconds
GitLint                       PASS      1.25 seconds
Prep - Setup ELL              PASS      43.71 seconds
Build - Prep                  PASS      0.50 seconds
Build - Configure             PASS      8.28 seconds
Build - Make                  PASS      189.41 seconds
Make Check                    PASS      9.78 seconds
Make Distcheck                FAIL      11.13 seconds
Build w/ext ELL - Configure   PASS      8.40 seconds
Build w/ext ELL - Make        PASS      178.62 seconds

Details
##############################
Test: Make Distcheck - FAIL
Desc: Run distcheck to check the distribution
Output:
make[2]: *** No rule to make target 'src/uinput.h', needed by 'distdir-am'.  Stop.
make[1]: *** [Makefile:10334: distdir] Error 2
make: *** [Makefile:10410: dist] Error 2




---
Regards,
Linux Bluetooth


--===============5090898264745071958==--
