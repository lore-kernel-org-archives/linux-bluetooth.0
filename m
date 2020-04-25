Return-Path: <SRS0=4/QO=6J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B4BC54FD0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Apr 2020 02:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25092076C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Apr 2020 02:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ddkdh2hF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgDYCfR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Apr 2020 22:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgDYCfQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Apr 2020 22:35:16 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3364C09B049
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2020 19:35:16 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id p13so5698007qvt.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2020 19:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:in-reply-to:references;
        bh=1mC1sy1xQp39NZKzkPxRGurbngG3lDE6gmrzx5dJWlY=;
        b=Ddkdh2hFecyyTPb3KR3ekhMxWq9MhOltTwYKg4n2eUdnFz7ovtFbzpfVyQrUI6s2eo
         D+vlr+WOpu8kQyR7FXdKwU84kbQWpAY9GqvKET+OTFf0mpiz0uNQb/J3E2GwVrooLoO+
         +DXIZQJjTyf49sfrY0RjDm5xnNG7vSs2R8zuxJ8BVJHrskcgFGHAHHWhv/nLvgB7gisH
         I4I3zrwuQQDrbk+TmXdwGz04W19XOcHU8UDkX0ysPvxqCPs180siF9jOCQ8YoDOKJTRo
         LaR/MzuukjTo4XDo9eum0PVxowaUbIIehx3UfpfAS7lGWjhXZCdCz6zpuNBnmSCA8zQq
         Iymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :in-reply-to:references;
        bh=1mC1sy1xQp39NZKzkPxRGurbngG3lDE6gmrzx5dJWlY=;
        b=izZDvpAP2iX5wEheXKLDcBSRsI+9WRDwE12hw5yd3g4+hwTG1C+3c2fUyVcXSx0lZx
         FLg8AnUfBGayBEbgVTrU5GmlYYZOfw8uzBPb/KKpZ+vPiLUPJEY3hfZKQRFVzD+i6z67
         L3i7z2vL30iAQoR5I0hG58nIOu5oM/jrG+9ZcnavBk+H+hL6JTPFuoRH7mF18U0KHI7j
         FtSjIc13nOeZ0Dn8yp/0fEoCcHQ5PoHcNEEeid9mcROHT08F6LUCpBotAs+gZycq6mpX
         Up8UZWaQvwgPlxv94+W1xGvBEWppH6sjVUCmXgqT9a8qbN0U+04jmlIGMCOEDV7+NP+3
         Socw==
X-Gm-Message-State: AGi0PuYvEzEid9dRbzGj9YYFO5o8tVVP/PIDemsVX23sFor7N6rBzL5p
        Y5OaqAPVeyHcJnCFebhk83mSMyxuNus=
X-Google-Smtp-Source: APiQypJHQAECscnBzTaj4w8xN78zkeIJTbNzkOURCjItJeOTrJcXUJLwrNH3bL1YNYT8V86mHx/Hfw==
X-Received: by 2002:a0c:ee25:: with SMTP id l5mr5059063qvs.5.1587782115868;
        Fri, 24 Apr 2020 19:35:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.252.99.182])
        by smtp.gmail.com with ESMTPSA id d69sm4931621qke.111.2020.04.24.19.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 19:35:15 -0700 (PDT)
Message-ID: <5ea3a1e3.1c69fb81.90b5b.08ee@mx.google.com>
Date:   Fri, 24 Apr 2020 19:35:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3169691382207792878=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tedd.an@linux.intel.com
Subject: RE: [3/3] Test patch #3: OPEN_BRACE
In-Reply-To: <20200424231026.127164-3-tedd.an@linux.intel.com>
References: <20200424231026.127164-3-tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3169691382207792878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not replay to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.


Test Result:
Checkpatch Failed

Patch Title:
[3/3] Test patch #3: OPEN_BRACE

Output:
ERROR:OPEN_BRACE: that open brace { should be on the previous line
#17: FILE: tools/btpclient.c:230:
 	for (entry = l_queue_get_entries(adapters); entry;
+							entry = entry->next)
+	{

- total: 1 errors, 0 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



For more details about BlueZ coding style guide, please find it
in doc/coding-style.txt

---
Regards,
Linux Bluetooth

--===============3169691382207792878==--
