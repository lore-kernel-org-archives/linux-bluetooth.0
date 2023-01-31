Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84359C38142
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Jan 2023 23:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjAaXg6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Jan 2023 18:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjAaXg5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Jan 2023 18:36:57 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857604FCD2
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 15:36:56 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id n2so11388295pfo.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 15:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7iUyJZAF1lSDP1AJI4UAh/LyPaH7TP85Zeh5QEzClqk=;
        b=ggnTQWT6MANrKpC5IB1dPl0NekK0ytI8Xl26G7mqx0YlPqzwkYJ6LNNJGpqryi3saj
         Z0cgH3f4zTczBDyQGz65bEo9M/ItdZhB0ZU40pap8me8YdGqPgqDuPnCDGiHVlsV7nVA
         avi2DW3347iwLdedaGKd0wjdinpGjWqJcbaULriCrVVpwDPEr7Rbyo6T6R/alzHnOgwu
         ocRX4buFrBCQBl3BODI5IyZ2Mb15COJobUOmlH9kNXyiGFe8SRvP3mQ7e6rCui0e1Qva
         0LFwG4Kud9TjzA0i9rXJ6SdQOsT7raXrIkjnkc/flSNdyTB5BB9iQWSHocD0Eehh63k8
         5/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7iUyJZAF1lSDP1AJI4UAh/LyPaH7TP85Zeh5QEzClqk=;
        b=lg3tISIRCcmfY2Mj+wmlY+/MzkklPccO30AvMnV7g8RRAfpW5v8yZng6MPEf6EdtLf
         4lmtSosol5zOcg99T1lkQSEdbUkqNqQOgSnbdqEfgVg4wWw38TwZApAsyYRj34LOM38m
         rDdVR0Dr3uiFbxX9hkGI9WZzuMAhfm2C4tSLTyHW+jcY6ksgh5+shbslEqZh8IHOgVlR
         Rc+UJCHuBrVhje4l4W5d/dshuiYpdh6mBBOqWlJwH613PegKf+COGpr3p1c1jPuhgxLy
         Ieg5M2mPJdY8ZaljQA665TjEKe0XPaTp+OPXdxDSwh1w7JAADGKpWPnLla7xzZNYUK+8
         e++Q==
X-Gm-Message-State: AO0yUKX5GJXUmQQY6uSQ8c1Hoduo6BL9TXhIMzr4NMDSOPj5imq+TYRa
        h4t7K5lCuoZKvqG4ReaalBjx0w7wWEQ=
X-Google-Smtp-Source: AK7set/1gdJcQwtHfyNngcAyZaZdp8pfHIdI3SGhIXQmsrfXBliTWEbNIci9NR09YtlZKds+6A+wdg==
X-Received: by 2002:a05:6a00:18a0:b0:588:a156:6a3d with SMTP id x32-20020a056a0018a000b00588a1566a3dmr379572pfh.26.1675208215820;
        Tue, 31 Jan 2023 15:36:55 -0800 (PST)
Received: from [172.17.0.2] ([13.91.166.0])
        by smtp.gmail.com with ESMTPSA id o3-20020a62cd03000000b0058a3d8eab6asm9157216pfg.134.2023.01.31.15.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 15:36:55 -0800 (PST)
Message-ID: <63d9a617.620a0220.7f2b.1e0f@mx.google.com>
Date:   Tue, 31 Jan 2023 15:36:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9124665744304593789=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, alex.coffin@matician.com
Subject: RE: bluetooth: fix use-after-delete
In-Reply-To: <20230131230105.139035-1-alex.coffin@matician.com>
References: <20230131230105.139035-1-alex.coffin@matician.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9124665744304593789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=717519

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 FAIL      0.41 seconds
BuildKernel                   PASS      37.65 seconds
CheckAllWarning               PASS      41.35 seconds
CheckSparse                   PASS      46.47 seconds
CheckSmatch                   PASS      126.09 seconds
BuildKernel32                 PASS      36.64 seconds
TestRunnerSetup               PASS      526.49 seconds
TestRunner_l2cap-tester       PASS      18.64 seconds
TestRunner_iso-tester         PASS      20.74 seconds
TestRunner_bnep-tester        PASS      6.79 seconds
TestRunner_mgmt-tester        PASS      129.13 seconds
TestRunner_rfcomm-tester      PASS      10.72 seconds
TestRunner_sco-tester         PASS      9.83 seconds
TestRunner_ioctl-tester       PASS      11.65 seconds
TestRunner_mesh-tester        PASS      8.62 seconds
TestRunner_smp-tester         PASS      9.70 seconds
TestRunner_userchan-tester    PASS      7.18 seconds
IncrementalBuild              PASS      34.02 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============9124665744304593789==--
