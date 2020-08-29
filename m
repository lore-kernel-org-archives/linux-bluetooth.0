Return-Path: <SRS0=jcZI=CH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F60C433E6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Aug 2020 00:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C7020838
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Aug 2020 00:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQAFJl3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgH2Aci (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Aug 2020 20:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgH2Ace (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Aug 2020 20:32:34 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7D3C061264
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2020 17:32:34 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id k18so910742qtm.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2020 17:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=uuWrZLWtxSYZkUAFWX/NXCbA/WuZosou4t8w9PL8goA=;
        b=tQAFJl3OM64q/BMHstnMGbD3XkE7fRmXbvJ68Jd1Y5uE7vQoGoIF6c08cuMtiuipVY
         R1J9ZhFZYmEXdRP+4iA5iEY/Lc0Ayd3eApJvR0++h/GPQ1b1NWNBjZI7xeaGAJqQRk0q
         +ZCvvL2jJA5luj5yqkoBVw4BMbwam1SICUQEWqMneTNom3EeKaDuaDNcHoDiy4BN6QTt
         +WJo3hQ7SkhwlqYNvNBS4AeIH9IvAQnW9YFradRgeBRci99IwQ/7GvYKd9tOCk01uyrG
         pFAgDkgBMG6pNQJ4kQjNkEnNZZCEytDEX1KVM2THiyR+nvEZSukyCMIzmv6Qxf0O8l1V
         OW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=uuWrZLWtxSYZkUAFWX/NXCbA/WuZosou4t8w9PL8goA=;
        b=Y6zdiFONdyfplyWm+V091+BqzNo/2bY9/ZdKxC+pzSOS2upAjWqy3Udd0ry/2G3cRM
         G7kafmKhAcZw58euAo5auo5h6n9pEnkdtEMgygyRBFKpuQHJuX5Ud8vsCMnraepCMH6x
         +5cm//u4bKuzd1eDqzA3SYYCzbeOEdvtRSknaTSHSM8/ql7QBmiiinmzbIYjnq0oy0Y9
         rwTHIq/zHE8OkhnSQLsOoO4zHO84CeITzsrvWW2I49gmW40mDbbXKNC+w9nVLa3+k141
         i4Mr/66WnWhwf+rP9MfocZIBAX29StMf5ALwyMlsyOB43p0GNf31iJVxp8jmJqJrHEF4
         KHWg==
X-Gm-Message-State: AOAM531y0yJJ+/m2exjAYv1QZnPAtVVOC/wf/CBa4meve8AflyD54PZi
        jUobPihoAy3RgA2tYdYt56CGtJlUbIf7dQ==
X-Google-Smtp-Source: ABdhPJxk5v5VWzUKpx2QZ2Flz9cPXnxZ9urV4CTvOZPhfMmmCGDsBiswsQEZRMl6lS0mWKiFyEWc4w==
X-Received: by 2002:ac8:c0e:: with SMTP id k14mr4171818qti.364.1598661152242;
        Fri, 28 Aug 2020 17:32:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.36.205.85])
        by smtp.gmail.com with ESMTPSA id v13sm753810qti.64.2020.08.28.17.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 17:32:31 -0700 (PDT)
Message-ID: <5f49a21f.1c69fb81.5e874.40a8@mx.google.com>
Date:   Fri, 28 Aug 2020 17:32:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3323347324394065462=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tedd.an@intel.com
Subject: RE: [V3,2/3] tools/btpclientctl: Add btpclient test application
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200829000803.20286-2-tedd.an@intel.com>
References: <20200829000803.20286-2-tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3323347324394065462==
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
#48: FILE: tools/btpclientctl.c:1:
+/*

ERROR:FSF_MAILING_ADDRESS: Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.
#66: FILE: tools/btpclientctl.c:19:
+ *  along with this program; if not, write to the Free Software$

ERROR:FSF_MAILING_ADDRESS: Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.
#67: FILE: tools/btpclientctl.c:20:
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA$

WARNING:TYPO_SPELLING: 'arguement' may be misspelled - perhaps 'argument'?
#207: FILE: tools/btpclientctl.c:160:
+	bt_shell_printf("Invalid arguement %s\n", argv[1]);

WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#2332: FILE: tools/btpclientctl.c:2285:
+static const char *help[] = {

- total: 2 errors, 3 warnings, 2395 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============3323347324394065462==--
