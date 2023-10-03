Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549DAE7AD76
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 16:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbjJCQNQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 12:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbjJCQNP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 12:13:15 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F11C4
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 09:13:12 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5859b2eaa55so718805a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Oct 2023 09:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696349592; x=1696954392; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HbtbfKMaYdxi+yjVUi0jqlOdl5IeWBRuM+d7VyRo9FE=;
        b=TpNn87pPb7Mu7eUN3DryOiE/VPiSF3ci6h6XbrlNJtVcyZIiRTCK8P0d51aVYqZkQn
         FRrob5XVVuTXbq1B76ycgE4mqv87yrL0wLOBTAnZU8nZCmXGx76lqSStHzQ0Dy7QSiGL
         S8HtDEgO2Y2m017FolLW7g92oNkuR8grYZpjMBLwD9XRDnOo6kiZeyoNcT/IrqJ2Clwj
         1k7mZ51hNoRaMdfV2lEj3dg51Drmic9ibPzzTW3cNuNbqxwwzSuzNVIjIa/QpWSlfBJU
         zkpN7iKwseudIPVkw/VHkW19nqv9zj9sjUAs81ZhN2MK6y/MYqVZdGHcOKwkTculEVLY
         evaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696349592; x=1696954392;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbtbfKMaYdxi+yjVUi0jqlOdl5IeWBRuM+d7VyRo9FE=;
        b=svtabCeRxg4125HUi21xWCDj4Zq2MBpcn4/roOiQtQV2BZ3aWTFGUdTEK4w8JEnqr0
         5OBfeAMwCyYYanby0U5IQ5pqOLLQnWfw8/4sXFkNRnygVtK3k+E1MkojP3u/eOZqM/LL
         Wkf850kpplA2vEAu5CmNhKXF7rjjmSGpRU8e0VmPk6bN1GXXWeG1DpLeZG94B+HzxzqS
         d4ebjOxmNU+3qIWaB2QKOstXXjxrB5OWtQ6EZxzDLgdGVYNhq1za69ReAIgtUcULuw4U
         MqpLP4gZICj7I5RB4HCC3d35LlOKPatPcaef9prUsZB+6oUl4Mq7tlqdjl7qGOYtazpi
         /YWw==
X-Gm-Message-State: AOJu0YwMICK53D8yPogMg42kZAmSXwFHI/NOYpEa5ascJdaCV5p8OT63
        gfjGda0ruw+eDkk+ZUQTCLLAhQ1mVpQ=
X-Google-Smtp-Source: AGHT+IHj8dK8P7KOiE02QwtYIxXm78bkddU8fGCpv+sbW51t/PLwgWMBKTn5nAEki9WjIP7xK6nemg==
X-Received: by 2002:a05:6a20:9381:b0:14d:9938:735f with SMTP id x1-20020a056a20938100b0014d9938735fmr15423297pzh.17.1696349591830;
        Tue, 03 Oct 2023 09:13:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.70.69])
        by smtp.gmail.com with ESMTPSA id w18-20020aa78592000000b006862b2a6b0dsm1602858pfn.15.2023.10.03.09.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:13:11 -0700 (PDT)
Message-ID: <651c3d97.a70a0220.f923d.3f93@mx.google.com>
Date:   Tue, 03 Oct 2023 09:13:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7163721563136188502=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: iso-tester: Add test for bcast AC 13 BIS unset
In-Reply-To: <20231003143840.3009-2-iulia.tanasescu@nxp.com>
References: <20231003143840.3009-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7163721563136188502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789624

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      27.85 seconds
BluezMake                     PASS      827.15 seconds
MakeCheck                     PASS      11.85 seconds
MakeDistcheck                 PASS      162.21 seconds
CheckValgrind                 PASS      256.11 seconds
CheckSmatch                   PASS      349.83 seconds
bluezmakeextell               PASS      105.87 seconds
IncrementalBuild              PASS      664.44 seconds
ScanBuild                     PASS      1060.94 seconds



---
Regards,
Linux Bluetooth


--===============7163721563136188502==--
