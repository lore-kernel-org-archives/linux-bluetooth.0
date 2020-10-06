Return-Path: <SRS0=Tswr=DN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846A7C41604
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 15:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C17620782
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 15:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRjRLigl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgJFPfO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Oct 2020 11:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgJFPfO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Oct 2020 11:35:14 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3E6C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2020 08:35:13 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o8so1389925pll.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2020 08:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=FBRxG9i/GMmQyHqaRf9cLCO61wl8TTQCnIsWU75kV5s=;
        b=LRjRLiglfKRQr7FfJt9oSBSVco0KRR5Mrs498wL8uH+YTz+b5UymFHntvqphO/djlw
         nWP5euUPdKJuHS46tNlKId07sbCw4KVfSbz/R93OmHSQpwNjNrhJCelMqHWRCTlzM5u1
         vVmoero7KtGJhqEF/6LPHcVLwhqhIMgqYfRLQ6qVlvysoFBa29ig6ndfdmabvTgGmAkJ
         mu/3MWxY+cbG7Yw6VlApo/v62YiqbUcm9QZXpbMo/gH2i/ZVwKR3ZAaXrZCcliGhT+G9
         FS4X/uU7vd6z4k8Ustm569C350PnWNEUd2iT06y/ZRe3k1nYpeWOiwT2+HMoHq1oDE6n
         sisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=FBRxG9i/GMmQyHqaRf9cLCO61wl8TTQCnIsWU75kV5s=;
        b=JCdA3EzMme+0EqDPnENxqDQMk4Ldi+wkdPTFBYRLlEyhMyiVMRg/IiKtV2itS+uAwg
         R8JKrR6IHlDmfbCL63Hz6bUafJhDHZgNHPj9dzx3/9uNBkUmDTUS9PyBPKZjnzuHD749
         xd8bY+hF7NeOYwYRq4oFWmVV+d4CjIj4kIPRp7Np0E9VL2hAaVOeyOp4OZL5Ka+hUdMm
         YbzcpmWODeQksSlSIf/DqB3HYHTCAfAr7Gh/d9lH+OodwXDW+QBA/knVFKFjR0cDVlDi
         XfB1eVHwGI4WEsctJytcFpBumRwyL4ZntpYy2Zxbe1kO+mijhF7kmBYb4HtVb6beTtbq
         bc/w==
X-Gm-Message-State: AOAM531yFRhJ87SSY6dw+WyLrG7A1LCD9+ukIImucaNaPM9F9c5TZw9J
        ws4nd7vBKerOjov3+v4RY7bGrCPM72M=
X-Google-Smtp-Source: ABdhPJxgBoJBb8s4Q4khE5yyLxwqcmC13bv86hoS+UsbGIn2Zrpo4NlJY9cJuQhW2ohiKBK53fgiIw==
X-Received: by 2002:a17:90b:1a90:: with SMTP id ng16mr4802485pjb.172.1601998512504;
        Tue, 06 Oct 2020 08:35:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.183.32.214])
        by smtp.gmail.com with ESMTPSA id j8sm4116036pfr.121.2020.10.06.08.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 08:35:11 -0700 (PDT)
Message-ID: <5f7c8eaf.1c69fb81.a3a31.8986@mx.google.com>
Date:   Tue, 06 Oct 2020 08:35:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9215690067431828688=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, henrik@grimler.se
Subject: RE: [BlueZ,v2] tools: fix forgotten index->mgmt_index renaming in btmgmt.c
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201006151943.125484-1-henrik@grimler.se>
References: <20201006151943.125484-1-henrik@grimler.se>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9215690067431828688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=360347

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
tools: fix forgotten index->mgmt_index renaming in btmgmt.c
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#12: 
                                config_info_rsp, UINT_TO_PTR(index), NULL)) {

WARNING:LONG_LINE: line over 80 characters
#34: FILE: tools/btmgmt.c:1216:
+				config_info_rsp, UINT_TO_PTR(mgmt_index), NULL)) {

- total: 0 errors, 2 warnings, 8 lines checked

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


--===============9215690067431828688==--
