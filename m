Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06254C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D61BB2073B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnHPD7mE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgE2PJC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 11:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2PJB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 11:09:01 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80FFC03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:09:01 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id k22so2155864qtm.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=YV+wjOG9LwiYfqW02B4aMmPmjsDTYEl+vc7G62/i56w=;
        b=MnHPD7mErrknFeT0JGfNFw/UCbTWZVW28OIksqal07plaDjb6AFD3jXP7BeYk0+DSy
         5c9uKML20mmUP+zV3UrGePcYsRD04k6nX2XVh39L8pBskN9pC8ahY3RRxA+aBH0nniHS
         P3P97zJN5otNsgmKX4sX+M01L0YMTRVXInYnsySNE/RpHiTzXuTcPVyJy7fxnfm3pMLq
         lm5Od3YGWi+lI7W31sq24yylxG//Oy+Oc9VbwKCfup19fJwCdiQ+Wtp8EnzMhj7EK12g
         m3oDS5V/MbbGinyCdZW5gf5NCLmeVM/VprEZMsv4vLxx2AVusAcaCx9sh7ZKOxjXPgqM
         6mQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=YV+wjOG9LwiYfqW02B4aMmPmjsDTYEl+vc7G62/i56w=;
        b=Gqwf48W8Ak+76Pz0DgGqdQsKzOKldTR2rz5E0s90z5l0x50KGVz/NfxQT3gc6E1tbn
         hOsygd6Fmq29WFaT/2xIGgtpL/bhOZ5vFBSPYT8Uau0StsYuM0pdCuQ5geXvlqNrp/T7
         VYfwHovPnU+nRVnrbWCodXkkJsunpkc5qF1LwS9kOChPVltr0tftqachofhsvEdykF+H
         WdsC+ocqctJ59M4FvnfUBLMGJGb4Rv/QmmtDpxIK18uCoNpdjCaIS7Fx1TCyjijapr4n
         7lIKsxjMTYxMqMeUmA8QEkPZiSaPifbp+uqZM5oRz+hR2GfwI2ncfQk3rnHL5yLeU6ur
         AQZA==
X-Gm-Message-State: AOAM53115KYCE+gPyAFepj6s0HWUcEgSciQLb3+34b3JMJQJ6YiTTI1/
        r9tomRTMwgJCgwTSuILyfCTy0iodwtA=
X-Google-Smtp-Source: ABdhPJzF3SyPu4bb3G0NtPAMSktjpbXX7LFrcljpIq+xRXpAet0FyvMyYHcfRw8H/bNiHdeB16qVWw==
X-Received: by 2002:aed:2288:: with SMTP id p8mr9255182qtc.328.1590764940105;
        Fri, 29 May 2020 08:09:00 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.58.192])
        by smtp.gmail.com with ESMTPSA id p12sm6842490qkp.129.2020.05.29.08.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 08:08:59 -0700 (PDT)
Message-ID: <5ed1258b.1c69fb81.d06af.7fdc@mx.google.com>
Date:   Fri, 29 May 2020 08:08:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0683932607805747364=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, alainm@chromium.org
Subject: RE: [BlueZ,2/3] adapter:set default system configuration if available
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200529145007.198906-3-alainm@chromium.org>
References: <20200529145007.198906-3-alainm@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0683932607805747364==
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
ERROR:INITIALISED_STATIC: do not initialise statics to false
#17: FILE: src/adapter.c:123:
+static bool kernel_set_system_params = false;

ERROR:SPACING: space required after that ',' (ctx:VxV)
#260: FILE: src/adapter.c:4396:
+	mgmt_send(adapter->mgmt,MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS,
 	                       ^

- total: 2 errors, 0 warnings, 320 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============0683932607805747364==--
