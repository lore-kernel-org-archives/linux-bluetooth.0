Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2A2C00144
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jul 2022 19:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiG2TU6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jul 2022 15:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiG2TU5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jul 2022 15:20:57 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325D4186DF
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 12:20:57 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x7so5428390pll.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 12:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=taPiuFQfUraGfIS0MTAPrgoOwV3dTXbqBOtOe2dVIvE=;
        b=NUvIj7NOao4A/91ongIx+jFzTwjCYDfeJReMawXB0c0XkZUxd1DnbgNPVEqAnsIMSn
         flJiaoXlAEuh5EtCkiGg80Ui0iQL6/VJ6g7+VWC46j+E5ZVZgN6sFKaH9pBnCHDmsScP
         tWQNuyGHQZFJvBwk2yIP2Qkz1pUmOukQd94CP3+RghUelY2MZalSwGcnc3tpFk+d5vv8
         W/wbJuJd6hPMzEO+k9SvWPerDqxDC9+wDwCW7nE9bjCPYaK2zMIkrhk024zFosscIZ+o
         bTFy48DJZpBCXYlA9YHTOhyOBzqfwa6BnSwK7hhUt37QBB7T+sXpSxMf6l8JjKceMCDN
         fQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=taPiuFQfUraGfIS0MTAPrgoOwV3dTXbqBOtOe2dVIvE=;
        b=Oy75g1JOlxxxovsDpKLl7zhUkXcrHxDQNbAeY4MdxkyVM8rdFkZBHitJmyrVV+6WEv
         fJjWCv/o2n0LdyMet5NijzFx4NbPtr4LQJ4CJ9q52xw/QqriiMfwN8w09eOapSdNEins
         QcDNbJgc0ePuPPf7SRYcu0WTuZzWqWKZN/CPikSSqR369uHccZcPiaIWXRqI1HMUjkkx
         iYMrSqZfHIE7K+2ZTg+MFd5IlGdZS4mKAg4Wr1WXCxFwmmf3Rp5zrmiYO6CUQqEPIqYy
         1V8sbeqKJEUFkWqhSbDgLphAnKt2EpNcfGS5ca9vxDPkOdM/xtRbza7fOl5mw/aO7+Dc
         dzNA==
X-Gm-Message-State: ACgBeo1YPmQkKUzrTNfXhZaeTBf+DzXiZ0C7UYqyxz8zET2DDrfQlxFI
        PYn+kp7Yd3DeHnurbVaHGQrvg112UoA=
X-Google-Smtp-Source: AA6agR4D8/G+vIfQ0xyGWgG5rrgaMDkLFGaDRdUgKM37YIHQkg00+j34xSrygk80aobuudOsGSu8/w==
X-Received: by 2002:a17:902:db04:b0:16d:82e7:72c2 with SMTP id m4-20020a170902db0400b0016d82e772c2mr5370372plx.100.1659122456161;
        Fri, 29 Jul 2022 12:20:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.20.41])
        by smtp.gmail.com with ESMTPSA id n5-20020a17090a394500b001ef79eb5033sm6231430pjf.11.2022.07.29.12.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 12:20:55 -0700 (PDT)
Message-ID: <62e43317.170a0220.ce376.a1c9@mx.google.com>
Date:   Fri, 29 Jul 2022 12:20:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2831525087868193924=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: ISO: Fix memory corruption
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220729181041.1571220-1-luiz.dentz@gmail.com>
References: <20220729181041.1571220-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2831525087868193924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=664152

---Test result---

Test Summary:
CheckPatch                    PASS      0.86 seconds
GitLint                       PASS      0.45 seconds
SubjectPrefix                 PASS      0.29 seconds
BuildKernel                   PASS      43.03 seconds
BuildKernel32                 PASS      38.11 seconds
Incremental Build with patchesPASS      52.80 seconds
TestRunner: Setup             PASS      632.61 seconds
TestRunner: l2cap-tester      PASS      21.11 seconds
TestRunner: bnep-tester       PASS      8.31 seconds
TestRunner: mgmt-tester       PASS      128.66 seconds
TestRunner: rfcomm-tester     PASS      12.15 seconds
TestRunner: sco-tester        PASS      11.77 seconds
TestRunner: smp-tester        PASS      11.62 seconds
TestRunner: userchan-tester   PASS      8.31 seconds



---
Regards,
Linux Bluetooth


--===============2831525087868193924==--
