Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7798DC4321E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Dec 2022 20:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiLAUGL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 15:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiLAUGK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 15:06:10 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B905BA518B
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 12:06:09 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id jr1so2340197qtb.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 12:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QnXpXUTR6SMmDBotV/Jd7NN40A1YBtCgQ7TO48hU3k4=;
        b=H/oFt2ijXPHSVq/94VHGV8pGubXNtWzC1UX2DaUNboJ/DrWWqvYra87vug1SAFU/Fi
         Q5HKG2N4FOaXCEkDNTfnW9+qrAYOrSTDcZi+qFPD9XD1Oj+LbFYv4GVJuGbHOHBdmiDc
         U7mZVpgdv2IYLM10l4F9A5a1IN/r8rK98q9YKwSgHMkrvAJ+WMTwDtvAzedFQ04yY2t/
         w/ARMy/jfw8lsz7QreIJJGHBR6T7mTcBLUgh0AYuNBcl0aunPso54s5uypD59GMaeMX6
         oSRQ/wL8ZRtzHRvjEMgR4MffuXkuNn+sfc7hOPRCbmQhshzTLtKjqALrKIHaiXdG4bfa
         Wkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QnXpXUTR6SMmDBotV/Jd7NN40A1YBtCgQ7TO48hU3k4=;
        b=dyuMnla6yaoVwzZYR7M30OiiCaWC1AE248wKpuxoC1V7Tb4jwl9VFaamFrr/U86xLC
         ofkdo1PICozRNbD9zLDF8vr8cHAGzAite2VF6vWALOw+h0VAR46H4c/fRv7iSEUVuPTe
         Ia/uYpCEnnz+5VoK/wkcB1ck2FmQW0jOlNCevlq8zf0h/zhQv/aI1SOYWfDiiRCHyFA/
         duCsdVM+NH79cOyj8Pk8Mc3LvDUJK8x95Hb5aDAxROk8hoFblwe36WVoEznQzlGIIcaj
         cHwSEo4Jtoc/Tk1tbaXQIxVp/8yzh8VIej2spmRHjtcn4WYjZER207g5NMULGlPR79mK
         GkQA==
X-Gm-Message-State: ANoB5ploHndGfetG8kYJe0U5RUwXHN1cDvu27B269cpqn/phiPVRwzld
        y5xTY6mysl/OdhiQYCXGJYwRSuFh/sGnfg==
X-Google-Smtp-Source: AA0mqf4Gbdy5l4/ST09OuBrNyVBmja4mhcVFThHXYgIjdrar9DjBK6pKDhD3rQMy0bWKIPQJYgiobA==
X-Received: by 2002:a05:622a:5c06:b0:3a5:a41:728e with SMTP id gd6-20020a05622a5c0600b003a50a41728emr62973293qtb.46.1669925168795;
        Thu, 01 Dec 2022 12:06:08 -0800 (PST)
Received: from [172.17.0.2] ([172.174.18.188])
        by smtp.gmail.com with ESMTPSA id g22-20020ac870d6000000b003a696a2e223sm410303qtp.85.2022.12.01.12.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 12:06:08 -0800 (PST)
Message-ID: <63890930.c80a0220.db10.2b68@mx.google.com>
Date:   Thu, 01 Dec 2022 12:06:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2400319697366982445=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, allenwebb@google.com
Subject: RE: Fix spelling error in the commit message
In-Reply-To: <20221201184848.4061303-1-allenwebb@google.com>
References: <20221201184848.4061303-1-allenwebb@google.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2400319697366982445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=700956

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.37 seconds
BuildEll                      PASS      27.16 seconds
BluezMake                     PASS      873.98 seconds
MakeCheck                     PASS      11.15 seconds
MakeDistcheck                 PASS      146.04 seconds
CheckValgrind                 PASS      243.63 seconds
bluezmakeextell               PASS      94.74 seconds
IncrementalBuild              PASS      712.61 seconds
ScanBuild                     PASS      1013.02 seconds



---
Regards,
Linux Bluetooth


--===============2400319697366982445==--
