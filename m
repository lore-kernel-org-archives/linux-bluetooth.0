Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A4CEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 19:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjF0TvR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 15:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjF0TvQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 15:51:16 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFAEB1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 12:51:15 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-635dc2f6ef9so22555856d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 12:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687895474; x=1690487474;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WQC2I/3QyaENHjDTvp/ioW6Lsssi/pSiKLUH9pYVh74=;
        b=m+DYzxgRVHp5Prj1x+XE+/NIEsSK7FAWgiClTPLbGrEgda1gxI2NT8ZhuwE0zGyObv
         mdiPx9nEaF5nGSNh131gMsZBWc1Ny71Epivajm3R+woxgXp6B88IaI0r0IUvjcKd274j
         GtkNTITj/dqWocYKBXp9/cyZl7O8gJvx2u+nn1URY7atgqdEdynYxV3F31jr+LyZ2u7Y
         GELC79ss+3CJM116Vq4L3PTZOOLwSqyxyjv3Aepky3BwfKZrm1UDaKnUb0OzaYOUYl9I
         SK6pYXWW0lCe1+6YOy7fpgwNtUMwLorg1z1LuATGuy5TqY2zbtPFHRfHB9G3e+wyBveJ
         Omjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687895474; x=1690487474;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQC2I/3QyaENHjDTvp/ioW6Lsssi/pSiKLUH9pYVh74=;
        b=DF564AB/xBJ3z/kxo0lQhgnfiV/p9niSdIcINGQTLHiPzrbW7DU/Nyf3fhf4/Crxrj
         Q3mVlCFQSrjU7Upf6plFZGc0VHzSltOCUPTDdW79tT9ddF5W1cGd03oqYa4dn3Ac1H2f
         S9o21YL42piAhzlIXGUv4/i23vfV3C7lakQvNmUxL/6HA/25WFJVtd8Jnf9vIx/+Ojvb
         BC36pOD86HrBNDlS2wFHWbCqG5YjxH7CAP7+Dx11Rn0WAZdUwMVJtjIl1cqfxZBA2/E0
         gws/RCSwDnCsjm/LmwTzhpQfmf5ObCJHB2NmdU3G1WTHKohwmDP8BjIfW0yXbhi8wUb7
         kXZw==
X-Gm-Message-State: AC+VfDz3jPy4W36Ib64o97yW1GOnVNKka9Z7i3DM1Gld719lyg2dDh22
        /l5JTzZaNc7Xn/UiMaMjCSehucXfX08=
X-Google-Smtp-Source: ACHHUZ7PspCoXyPE1hWXmSAd99/YwZFeQB27ruW9SsacPzsSIHwvatNjKScQSRBS80iGCy0LYgIvog==
X-Received: by 2002:a05:6214:258a:b0:628:35b0:e966 with SMTP id fq10-20020a056214258a00b0062835b0e966mr37196707qvb.21.1687895474126;
        Tue, 27 Jun 2023 12:51:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.39.61.89])
        by smtp.gmail.com with ESMTPSA id ml17-20020a056214585100b0062e167dbd0bsm4905070qvb.54.2023.06.27.12.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 12:51:13 -0700 (PDT)
Message-ID: <649b3db1.050a0220.84e13.b1aa@mx.google.com>
Date:   Tue, 27 Jun 2023 12:51:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6511153495333713565=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/bap: Fix parsing of vendor specific codecs
In-Reply-To: <20230627183446.2488049-1-luiz.dentz@gmail.com>
References: <20230627183446.2488049-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6511153495333713565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=760713

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.38 seconds
BuildEll                      PASS      33.24 seconds
BluezMake                     PASS      991.55 seconds
MakeCheck                     PASS      13.32 seconds
MakeDistcheck                 PASS      189.82 seconds
CheckValgrind                 PASS      309.51 seconds
CheckSmatch                   PASS      409.12 seconds
bluezmakeextell               PASS      125.85 seconds
IncrementalBuild              PASS      818.43 seconds
ScanBuild                     PASS      1297.89 seconds



---
Regards,
Linux Bluetooth


--===============6511153495333713565==--
