Return-Path: <SRS0=5eoE=CI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38BAC433E6
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Aug 2020 12:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A422C21473
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Aug 2020 12:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD67iDc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgH3MYs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Aug 2020 08:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgH3MYm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Aug 2020 08:24:42 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424A3C061573
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2020 05:24:42 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id v54so1468823qtj.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2020 05:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ADvudt0kqBdP2QDr8zOYxTPLcM459u30M4JST48Vm4k=;
        b=JD67iDc6xUCGPbZ63dWKijaTJQ2cB5w/OlfMxvlcVHSm59YIblqMx7mrfk0lWhGePW
         Tf224cji/OoAiUQ/B5tiHY1FXWcq7fT5WoyKQUv8Xvx+K2LRj+SrNjXNBvuwCrslqcOB
         7F3jm3mrx8khsQrZpt3hvRO34QkHi/7CHtlaeDNGIAydamUqn3T3gn1U0WGnZs4gvHaE
         f1aZ3clt666EwQ8iMi8A7BYjZ+RrOx6WedPMvSeGcWsqySPyLSWB2MFeb7jEoF8yCpfL
         HEj2Dhv9iEniVnXj+1597hBWcOkaRXRfiOejD8eW2cyebsPhkUy2Ih0bQ5TGiv/Z5lGd
         lQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ADvudt0kqBdP2QDr8zOYxTPLcM459u30M4JST48Vm4k=;
        b=LL2YH+2R6DE9zcC2ntto1VPeS/OMXVHoxFv7zIJ5qsa4HaVHX+5HyvMdqWbueY6OX2
         IxoGZ+yDLKPesxBYqvjgM2rXvgQ0VHE+4VFISeFLb5OLUh5yp2KkxlG2P0+JNeEwLUva
         QswxkZ5nKH8OYeYsi/acJm4Jszm5kDYY4f+dCcXK4erqchfqnsdGNAbSYMQWl1C41mNZ
         hf0VaPxnPIwWmWWTar+g01mYvSoWz26zTwUvszZPLbHh0ithbeiK1mp2QalPVce4NiXu
         taxoCHJ9Zwrv4LXDo352b82AeQx3umLeIqf+YKig8uk1+sOldfvWxNCftF/mWKXaeBUm
         4x4g==
X-Gm-Message-State: AOAM532/Nr2qDXFiS3iglv7SasZ8hcwbWPCRehCSy1MzKkby0B3kDeWX
        F7UjwEIEBupXDj0Rv7fiARWj0yy85wdjJA==
X-Google-Smtp-Source: ABdhPJxXL55o/50TUUHB0Ex18bLU9j9DGEZ5ESe0woZfQaRXLHxmrf3ApELvFYrBoP9LEsln67MiXw==
X-Received: by 2002:aed:3081:: with SMTP id 1mr8632166qtf.356.1598790278671;
        Sun, 30 Aug 2020 05:24:38 -0700 (PDT)
Received: from [172.17.0.2] ([52.147.165.209])
        by smtp.gmail.com with ESMTPSA id z14sm5842506qtn.92.2020.08.30.05.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 05:24:37 -0700 (PDT)
Message-ID: <5f4b9a85.1c69fb81.e4d93.2484@mx.google.com>
Date:   Sun, 30 Aug 2020 05:24:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8536862862408111687=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hanzefang@gmail.com
Subject: RE: [BlueZ] hcidump: fix a crash in le_meta_ev_dump()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200830115948.GA9519@ubuntu>
References: <20200830115948.GA9519@ubuntu>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8536862862408111687==
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
ERROR:SPACING: space required before the open brace '{'
#17: FILE: tools/parser/hci.c:3672:
+	if(subevent > LE_EV_NUM){

ERROR:SPACING: space required before the open parenthesis '('
#17: FILE: tools/parser/hci.c:3672:
+	if(subevent > LE_EV_NUM){

ERROR:SPACING: space required before the open brace '{'
#19: FILE: tools/parser/hci.c:3674:
+	}else{

ERROR:SPACING: space required after that close brace '}'
#19: FILE: tools/parser/hci.c:3674:
+	}else{

- total: 4 errors, 0 warnings, 13 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============8536862862408111687==--
