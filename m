Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A101C41513
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Aug 2023 20:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjHNUep (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Aug 2023 16:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjHNUe1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Aug 2023 16:34:27 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE88E5E
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Aug 2023 13:34:26 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76595a7b111so315298385a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Aug 2023 13:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692045265; x=1692650065;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b0X+fLlfYkvVgdxz3arYI160CjCjROFp81xi1AEXZX4=;
        b=IA3yff1HHi1L+B1VcmGB3HU1Au2VQ0nUTVC/dF9M26udq7CZxCzGtMWB5Zfsh5V7Tk
         DocTa63TLJeMVu4vH6HLMtR8a/6tvMnm+ohvNXkTrRGsA2SeYERWw03P4rM3i0fVGaoG
         4rLIyULS3iCTV83bwH08ugBJPcBHYobexOCOBH2kyupiNDEONe+FdIo4GHFNylI6WUL5
         Vsh+shZuoQ6mbCkxU2XhOvD/7HYng9a4gLstikJn+csm0rLoO0LWacvZl+OP9x7Q/rf3
         f3zgc12QVJ9ShHscRDxkQjxjtKSARm71thj98VRPBWVW2aPkjEgflzJwpLO3Tt32k3V9
         fSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692045265; x=1692650065;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0X+fLlfYkvVgdxz3arYI160CjCjROFp81xi1AEXZX4=;
        b=Xe3EYOH07aBKZj9rgL6hJ6lwxogYSp/DQHlaEmTXcEbL1oEJGJ+esbL/iKSVNtFpTM
         eLOPfARbxYam5HXPbFMZ/ADoNLrHGjOzCvY7ZGSGx6DkJO02twkMdBbf3IYoAC4B3BH8
         KRBVIkwRvkQBiu5if8+ttvMuZqB7pPDeogN+wV7DxyH3pEPAjqKLSVt40pR3jwIpJJzG
         Yh1WhrL+Iu/H01ojTxmy2v4aMWc1XVi3mWFuQZtv8IQHB0gPFe0ihoN3wMCsDHBqKu5C
         C1mK3nU0USacweLJSGRtEgnRbeARSVVr4y7C8PMRufccwhaZETXFxwhziU20H3l3GYrj
         zKow==
X-Gm-Message-State: AOJu0Yz/ra4ywDOk2VCgaAxrKsdRAZiA11ezmWQXS15QFIsFnG90+GGU
        a53Ocw5WoW2Ww63mC4dv1udqP/QOlxk=
X-Google-Smtp-Source: AGHT+IExoP4bjpNp9VlsNl0c2DnZP4unolrNtFlvjPb5oP/3y6Q1KivkVYLFHnwjioCoxFMFsYiYAg==
X-Received: by 2002:a05:622a:58e:b0:403:a808:2f50 with SMTP id c14-20020a05622a058e00b00403a8082f50mr13612945qtb.31.1692045265466;
        Mon, 14 Aug 2023 13:34:25 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.202.229])
        by smtp.gmail.com with ESMTPSA id o13-20020ae9f50d000000b00767cd764ecfsm3292447qkg.33.2023.08.14.13.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 13:34:25 -0700 (PDT)
Message-ID: <64da8fd1.e90a0220.579e3.e794@mx.google.com>
Date:   Mon, 14 Aug 2023 13:34:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8637854983278628612=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] doc/test-runner: Update documentation using rst format
In-Reply-To: <20230814191535.2304664-1-luiz.dentz@gmail.com>
References: <20230814191535.2304664-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8637854983278628612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=776078

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.36 seconds
BuildEll                      PASS      27.76 seconds
BluezMake                     PASS      888.87 seconds
MakeCheck                     PASS      12.54 seconds
MakeDistcheck                 FAIL      9.48 seconds
CheckValgrind                 PASS      259.50 seconds
CheckSmatch                   PASS      346.30 seconds
bluezmakeextell               PASS      104.65 seconds
IncrementalBuild              PASS      723.10 seconds
ScanBuild                     PASS      1078.96 seconds

Details
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[2]: *** No rule to make target 'doc/test-runner.txt', needed by 'distdir-am'.  Stop.
make[1]: *** [Makefile:11708: distdir] Error 2
make: *** [Makefile:11784: dist] Error 2


---
Regards,
Linux Bluetooth


--===============8637854983278628612==--
