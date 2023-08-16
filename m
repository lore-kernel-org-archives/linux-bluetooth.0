Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F359C10F19
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 19:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345389AbjHPT1l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 15:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345422AbjHPT1d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 15:27:33 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239461FCE
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 12:27:32 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76d77cf99afso33617785a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 12:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692214051; x=1692818851;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0YKL+2wwuDKCIydxpNG/hxnlHuBTiTG692kIglrDdOo=;
        b=QKNDyq1h7aP/zyXwx7TFZwniTXne3pBwHfh2VyPF2dwfyjHQq7HGudkG13ygKlBfkL
         NawTvsxNcGloYWhoT8bBdVyZTIbLB/KNSV+LsQT6uYTt/GqidULnuDaP/lx7r7HvKNQv
         AAzl4oXctmZOBnL/75MTFjpHXrgtI9fSGPTrE7D9+W3O+Rt7KMGDVHpqMwycTuZKIBxP
         f9bF6RynX8+lxzQYSjn244z0tWkrCBse0l12E8msbBjY4AZTNyjitHfjLt1kNoksavj1
         j+GmpfT9UI7Y0vbiiPLjGAw+LKibVEfDK+GYgWO0sO/tprCW/CbsXr/iN0ChD1yO2h7C
         HsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692214051; x=1692818851;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YKL+2wwuDKCIydxpNG/hxnlHuBTiTG692kIglrDdOo=;
        b=OlTpx0iKex5ZTd1zReeL4ISG5mIdTE45yuD5BjFrbiCe2+MRHjX4486g3wYm78/XWX
         4r+3550/8D3qosnJoVJMInwCYTsL31X27+UhkFRoGL5SUq2hu5F3zEGtxe7l+w911Y9R
         x/eVx5fCAO6rFDtwCvnQG0XmBNRyFEfEPZbiYedTNjyyr6QtuYzlfvr1RcQPmhzF5FfM
         X6L5W02FRnqP9dNK1vsseg5ZDMLI8aJzr62LaSai1g7m+KimWM7q60cAYUMNcPckfFwc
         MpJqXyUN0iKDBp6QCcRbvm62g0EmIr/8SSnd5Xj77+Q2EXv5hdH+MIh5TTaYkUwE1vZ5
         h3Qg==
X-Gm-Message-State: AOJu0YzshDokRhgAne6y5jiyQGCMlT/1ddOhxUoSOTs2xRszz+1Qg6XR
        UDQ+ObvcmPu2QZmeWaIGMhjnaf5dDEQ=
X-Google-Smtp-Source: AGHT+IHWVd92CtyB7B+ny/QzG8hCYPENWG3TurLEmoA7pOgTycx4EB52MUS8oivFPyqwpta9Y/cnHA==
X-Received: by 2002:a05:620a:4d9:b0:76c:c636:4772 with SMTP id 25-20020a05620a04d900b0076cc6364772mr2838562qks.65.1692214051133;
        Wed, 16 Aug 2023 12:27:31 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.73])
        by smtp.gmail.com with ESMTPSA id y22-20020a37e316000000b00767dcf6f4adsm4570215qki.51.2023.08.16.12.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 12:27:30 -0700 (PDT)
Message-ID: <64dd2322.370a0220.6db46.495e@mx.google.com>
Date:   Wed, 16 Aug 2023 12:27:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2367270135539527757=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Add support for BAP broadcast sink
In-Reply-To: <20230816164435.5149-2-claudia.rosu@nxp.com>
References: <20230816164435.5149-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2367270135539527757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=776703

---Test result---

Test Summary:
CheckPatch                    PASS      4.80 seconds
GitLint                       PASS      2.58 seconds
BuildEll                      PASS      28.09 seconds
BluezMake                     PASS      906.09 seconds
MakeCheck                     PASS      12.59 seconds
MakeDistcheck                 PASS      162.47 seconds
CheckValgrind                 PASS      263.52 seconds
CheckSmatch                   PASS      354.69 seconds
bluezmakeextell               PASS      106.84 seconds
IncrementalBuild              PASS      5182.61 seconds
ScanBuild                     PASS      1101.46 seconds



---
Regards,
Linux Bluetooth


--===============2367270135539527757==--
