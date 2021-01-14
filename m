Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636DDC433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jan 2021 21:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F47823A5C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jan 2021 21:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbhANVtE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jan 2021 16:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728785AbhANVtD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jan 2021 16:49:03 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E40C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jan 2021 13:48:22 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id c7so9854289qke.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jan 2021 13:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=wBrjKt7eKhVNFyzoZiWlBmLXZYnPQqZfGLM/V2V1CEs=;
        b=qg43a7NcCCFot2GnCTjn1QdoKal8Zbp6lgDQGfbElMwwA3c+BnjY50SqrBO6dkMR2w
         6iD78KtNwAEm6ghuUpH5hdeORx3lvZz5IwA9ibBG6mcupu8IoVZEqWJgj278C+Y7iRR0
         CTqr0v86MyRWwy9iM1jRPtIYdn6NunOQ+PeMOFM7R1VIP17YadMilaIs3YpwterNBy2Y
         +Plzbe9j9JvqAZW88HAahPdLLt9XPoJZ2QlFRwI0Gtwg9duS83IUZYSFSFOenXGCyJ1v
         3/CPNERvjKQCS2OHgilgpC2m2wYZSBZqI6jJRudOCeYdU9f4ceo6bG6Qezi6p6AAjznK
         UUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=wBrjKt7eKhVNFyzoZiWlBmLXZYnPQqZfGLM/V2V1CEs=;
        b=UJYdh7USFLulinUd4iQ96qVPEGSxEq+q5SxJ3Ml1K/xqAub2Kt8aW3D5mA34of934W
         /Gf7fJEq7BY7Ry3NXbqsTo4BxkiTBuksuv2SQHgRcdoS5kwesCTFhISilKIAw09Rz8cX
         CC0Jz9jpwWLy/1CQl4Ep5lnXwmOkzfwi4AVG4aIsoRLO9WNgO8dqjqxChlvMMOKhDjna
         mvmHfQPN4iQUeHnqcmjBUkiCYVYHm043XfhgCZ+87quIfA8h0yJakwF+/G60ZT3AKPrd
         OIfmWmYvuYJglGgNKaebN87GxeOTYKt4WD3PbB118OW3ttcCeUZC7kQqNmgHVE34BgBI
         1/EQ==
X-Gm-Message-State: AOAM532DTvCc4ZKgUL6yFULuzBvrG4a0MJd3SZJb4JAVvAQcMXvxre8x
        fVlXwUNWR5FIHy4lYJDJo7+toAs2MskWzw==
X-Google-Smtp-Source: ABdhPJxuVG9EkOfbkoLTWXjdt2Ejg2kBiQXQs9II/tiw8OQJyQcs3LKaxFKbvDP0JQEOT4rH6G2Czw==
X-Received: by 2002:a37:4f4a:: with SMTP id d71mr9348247qkb.55.1610660901505;
        Thu, 14 Jan 2021 13:48:21 -0800 (PST)
Received: from [172.17.0.2] ([40.70.28.82])
        by smtp.gmail.com with ESMTPSA id 198sm3803692qkk.4.2021.01.14.13.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 13:48:21 -0800 (PST)
Message-ID: <6000bc25.1c69fb81.aaa28.943f@mx.google.com>
Date:   Thu, 14 Jan 2021 13:48:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3528426630482157440=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] ELL: Uprev the ELL file list to version Rel 0.36
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210114211322.328712-1-brian.gix@intel.com>
References: <20210114211322.328712-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3528426630482157440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=414919

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
ELL: Uprev the ELL file list to version Rel 0.36
WARNING:TYPO_SPELLING: 'staticly' may be misspelled - perhaps 'statically'?
#7: 
for the staticly linked version of ELL into BlueZ executables.

- total: 0 errors, 1 warnings, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] ELL: Uprev the ELL file list to version Rel 0.36" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============3528426630482157440==--
