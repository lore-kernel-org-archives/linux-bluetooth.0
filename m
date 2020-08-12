Return-Path: <SRS0=iWKJ=BW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750A1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 21:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E85C20774
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 21:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSH3b4Fs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgHLVYn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Aug 2020 17:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHLVYn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Aug 2020 17:24:43 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC62C061383
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2020 14:24:42 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id b14so3465205qkn.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2020 14:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=oSv9lNjLIcC+dSOR04T0KHy3KMdDW83IZKCS+JX1+YQ=;
        b=GSH3b4FsClaIQFZjp5TZkpSdI0sWWok33kV84CPaMyGVsG43bYSD+YwjeEnSr6ersQ
         zalSPLBtKNKBi/xYbdekj9pSCLn4WJpS4+QR5xocb6B9ypNFTklnwcO1MqHV7iOrgSFN
         b1AVWdWDm8ZmMViHbzHqu0dRxE+ABf86pdt4COz43y6SwhkGtKA4CNQNr8jWn19bRgqW
         NTWU0JDnonbrPybyPY4yV5fF2qkZAEUKbz+wEfDXNl6UlJ7ebZQpI+ARWJ6Zvds2TjRg
         jBJlHOGwpWw4HJ9xtwgEyZsvTlvvOCCWvSjqc6AzXoTsES5Xuo3uPt0KVerMintLzMHh
         3f7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=oSv9lNjLIcC+dSOR04T0KHy3KMdDW83IZKCS+JX1+YQ=;
        b=FY49TmwfN7yXanrgWyspyG80s8YdP5ZxRvkqZHa4y/RfHSLTCZbUjI4hADGGfExu7K
         aDRg5ATToifb/nbgjuGbc940sA4QyKS8e+g1c1gPV5/THXxV48RGeKRdwEWdNBqTB22x
         s/w9Rh8B/7vNv/1tgjXqPQTx3/zOS3vcEQXy4TuYoqpRpmfkS4PsvBnK7bBafvjJ7HWK
         ZB9Qj1AqJtFChfBFkAEKimNpR+UhjFERwnG59fNLeQmISBElS3mkPK7LVrww6XPhyCYR
         pSzw6xg6g+mN+GB0ppF5c+CSEoQZ812t+1P7zu0Tfuy++ryfIYsVEyOycnSZVY2heRPm
         3oXQ==
X-Gm-Message-State: AOAM531dtVJh0IT28kvv2XIyGROh6cNYa2LjB8HqnvHJ1ybo+J2Fl0GO
        bLn/8WYJvJqmgJOhmSQujdeZR0RKkQs=
X-Google-Smtp-Source: ABdhPJxiouZnj3zR+EALTDOvyHkBJY/9tnu4FYQGgffoNdssHUeAC3ABJIUrIrP88TYtKAdHFApGWA==
X-Received: by 2002:a05:620a:13c9:: with SMTP id g9mr1921845qkl.436.1597267481847;
        Wed, 12 Aug 2020 14:24:41 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.8.108])
        by smtp.gmail.com with ESMTPSA id o25sm3311884qkm.42.2020.08.12.14.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 14:24:41 -0700 (PDT)
Message-ID: <5f345e19.1c69fb81.cce10.d6f2@mx.google.com>
Date:   Wed, 12 Aug 2020 14:24:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7821008023768021923=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tedd.an@linux.intel.com
Subject: RE: [V2,2/3] tools/btpclientctl: Add btpclient test application
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200812204932.25627-2-tedd.an@linux.intel.com>
References: <20200812204932.25627-2-tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7821008023768021923==
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
#49: FILE: tools/btpclientctl.c:1:
+/*

ERROR:FSF_MAILING_ADDRESS: Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.
#67: FILE: tools/btpclientctl.c:19:
+ *  along with this program; if not, write to the Free Software$

ERROR:FSF_MAILING_ADDRESS: Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.
#68: FILE: tools/btpclientctl.c:20:
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA$

WARNING:TYPO_SPELLING: 'arguement' may be misspelled - perhaps 'argument'?
#215: FILE: tools/btpclientctl.c:167:
+	bt_shell_printf("Invalid arguement %s\n", argv[1]);

WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#2124: FILE: tools/btpclientctl.c:2076:
+static const char *help[] = {

- total: 2 errors, 3 warnings, 2175 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============7821008023768021923==--
