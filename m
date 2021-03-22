Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EEDC433C1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 20:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 115F9619A7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 20:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhCVUfG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Mar 2021 16:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCVUeh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Mar 2021 16:34:37 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356F5C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Mar 2021 13:34:37 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id q3so12057982qkq.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Mar 2021 13:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=G5NT2WkHKbmzau7Wo1KTVugZbGhylvzhOd/btd9V2ms=;
        b=C/dIK/+tVGht6f1Fr9aDi2fphKaJDt+LKMLhqn1yG526T6xxTBv/26eWLB9kQnvvOB
         J2cYrgZEXdcw7WeRFZrgf9qDYR+sXku6ow9PV6UWV1qLj5N/OG2xLVqgIrN+T0kUvpsy
         6daxYlWvJHzNRqDgJl7r4Sh4oRKmamuDCVNBKT5dac+xta3WKgf1KEIZR1CYVymSulVA
         ejdq+iVHcUGutyzkPRiRbdhN5tWBIdZvipMYTVI1r3ZDTvYafnzzcuA+zYLwLdhPdiTE
         /sjOo49eBOnwHNfhHvYelX8bCbfLZ0bx1Lg5tFrmzO2F20MIO0CoxEPGlxzL+E7e6fFf
         fcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=G5NT2WkHKbmzau7Wo1KTVugZbGhylvzhOd/btd9V2ms=;
        b=mh+f7QhvR7ooV+KNXD7iV6yISodCMjyN9C8AmfcPtDKtR1gDDBGYbEQvNCf4HxkHCx
         gQQUstmzkQ8HD89sfXTWb4jmuQeopfHUITiP01Lux2G1K3kRFMcMAghU2nW3oXqSfbtX
         gMiuNAL4xNOWHs1txy3OG0eenvCpH/acFr/JEREkZATCMC3m6xMhumTB/sXV/VqV70UZ
         iSpYSZQ8VnUO+WMh5Wqi0IIpQcmfG9hIW0SdRDE5/INctWZASVExr3xUnYQuu2TSBPBK
         XhxxUDEQ04ht/O39SKdE1xrx0SlC6dGEl91291/j8RklMKroLUjD6QGkWO8s7rUoKbxM
         VYug==
X-Gm-Message-State: AOAM5305QuFSVBSFwBYmq3M08dPvnlWBuo1+UOBNZC//DPvTrhF6+fIv
        evjTOGrN77gfKugssseK9vhH6c5UAu1jYNKW
X-Google-Smtp-Source: ABdhPJx+Mu61tNxsVx7VlxVRHIwDbUGyEovsXs3WvhbiRgJFq862W534cIhRXV6uf6csx9NDwe6BXA==
X-Received: by 2002:a37:6887:: with SMTP id d129mr1990403qkc.252.1616445276212;
        Mon, 22 Mar 2021 13:34:36 -0700 (PDT)
Received: from [172.17.0.2] ([52.184.189.126])
        by smtp.gmail.com with ESMTPSA id x36sm9826243qte.1.2021.03.22.13.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 13:34:35 -0700 (PDT)
Message-ID: <6058ff5b.1c69fb81.80f3f.abce@mx.google.com>
Date:   Mon, 22 Mar 2021 13:34:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7120284202811799781=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] hog-lib: Fix crash when receiving UHID_GET_REPORT
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210322201616.3118617-1-luiz.dentz@gmail.com>
References: <20210322201616.3118617-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7120284202811799781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=453251

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - FAIL
Output:
configure.ac:21: installing './compile'
configure.ac:33: installing './config.guess'
configure.ac:33: installing './config.sub'
configure.ac:5: installing './install-sh'
configure.ac:5: installing './missing'
Makefile.am: installing './depcomp'
parallel-tests: installing './test-driver'
configure: error: Embedded Linux library >= 0.37 is required


##############################
Test: MakeCheck - SKIPPED
Output:
checkbuild not success



---
Regards,
Linux Bluetooth


--===============7120284202811799781==--
