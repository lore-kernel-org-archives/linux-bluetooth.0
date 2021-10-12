Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AE0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 22:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A9261039
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 22:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhJLWhK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 18:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhJLWhJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 18:37:09 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74086C061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 15:35:07 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id v17so898267qtp.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 15:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=oGJm8M60WMY0PWqCYF+MaRwRdv7JFbRNwamh+9+v5wk=;
        b=gFdKjd0H11+WTGY0CoboEB5h4kuU5P7Z/appOFy+V8wzFUmJNfUP1Pi9qcK7+c0zBL
         E2X5Nodf4YrMTmaR+DCU4+xWuCIOWVmH0+oTqVXXbdNqVrdPP9cXqgsojuiYSRHKLEHE
         0YyfalAQ0kKBy+Ke6jQaa8g84ZjMMZa8YH9QL89yGAcbYvBRBYeT8pnX97VGy2JxdxWi
         +rvBCg3Ll9p6/frltza8v4piEE7+GIEG8UXxYYOFcM93RWgIyvWj35nppT3aqk5CwIwQ
         ESPyrFo3brARANmIdoMeS++GVOSS6hFmFcUkmp2fLrVw9umLQRV1qbw8Poub2hKX/mpk
         LWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=oGJm8M60WMY0PWqCYF+MaRwRdv7JFbRNwamh+9+v5wk=;
        b=Iv6wbvwliYfiHIU1C9qCMDf6E96EfQFfCn/877u1oBL3Is6M8LPx8I/5TMkU1uaJSP
         I5IbiUzfzHUJS4P7B5yRSsoErTRoQKI2p8NeiKejzpuBFURPNsPn73vfmTDlshuwOaQj
         bw0fZMWCXvvL9mAZwtZEBKSEUzJsErNvY6wF0AWcDooUg/Nv7Goxmm16fi+qzIVUXX7l
         K2z5fpdILuz+ofDYMTzo3Fv92S/LYVYXw+O8c00ay5EJPQGPbrX+nO3VdvA0RAVKAw3r
         YWQ8bVUZpFj70RPSGtdKpqhxXIQmQGaz7ZmNbOCYwM3TB/gdfBbCx0fOo7Ck3eCbNtnP
         tzRA==
X-Gm-Message-State: AOAM5320IUSbvUYQdXJKJNPFFO2LxrPyZKahLqDeA+vtg/tWlSs+5jwO
        rzmmky3dQRN8VgvGEKhOmHi0Kb7oJEU+GA==
X-Google-Smtp-Source: ABdhPJz+k+Df2dO63uMhLwMEC/DcpljtBNRqm1/V9TeZ8OQotOTSewlPXBblKC0zn1o4qjn+5485+A==
X-Received: by 2002:a05:622a:1a11:: with SMTP id f17mr26261341qtb.30.1634078106478;
        Tue, 12 Oct 2021 15:35:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.238.180])
        by smtp.gmail.com with ESMTPSA id u3sm1685435qkj.53.2021.10.12.15.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 15:35:06 -0700 (PDT)
Message-ID: <61660d9a.1c69fb81.2ee57.cd72@mx.google.com>
Date:   Tue, 12 Oct 2021 15:35:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6896099212408589188=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bernie@allthenticate.net
Subject: RE: [BlueZ] gatt: added missing disconn_id's and removed extra check
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211012215151.15772-1-bernie@allthenticate.net>
References: <20211012215151.15772-1-bernie@allthenticate.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6896099212408589188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=562169

---Test result---

Test Summary:
CheckPatch                    PASS      1.65 seconds
GitLint                       FAIL      0.92 seconds
Prep - Setup ELL              PASS      41.66 seconds
Build - Prep                  PASS      0.47 seconds
Build - Configure             PASS      7.42 seconds
Build - Make                  PASS      172.66 seconds
Make Check                    PASS      9.43 seconds
Make Distcheck                PASS      207.02 seconds
Build w/ext ELL - Configure   PASS      7.64 seconds
Build w/ext ELL - Make        PASS      163.95 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ] gatt: added missing disconn_id's and removed extra check
7: B2 Line has trailing whitespace: "is gone at the start of write_reply_cb. "




---
Regards,
Linux Bluetooth


--===============6896099212408589188==--
