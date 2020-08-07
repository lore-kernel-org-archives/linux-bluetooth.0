Return-Path: <SRS0=11Tl=BR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E935DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Aug 2020 03:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A41221E2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Aug 2020 03:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLPOZQJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgHGDtc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgHGDtb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Aug 2020 23:49:31 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C13C061756
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2020 20:49:31 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id b2so174104qvp.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2020 20:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=szxJQP+sEk661ULD0Fm7uL5R+vWdcxCH+iUQg7SvJG4=;
        b=LLPOZQJrT8DXRl3OUjklo9TO960ZBqP+4M8bniNGRSbNuSDwW0tHv7gGwqN+h9SWtP
         kl50EsLIDGFySeoQC62TlBF9nxddebsjpwqbZIKipPJaCNCQ+j863nYnmuuB3t+sUYcc
         aRSgOOZmEuhP+w185Em42bwMqUoabvBG39LWWiqRK1x3XdNRd5dg3Ql7eKJK9pDm/AMz
         NTlRpVoeXRxRmeRFa8xDrWYvXdRKAvVGdnntyCqCGBqpD65dQOYtG2HNBivHMeIXNNQS
         Sp9Wm5ZSib87Z8XrgtuRL3PH0ZSqbGo5FtaIvWBnjtsy6pRUaVwJlybP0kNmSYHPthzo
         p2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=szxJQP+sEk661ULD0Fm7uL5R+vWdcxCH+iUQg7SvJG4=;
        b=QF/Ic8xaBaJUkzwu5vpSDdCXCzh/mtcgoSEcOLiEchd5X3ooKTVxCrTpEduG+qCGLS
         /2JH/vNW0wG1PejCKjQGMcqbb3fVpVPo3uk5YZOo6s4iBGgVT9VRUBm+YPGmpokKDP57
         x5qKGWwPESLg9ZZx8BFkAqzFp8AprYjvUUOK46mt/C6yBo3AeLAZ020DDBFkG4ttKD27
         2yGEws8DtXZ2keHD2z3+2aMzBrtqoz4gMZqifiFkqabOxklmw261d2CIHAclMd9x6+0a
         v/GdJyXlHT/DkMFjAHukE+ZL1A86wSRk6ba0DwTWuhp5L8dCWsN/uPd+sQTAvH7RCpq0
         w+Qg==
X-Gm-Message-State: AOAM532/X/U7KHbb6EOTtBa/baFP3NFo3r17+4Uxd4Z7T09b6Tvxm3VF
        gJh28sZWvwyLmNTG9LKvhtRTwzM9f4E=
X-Google-Smtp-Source: ABdhPJwpDVrZpZYN1QR08eIVGbhoHDN1CyQhGGkXUj9V82SUvm5PR4seyJKHGnhgFD++7eQr/J3hlQ==
X-Received: by 2002:a0c:b791:: with SMTP id l17mr13206725qve.44.1596772167157;
        Thu, 06 Aug 2020 20:49:27 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.91.70])
        by smtp.gmail.com with ESMTPSA id t12sm5706430qkt.56.2020.08.06.20.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 20:49:26 -0700 (PDT)
Message-ID: <5f2ccf46.1c69fb81.4f4fe.eb7e@mx.google.com>
Date:   Thu, 06 Aug 2020 20:49:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5005600605274241964=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ,v5,01/10] mesh: Clean up handling of config subscription messages
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200807013834.123263-2-inga.stotland@intel.com>
References: <20200807013834.123263-2-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5005600605274241964==
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
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#398: FILE: mesh/cfgmod-server.c:744:
+		/* Fall Through */

- total: 0 errors, 1 warnings, 811 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============5005600605274241964==--
