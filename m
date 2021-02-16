Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27E9C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Feb 2021 23:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B186D64EAD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Feb 2021 23:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhBPX5t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Feb 2021 18:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhBPX5r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Feb 2021 18:57:47 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E15EC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Feb 2021 15:57:07 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id c25so5513377qvb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Feb 2021 15:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=z2ywCzJjMBioTkvAlWBo+BR6SkKuQq2fTcEQ6cMdx1A=;
        b=pJJil+R+6WwJjdgjQqPTIowfouMotPp79cWXevlzki1jkf66Q4OdNx3u5a/8bYL1Re
         JDFcF5CcHI2MtgvUy0wSLmhcE2BziZwJwNGxkRS/gy8YGQNTqZDCmJoXZOv0GWHzjO1c
         CHM68fL8/zNPy0zAbpIO1mRIXRAmz97QL4eTsaqFTSp/yi9bk2eAXFr3G9Q/jPyowQIp
         HVSF90wXBVXV651Kbxj+W/jYv+Krr6qoE5B9y/YeWfGezDQi4IkqE55da2j07tCw0Of9
         Rmdd+oNafwoqjs5LOkWxS3jacORVu2MBUOPCmAySXoca1OCSkSqncqRVzXqFeLe1TbUA
         HEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=z2ywCzJjMBioTkvAlWBo+BR6SkKuQq2fTcEQ6cMdx1A=;
        b=drRau376PzEOrjfCKAO+IKaMG8hOGZK4ussnrFSBGb9IFyohjmrH34DX/Ch0riWzTX
         Ruv4ksvT0/RffqEDwdC+xlnbRkL8vybs09EHcHvN81INXJjjK+lUrcAUWhUw0PF36C4O
         hGE1VwbTkCEEkiTnzPkhvErvrFh03VEVJP2gM9+Ghl+wVQ0tjO4nKuRvQ/mIz+9sgkV9
         r5L0MYIGI1E+pkQUWyYVSbCXMDABF+zNtr/9E7KtcV3fwK1IFyzGa7/zobRZweXi4i3X
         pIeMuF/pBRnRytWac+hAVwgPrEilHsuT7rhhbU7QA4+RaMxB0WM4oMqSvtteeY6xKgdP
         h/dw==
X-Gm-Message-State: AOAM533517k/vcYQhqQugDgPgN4fODkXzcfbsuLDqm7XAHxmEXztrz5A
        os3N/ivMhEQWY4T073JiA4ksMmL+4ipaGw==
X-Google-Smtp-Source: ABdhPJwKdRcyHt9gLc9/wVD0f0cSfEnvSIg9uskyRl0JygdejAWaFJXsl4iBk7h/H3bGugfTsLybQA==
X-Received: by 2002:a05:6214:292:: with SMTP id l18mr251541qvv.5.1613519826443;
        Tue, 16 Feb 2021 15:57:06 -0800 (PST)
Received: from [172.17.0.2] ([20.186.73.190])
        by smtp.gmail.com with ESMTPSA id d14sm89962qtw.67.2021.02.16.15.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 15:57:06 -0800 (PST)
Message-ID: <602c5bd2.1c69fb81.cf0ee.0856@mx.google.com>
Date:   Tue, 16 Feb 2021 15:57:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0314550375457251931=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/3] avdtp: Fix setting disconnect timer when there is no local endpoints
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210216233337.859955-1-luiz.dentz@gmail.com>
References: <20210216233337.859955-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0314550375457251931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=434305

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


--===============0314550375457251931==--
