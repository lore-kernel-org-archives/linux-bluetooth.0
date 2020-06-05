Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D908EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 18:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3548207D3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 18:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHPdXeuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgFESIG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgFESIG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 14:08:06 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AABC08C5C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2020 11:08:05 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id z1so9269198qtn.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2020 11:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=HyqXrbpEb24BRBjnqZRN3Rv4OdNJMoQBGsX+R2l6CFo=;
        b=kHPdXeuqLUFG+kWoPRhkkwBcxJGW1t2cEb5CsPvNFKNKhhHqwfk7WBFqgKm8TdAU9o
         OgiWT0ySQLlCVVDKWUr/dbQJYQ+EaLyF7iXEQXfNMBE0oGI6SG1DG5WJGKBLIVqt/WUA
         HCn9NjqQReozS8tF8io2I0aCSff2axmnBpfHWplxDkjabpvbsSYN1PI2ljuJ4p6qDRBb
         1at0BzMTmZVm+9ze3jhg4hJ54kILD9Iq9fiqgTvhaqMSvsnneIsNfv2ICP/eExsr73tH
         wHwreDiohF9CuTP0oc1lIZZQbUQCnG8+yEBDM3bG45jzJoaRsOB69TZ0e3bSiGFL+1Zu
         AfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=HyqXrbpEb24BRBjnqZRN3Rv4OdNJMoQBGsX+R2l6CFo=;
        b=Rm39yMJm+BAlB+0q/OEIgRFllemTmL/ys+lxQecGklfsXXUJOdDIyPh5dzyys1tf4M
         I7kRPs39bUK2zhlPLnu+6rfNDPibLw1ElU3tlVmAf3ADXcExy1eGzSINGhPGzlbUY3Jn
         0VUEkpyekhCc1iDOmXOqDtl+9rzSh9KmpdVZkb2LJ3b3Kv0nUDSHw0IYHgcR6A+6IckD
         SXquuCrqHBaLc8MCH5dey1m3RKlU5FhJTID2aF9GRcw4D8tFR+ujSsWggcUdrGItf0nD
         DBcVgpog8HTPpPNfYG8e/VP1MqBddMKdvFHT+gI1qDRqv9up4KLotfxuD3Y7vgVJteh2
         dttw==
X-Gm-Message-State: AOAM531opZUzDbEIkkqBfg7nBITTs3JOxZMwCLOy15S0b0lw9GdA38Av
        jrQETyG0I4f0tAPeqFWU61N+G6RbYj4=
X-Google-Smtp-Source: ABdhPJye5OgaFN8ssj5zIQ/nZAxt2OYqgF3KbjhUTdZ75qdLtgC9a49Hvu3fa55FSxzkc/2kGteiMQ==
X-Received: by 2002:ac8:2df9:: with SMTP id q54mr10983232qta.215.1591380484750;
        Fri, 05 Jun 2020 11:08:04 -0700 (PDT)
Received: from [172.17.0.2] ([13.82.144.29])
        by smtp.gmail.com with ESMTPSA id m94sm426830qtd.29.2020.06.05.11.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:08:03 -0700 (PDT)
Message-ID: <5eda8a03.1c69fb81.8bfb7.2e4a@mx.google.com>
Date:   Fri, 05 Jun 2020 11:08:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1500633911982134849=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,2/2] advertising: Fix reseting NO_BREDR flag
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200605174825.717902-2-luiz.dentz@gmail.com>
References: <20200605174825.717902-2-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1500633911982134849==
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
WARNING:TYPO_SPELLING: 'reseting' may be misspelled - perhaps 'resetting'?
#4: 
Subject: [PATCH] advertising: Fix reseting NO_BREDR flag

WARNING:TYPO_SPELLING: 'overwritting' may be misspelled - perhaps 'overwriting'?
#6: 
When setting BT_AD_FLAG_LIMITED it was actually overwritting

- total: 0 errors, 2 warnings, 28 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============1500633911982134849==--
