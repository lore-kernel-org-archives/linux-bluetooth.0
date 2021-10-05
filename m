Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A49C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 02:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 203E0613CF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 02:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhJEC3p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Oct 2021 22:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhJEC3p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Oct 2021 22:29:45 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD905C061745
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Oct 2021 19:27:55 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s11so18363638pgr.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Oct 2021 19:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=1X8IvpmQwkFbG3/5X/xnESXValGPLFiGe10zMJWnW1k=;
        b=BQc9i7vs+i5omO5HpehZqRRvEKDUo0XRZHqB0h3yOqD0YRa7BwU6BYFG3/xXmO2748
         2iq3k2R7wM4HovCjubsvFI94GZJQJolgyb8bdGs7yJg/XlbwYcNHFf2nTeYDDcU7+jS9
         kqMioVjXJVp9JFglT0qBo0rBL3/ET/XXWCOKbRa0z4gdd8EdGflpTMRQfs9pUCF9SYlN
         ZVlo3WP2nFxZ8Du5FxDqmi8bABXJAQRjNqN0yRPmIkSYI9TWnwrrzguD47CiILG6xNKl
         QjMPFw6+kFdHKj4frjAvuJL5Q5mEWUB73gflEPCp52hW+fA4E/XdrHTbjmfMIdOAH2nN
         8n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=1X8IvpmQwkFbG3/5X/xnESXValGPLFiGe10zMJWnW1k=;
        b=2GBDyQ5A7kReQwkmYI2Jr6mVEzAdMuNPMpeKGaELK8V7sB511azxF5q7GL7t3z+Cbm
         pfCSyqxTvQuEZtDC3WeOF8Apoq7pr+lsaYadSAAwRbdrzoTICkMcWCboG4X9TrDUXHdL
         WCsw+11QhBBdA1aIxyRaDJD9dHtaTIjBUQwM5A8rltZiNqxbZaIHjQpnXteno655ERfO
         bUPr6Enkaihza9Mtlqq7b+lpAuJtHeRkHHFWvYkahzvTVuwsjU9J0BZS+1KEKHZelC5v
         4RNym94ACNAwg2haVlmBbJ9P6N9DD+ppquqnWpQrWROptHynpy/ywAP3dmADQH71F0pd
         aZZg==
X-Gm-Message-State: AOAM532RiWo60uqfrw7eLlqQ1hpc3Wyy7+wVxou6zmGfuxc/qFjXcayI
        tc4udOmpgJK3tfwBAmmQoW1wlNDXlPc=
X-Google-Smtp-Source: ABdhPJwc5y5SnmvmxESnPdzyjcXQ8A1mBCnrWJO1BVNxnlWZBVwDq4ZY3riFZF7fd+5wjRGZI3mZGg==
X-Received: by 2002:a63:4520:: with SMTP id s32mr13551517pga.27.1633400874876;
        Mon, 04 Oct 2021 19:27:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.137.126.61])
        by smtp.gmail.com with ESMTPSA id fh3sm170834pjb.8.2021.10.04.19.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 19:27:54 -0700 (PDT)
Message-ID: <615bb82a.1c69fb81.4696d.0f11@mx.google.com>
Date:   Mon, 04 Oct 2021 19:27:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7419548105079098530=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [DNM,BlueZ,v3] Build: Test patch - Do Not Merge
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211005011901.402910-1-hj.tedd.an@gmail.com>
References: <20211005011901.402910-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7419548105079098530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=557449

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.31 seconds
Prep - Setup ELL              PASS      53.23 seconds
Build - Prep                  PASS      0.25 seconds
Build - Configure             PASS      9.67 seconds
Build - Make                  PASS      211.61 seconds
Make Check                    PASS      9.64 seconds
Make Distcheck                PASS      242.65 seconds
Build w/ext ELL - Configure   PASS      8.60 seconds
Build w/ext ELL - Make        PASS      187.63 seconds



---
Regards,
Linux Bluetooth


--===============7419548105079098530==--
