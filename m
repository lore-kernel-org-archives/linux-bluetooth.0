Return-Path: <SRS0=RRj3=DG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA24C4727C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 21:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 129AD208B8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 21:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1xmow0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgI2Vwl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Sep 2020 17:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgI2Vwl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Sep 2020 17:52:41 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBAEC061755
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2020 14:52:40 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id x201so5655563qkb.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2020 14:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=47uCPr90dAinoznNZLuDa0SrxuuTjX8aJTjiN5ykcS4=;
        b=W1xmow0wiGI2FV9GkuSt83+CLHc5d+qAf+0RCjVL/l1DRWm8KtbNptudXlPw+4wSz8
         gZQrZFjdQbwBq9ocAN01XNk19wrf6uL/HFzWT+1spWk5QyhJ8kluMDL9ozIPU1jTfTWI
         fMptHRHnK5XMl3G/USacTa12Yps1y7ljE2qyePGxAbXCCfZztq4AekugdVu9/c3lfQLP
         pi6m/Ef/5elyn4gmNRkmKU0q25iNwuT16A6oGLNQ9hMYao+zknRgEWI2dQ4Pfism4KIr
         wRmWCdNS95pVpUZ4xKBFGYOlC8sEtdbj+5M1eoEJxQ3HmNxcvMBLdQRr2DJKJ07lYngA
         hOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=47uCPr90dAinoznNZLuDa0SrxuuTjX8aJTjiN5ykcS4=;
        b=k3A0iOULcMIyzk5JIpOAoOKh1hrUarnAPew0kr/IeKC4W0FMTK62DPKr1Qfe9GzKIF
         sIF8B2mxIqk40W7GHJZI8V3X7DLfj/ZKkJY0QsLNvguDWX0rUuqTusiYhGiqztINerRL
         IEKC4oXcYnpj/cVY4v8UqlfBtpXv355i6b5u1cLCAYaTKZFM1Jzf0eUQSZ70J2lkgve1
         mSOfcErIib6Epyls5PrHSb/BM/f5yQquDH0c/NllfmbNagBxv5bGzuaFFg2z3Haz6nIj
         yObe0msfN0zZdtBsxcU1Rf68tKznZ3W2tYAqtaaiJUB2HFSZiVqjCykorOVxzo2K3Rd9
         Xybw==
X-Gm-Message-State: AOAM533CFtXcpFEX1ALg9m9PqTz1htT/SW4thbTN23jQ1/QD5T08UQl1
        nb7UQYsR0qFhiS1kf3eVmrn8wRNirHs7ag==
X-Google-Smtp-Source: ABdhPJxD9Gs983F6EbNlFYGSc+AnkoNqNHREMeJ1B/caNYm/ImIgMrfui0NpdLtxaA8b9x1HSzotvg==
X-Received: by 2002:a37:aa12:: with SMTP id t18mr6447210qke.236.1601416359970;
        Tue, 29 Sep 2020 14:52:39 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.77.140])
        by smtp.gmail.com with ESMTPSA id t20sm6281993qke.79.2020.09.29.14.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 14:52:39 -0700 (PDT)
Message-ID: <5f73aca7.1c69fb81.2b70f.8dbc@mx.google.com>
Date:   Tue, 29 Sep 2020 14:52:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0479370802791815974=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tedd.an@linux.intel.com
Subject: RE: tools: Add SPDX License Identifier
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200929212448.64395-1-tedd.an@linux.intel.com>
References: <20200929212448.64395-1-tedd.an@linux.intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0479370802791815974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=357381

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


--===============0479370802791815974==--
