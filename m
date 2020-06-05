Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F26C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 14:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D63CF2077D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 14:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU+z13YP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgFEOgY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgFEOgY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 10:36:24 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83454C08C5C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2020 07:36:23 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 205so9868085qkg.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2020 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=gsPztTTj8o6dFTrzl5/4NLUmN/skgnWP9ZqvEzDONS4=;
        b=BU+z13YPw4KjjcY3yLG2evWbdRQGAwRd5ELnT9ocHbvxybhdBxor9YyAD3DBWSoeZS
         di7MSilnFkj+WkzU8MXoNBAcuu3uAgz9qyF7a6yPSawsSLebI2IkkmwF2++dGJ0Fj82X
         9ZDUFD60jlSdW4SYdOpXTKZcShqnbjXtlujEMw6F9WDCQJMGd2WEnIs9uMDb5lAWVn5L
         h128cDu0jDoYCjPScrpTN7Jb4CHMkXxsUOwd/rEl+MxSeouj211etnDYM6HMvF+eNmwB
         uqVom29Hf+CRpHTidGFERH/htL0R+SADWtYPqRcXxgVQhLWU1sK/4OIoRxjdqELTnkri
         59dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=gsPztTTj8o6dFTrzl5/4NLUmN/skgnWP9ZqvEzDONS4=;
        b=mOwC9Hn4X1A6jlqqMLkz5DWHHnlzM/fVL3qD1B44YbkJwjfNgFl1AFQ243v0e8sfXQ
         PqsQt8h0pilswDZhfpNbOxfUimjUZ9URJMBq8C0+W//kB3YFLm1MTicodUe6LuMdopu2
         pElGtuuK7oRIoC5gODFOJ5dYiPFRjNlN9dzz5/HlMp1hLTqCmxFrNQ2AKYMzrZOMLJdJ
         f1GqA3FAfdOePNWdcBfShmcl+QFsP02RLYV6p3DhLIpGWfBJCFs44TmBf+vhbehmCgs+
         xQ6EImlxTQUL4xT0CKanlleChqSF8iXpJzVUCTlqBrFMYyKHAO3wji/kfFPEHzaXMsjx
         pyPA==
X-Gm-Message-State: AOAM531vFsYMacPduP6OnFQBI6Tb7Pupe806cOQA721mnlYYcKDOLy5+
        HhJo7LQ5KHwwJTETmPBWSX8Cjj2PoaU=
X-Google-Smtp-Source: ABdhPJz2AC2bebzy5WJdUZse21gtWLSBRdyNT4Phrw2zpiB2HNCq2YLxr8za/Wxh6FAd4UtqwqaIwg==
X-Received: by 2002:a37:384:: with SMTP id 126mr9863919qkd.325.1591367782600;
        Fri, 05 Jun 2020 07:36:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.36.191.85])
        by smtp.gmail.com with ESMTPSA id g28sm7399636qts.88.2020.06.05.07.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 07:36:21 -0700 (PDT)
Message-ID: <5eda5865.1c69fb81.d636.95b9@mx.google.com>
Date:   Fri, 05 Jun 2020 07:36:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3496837522988973021=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, amitx.k.singh@intel.com
Subject: RE: bluez:update handle for large database
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200605142541.28412-5-amitx.k.singh@intel.com>
References: <20200605142541.28412-5-amitx.k.singh@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3496837522988973021==
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
ERROR:SPACING: space required before the open parenthesis '('
#32: FILE: src/shared/gatt-client.c:1394:
+	if(gatt_db_attribute_write(op->hash, 0, value, len, 0, NULL,

WARNING:LONG_LINE: line over 80 characters
#33: FILE: src/shared/gatt-client.c:1395:
+						db_hash_write_value_cb, client)) {

ERROR:SPACING: space required after that ',' (ctx:VxV)
#34: FILE: src/shared/gatt-client.c:1396:
+		util_debug(client->debug_callback, client->debug_data,"DB Hash match write: skipping discovery");
 		                                                     ^

ERROR:SPACING: space required before the open parenthesis '('
#52: FILE: src/shared/gatt-db.c:348:
+		if(hash.iov[i].iov_base)

ERROR:SPACING: space required before the open parenthesis '('
#56: FILE: src/shared/gatt-db.c:352:
+	if(hash.iov)

- total: 4 errors, 1 warnings, 58 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============3496837522988973021==--
