Return-Path: <SRS0=NBlN=DW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A48EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 07:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE15F206FB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 07:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RisstmN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgJOHcz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Oct 2020 03:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgJOHcz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Oct 2020 03:32:55 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A557CC061755
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2020 00:32:53 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id t12so3027431ilh.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2020 00:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=zv3PzULWOCWl5TTWwWV8WzcRt72z4KnLP6PKNjpuEpc=;
        b=RisstmN9JBfGN77Q2Hk7AHdYhLuINUqw+5RPLgD86B7vXiiP7a3v7qzhd83mArxN2H
         wtqO8AF4YberBT2cWODpgKk7VHwTatlI6zu8SgI1b6byScdyGvkD5dDYvYImxbEPkiIa
         eSPRcHF437KEy74qdkBSy793koWxnkQdNuy1VQBJhOFO/Lp/3MmQyJlZ//hE0Ls/Jpbu
         BLcenDKnvs0z+CzVQ0Ll6cLjXi0QhybZQDm3suuPhEjzxhPY0xotdE6F3U7Ji6grqyoB
         TQb5xtGMBtq2nHOjaurEX8W+WFcZ5BumMaLBrRSFEYjaMmJvzYV8qJAQv5jiBwZGTliq
         0LmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=zv3PzULWOCWl5TTWwWV8WzcRt72z4KnLP6PKNjpuEpc=;
        b=rWZ2HRNQnYSeRxyr7NhhUqZ5McMGz8jYBpE8k1iLWMqCMt0SkgCKbeC/ZwO3bSr2B5
         hFm2PcIsD+aIhvxUUQw6h7Q4sB1nhkvdFvzzwFzhELi60oLjx7jFgArFodsyZRzXfXik
         IC2YntSi/1i7CRJgL1uASlA2/DfUdrJCdMVzq9zALv2GBP/0QaBWnsuyzw4DBlmh7Vg2
         ndSXWdW09okVjKnXzZQIW+kSI+zFbZpeCQ6yXVVb21Yw6FxnoGaUuUtAPdOX9Iu3lDhe
         wgsRA9ekZeedGJ9MohecAojKEMvGCRQ8a42G1cLmuwlhoqCzLNU+rLuktjbBEfIjcrw4
         cs1w==
X-Gm-Message-State: AOAM533n+WKmkwR4aJXXwTPT23q5tblflcIYzdDBNFDOD2OkuPOa9Yr9
        EQJdrlH7cdubommt9AvQ83cWr0sQYc3eeA==
X-Google-Smtp-Source: ABdhPJxKSk1QgsAoDw/TKeNPnhFKibml13UzpmlLm780VqY6RZHzVmaruVYuZM0YSKCN4OiK4ufOMg==
X-Received: by 2002:a92:7f05:: with SMTP id a5mr2373955ild.112.1602747172700;
        Thu, 15 Oct 2020 00:32:52 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.130.65])
        by smtp.gmail.com with ESMTPSA id e15sm1688112ili.75.2020.10.15.00.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 00:32:52 -0700 (PDT)
Message-ID: <5f87fb24.1c69fb81.c9b43.b10a@mx.google.com>
Date:   Thu, 15 Oct 2020 00:32:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5438476048118064558=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, steve@snewbury.org.uk
Subject: RE: 100% CPU usage on keyboard disconnect
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <f6d623eecc635022b85a31359b2f11b0104267c5.camel@snewbury.org.uk>
References: <f6d623eecc635022b85a31359b2f11b0104267c5.camel@snewbury.org.uk>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5438476048118064558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=364897

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
100% CPU usage on keyboard disconnect
WARNING:LONG_LINE: line over 80 characters
#49: FILE: attrib/interactive.c:407:
+		gsrc = g_io_add_watch(iochannel, G_IO_HUP, channel_watcher, NULL);

- total: 0 errors, 1 warnings, 31 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

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


--===============5438476048118064558==--
