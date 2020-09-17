Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD519C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 07:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93DB52072E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 07:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTVOfMhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgIQH3w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgIQH3v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 03:29:51 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD73C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 00:29:49 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d20so1298338qka.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 00:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=V21v6IHH7VWvFFcnd+saX6v3K+b8G4CsnPueVNLEgAU=;
        b=fTVOfMhUMnjpXASNdfFkPyEvGswSCpjJwXeszCon7c5FVs4BzpiIuuBeT4GwgahSPL
         hbztXvL26g29yCoKWghcSFVKLz3psiYAN2DF1kM7nLfIlpeh5PkFOADivTvavrZMPJjU
         wj47ooH1xUIns3bBr+5Pn9YAf+RBIk2nDlcK5rvi0QmylIQTPFcqRtsXDMHpX6eTfsHh
         hG7DSTZnKQAnKhvnklvoDBr/wpBVu4a+cK5NvSUJJT5Vw+kkRs40bJB21iZswThXJYkq
         ULnZT4dXZSxDnVHR8gtBeUPsqe5srL3Jedpgo4nt0wzTx7O+AYnS2XL+fl+s2ZAISCHv
         C0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=V21v6IHH7VWvFFcnd+saX6v3K+b8G4CsnPueVNLEgAU=;
        b=da7r+rdgG7ET1QUHnjt067IGqrvh+Sxp6QbFEExaToBx/XM+nE7V7PkrZ9gYaqTYn1
         46nhQ4sJlrEhsD6dWVsxYPmIDAYunlu8+rCDpPbJvJkXVdcpko1sxQIEVD00i4hJAbtm
         HYUvdJqe6rNdYClkthtPvTsaMz9LI+fJWclS+Ig0QchRYZb5PJyMVQYdn40jG0wfCsPV
         0FJPc0d0U+ITVASkjR2vK2nnsCMLCVp568dp4h2dYXws0OI6EndQ/RCcdtmC0Q2joNxf
         cYblNFl7Cw5jeTV9wC9lmRh48ZOLzrMxg+taud8FjE7nLuMBAlqCLdPtNfz8pv7X6jNo
         gfhw==
X-Gm-Message-State: AOAM530A0qDB4sm6mgerJXUUI9NAcv5AHL/0BSgE/sOilIMb35o6HLBw
        FBUwDN4RceHW/axk4BT/gSEXb97fQehe+g==
X-Google-Smtp-Source: ABdhPJwlLv3KTNTjJhsY2LtY0guurbjW3fHVC4/dqZp0Mg2gPykWDUO3esmqQjejaaUUhPWhzzarhA==
X-Received: by 2002:a37:a414:: with SMTP id n20mr27404635qke.332.1600327786701;
        Thu, 17 Sep 2020 00:29:46 -0700 (PDT)
Received: from [172.17.0.2] ([52.177.203.159])
        by smtp.gmail.com with ESMTPSA id e13sm20429563qtr.85.2020.09.17.00.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:29:46 -0700 (PDT)
Message-ID: <5f63106a.1c69fb81.7d82.ee0e@mx.google.com>
Date:   Thu, 17 Sep 2020 00:29:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5572227676192822176=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v4,2/8] adv_monitor: Implement unit tests for RSSI Filter
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200917001020.BlueZ.v4.2.I5ae05701b2b792a3ea2ca98f4a5d977645b1afc2@changeid>
References: <20200917001020.BlueZ.v4.2.I5ae05701b2b792a3ea2ca98f4a5d977645b1afc2@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5572227676192822176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#161: FILE: unit/test-adv-monitor.c:1:
+/*

- total: 0 errors, 1 warnings, 512 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============5572227676192822176==--
