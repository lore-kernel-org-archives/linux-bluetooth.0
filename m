Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C13C001DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 15:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbjHBP5K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 11:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbjHBP45 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 11:56:57 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5CE26A1
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 08:56:56 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1bb58b4c513so5370244fac.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Aug 2023 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690991815; x=1691596615;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x6tZfRMptKmKQ/mFY8/LCEXjkl7dJqc0a8DolIhhDbg=;
        b=PznT2s+sE/tUs+oV8Qscp9gvppdIFUdN9URNouklTN8NamRREbkIR8ybBc+kWbhdCw
         SorICmWLqhJB1SKko3VaXAdlut2AnJ8a1Y3ve2ht5HPHdQ+yRmmcP3b0Ljg7tqBChA6T
         auQK5Fbymj7UJCJXLyEF2bvxRBg3MYxJ2fYZWmI6XqKXvxuVqosQOnmcj+qflk3p9HgV
         06y4V7aHqHz/G0WLLZK/rtP9afVjSniydiFz6oCLKX3xNsqNWb/2JbTsoWMpOON1qH3P
         Mv4Ugo2Ce1Y7DgGhm5FYKpEOdEqfzaopMTyL2f0AHI/N1F4cun8r3FK6LMzrc2qKkdTc
         MaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690991815; x=1691596615;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6tZfRMptKmKQ/mFY8/LCEXjkl7dJqc0a8DolIhhDbg=;
        b=WfE4BRzRL9RY8vDLi9dkPBhXwvBMlY8L8L0lI1sYqhoKxp91LB+hGeOScICOxv+ucG
         g4LewE2UFDyed8d4zTa6T3Eimue6fn9E68WbpxIVSHfkJ+4a/jIoPnEe0dIrnw9A6pzQ
         cWGUlX1FegeeZOHdZAe7mNe5W2o8LKmoBQ/Cg5sV1Pp+sXYiLI8QIW3Bza3MbG0cxJDG
         goKf3v8d0jRDdyXnzGopMvQ6eCfBx9gnqdLVmdPsI6/QnA9Pl+U6mSRdberlxJDCqgGN
         DZi/lAX7J59++tJDuny+Nq4kA/4A4kh7jUBdooibBd0xxQxPLwZi1N0+cwPRY3dKU2Ey
         ySvQ==
X-Gm-Message-State: ABy/qLZ6/C+vi3+O5G/SHSzafdpxN06dVaxpTR4fJqdKMzCfBBN/6qnm
        7KsTQ7XpSThVYYLZPZh5/9LWdIAOp1A=
X-Google-Smtp-Source: APBJJlFxZY702UFYxiwpCqhdIjbNnlk8+bLSw8dHf/hq++cRu5gL4+qo43QOrqvSM0RHTMY3B/9O8A==
X-Received: by 2002:a05:6871:206:b0:1ba:ddfb:a5b3 with SMTP id t6-20020a056871020600b001baddfba5b3mr19894270oad.44.1690991815199;
        Wed, 02 Aug 2023 08:56:55 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.140.173])
        by smtp.gmail.com with ESMTPSA id 68-20020a4a0047000000b00565fcfabab8sm6502739ooh.21.2023.08.02.08.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:56:55 -0700 (PDT)
Message-ID: <64ca7cc7.4a0a0220.745f4.bc61@mx.google.com>
Date:   Wed, 02 Aug 2023 08:56:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3601118428361256556=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Add support for BAP broadcast sink
In-Reply-To: <20230802132355.4953-2-claudia.rosu@nxp.com>
References: <20230802132355.4953-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3601118428361256556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=772179

---Test result---

Test Summary:
CheckPatch                    PASS      3.67 seconds
GitLint                       PASS      1.81 seconds
BuildEll                      PASS      28.39 seconds
BluezMake                     PASS      1068.10 seconds
MakeCheck                     PASS      12.93 seconds
MakeDistcheck                 PASS      164.14 seconds
CheckValgrind                 PASS      267.38 seconds
CheckSmatch                   PASS      354.46 seconds
bluezmakeextell               PASS      106.80 seconds
IncrementalBuild              PASS      5253.67 seconds
ScanBuild                     PASS      1103.91 seconds



---
Regards,
Linux Bluetooth


--===============3601118428361256556==--
