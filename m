Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD009C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 11:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994492075B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 11:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbhA0LlD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 06:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236850AbhA0Ljs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 06:39:48 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3175C061786
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 03:39:07 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id l23so1078123qtq.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 03:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=9QkCUWbxGoT1c7FZq3iAcyc/fGV4Mv5PG5jTlbKbI1E=;
        b=RRo/34RCL0r4VXWRb3DUwEnKrD/hBspaTYoMnsc7D43ymzc/qRu6Qf39JKme8GOemZ
         jWkzFoCF93bUcvXl5U6yEgFf90JtqsZGWtrpl5/Q354KGzXp4TRDyLB8TQ6QOpDJjP1X
         HwGYGMPuUajT98CZREFUQ2t4e+AWsdv4BCAEBK1HnqBTkmhsJAMsGvl/nB29U1yRceso
         Ws55h7Xh34UKUgArS3a9+3zJMqd7uklmPQU5p5b6/4A+iaBHTsFqScsOa5R8TNIFcN5Y
         LsZCeu3KP4B6i6QrLbTxiuKEqdZeUk+8nRjMRrIaxEWUsz0F2ftQUEZmfYxj8kO+G9+x
         rqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=9QkCUWbxGoT1c7FZq3iAcyc/fGV4Mv5PG5jTlbKbI1E=;
        b=M/AYiTApMYNiMrSO9JNHWNvB4ukS9SaQSKntWzl21QXJ8VxkSLXDNpkQf0Cf9B/yIx
         wpQxk0suyUkiMeE0RwlmQbplsH4Gs5afOTHl25klOiO5kDIxjMKYn4q/6I40mX1LGgGX
         pY4jPLx0lSW6yjos5/i/p5CNJyH0p+stLpPYSD7TsprK3JKL5D6MiARMtUsisgW/DxN1
         p2R+ZXS5887sdQZKpr4clye5C1Iv1oh/+wHhRes1brgjIa/oc+F/F2KjtXPNR8Y4CoHu
         4Wo/uOCXdjSh9iryG5OeAXcQzNJR8H3i08SthYgw03AF/6Sn01PvOHEzQLCV4bRDPY5p
         q05Q==
X-Gm-Message-State: AOAM532ZoTqWAEM7Gud4cB4fnAuHHjkFJHtbCqlZ0/gbsxqZvEk+nzGT
        E/rCnA+f3974A1BvfxEAp7cBBCcshWgbv7iN
X-Google-Smtp-Source: ABdhPJwWgDPxOVvJP7z4I7S+yAjgOvxDqnUqO9vOboW4vehZh2YIS4hqGj5CFuSc2lPl5G36NPh43g==
X-Received: by 2002:ac8:5852:: with SMTP id h18mr9216499qth.357.1611747546847;
        Wed, 27 Jan 2021 03:39:06 -0800 (PST)
Received: from [172.17.0.2] ([52.252.44.121])
        by smtp.gmail.com with ESMTPSA id l26sm1075324qtr.36.2021.01.27.03.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 03:39:06 -0800 (PST)
Message-ID: <601150da.1c69fb81.72a0a.686a@mx.google.com>
Date:   Wed, 27 Jan 2021 03:39:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4772767998515026961=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v3] tools/bluemoon: Display FW version of firmware file
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210126182430.84718-1-hj.tedd.an@gmail.com>
References: <20210126182430.84718-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4772767998515026961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=422835

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============4772767998515026961==--
