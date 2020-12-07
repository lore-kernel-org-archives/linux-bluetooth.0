Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D991AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 11:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A121223340
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 11:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgLGLJY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Dec 2020 06:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgLGLJY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Dec 2020 06:09:24 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FD0C0613D0
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Dec 2020 03:08:43 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id d9so4381899iob.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Dec 2020 03:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/p+bMBWeAwcvsJBpuwW9mxoxiLhOeXjS0PjZd6Ca4YU=;
        b=eZY+hF5ak8MIkm4ljuVC7nwZpTObzD2eeWuqPfnRaitbxYGB9EKgrHOHbehkjknYhk
         i/W4QvGGoxDIKABOs/f7wZXjzKo0pZslUpuogAhEvusaxS1Ui46O0c7Cde32WJn1+yNP
         rMvDCgQQdrPQ0tyn9JIlsPzXq1oOTOPnFFD+MooXrtRMBQA5+i3r56Wop49ieNOgJwgS
         nYfYy3zpAVjkBAYy0yni9gHBtIeKSNqOJH/asMfAh++1eFxseH9Pmr7iAt56nmzpCVmC
         ATzjxXWAaStR7vFW3jAdVABCXrU3Nmx9kUH5Woy8P5LwuAUywOrQhVa7UJR2rIb4hkUy
         eunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/p+bMBWeAwcvsJBpuwW9mxoxiLhOeXjS0PjZd6Ca4YU=;
        b=KfmEjctg2g7YZOoIxVfU9SwoRUatwB/dPSOppcHlQptEAyBZ4JZvTtCmp7jV06o2B8
         cQ686BrWBtWXEetvrTPL0wHQGWyUf5zmabugWUNBVtI5KUT0CEr5BOMzmAWpemtX7ToG
         zX+P/c4xQ/Q0Fq41UlDT+HKMdiNfHCrGQJ1xKWulvqj4K6kVwFebrCkvcJbEeqFSrwPA
         +CZmZOL5M1wbiwAJf+rmRJmZlXKAI1dWJGNIlsGtkce1x+ve6TSahwuX9+pgwc79T1EJ
         z+5w5xXByDtVUfN5mV1ILGZ6/3RUnLl04LbyJolbKu/RIPkuUci9k9wz7Wlk2ZUdk2PU
         FBbQ==
X-Gm-Message-State: AOAM533a+lMMZDB/69v07ItDkmq3iC0CQi3ENXnECuhDJyLtAouKLpFR
        o2gLIdG4TYQpoFBXCXcNeVEicjCXx9o=
X-Google-Smtp-Source: ABdhPJzLQrGzZ22AgZlCBmX6vSjaa/4JQEymXdBacUD9VFCY2RCnggc4jkGdHkZOKPdot4KnWmbGUQ==
X-Received: by 2002:a6b:b7c4:: with SMTP id h187mr19966678iof.76.1607339323173;
        Mon, 07 Dec 2020 03:08:43 -0800 (PST)
Received: from [172.17.0.2] ([104.46.123.153])
        by smtp.gmail.com with ESMTPSA id y13sm5969849iop.14.2020.12.07.03.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 03:08:42 -0800 (PST)
Message-ID: <5fce0d3a.1c69fb81.79e14.2139@mx.google.com>
Date:   Mon, 07 Dec 2020 03:08:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3077567282784338452=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: RE: Bluetooth: Increment management interface revision
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201207100209.128306-1-marcel@holtmann.org>
References: <20201207100209.128306-1-marcel@holtmann.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3077567282784338452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=397459

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============3077567282784338452==--
