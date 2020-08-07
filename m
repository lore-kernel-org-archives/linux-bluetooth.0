Return-Path: <SRS0=11Tl=BR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CE5C433E3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Aug 2020 03:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8090D22CBB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Aug 2020 03:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrlNXw+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgHGDtc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgHGDtb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Aug 2020 23:49:31 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F52C061575
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2020 20:49:30 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id d14so582609qke.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2020 20:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3TXlOXvMutsu5xQq+ZZJ0pZ5YdbjIi+ZhSRah2RzjiI=;
        b=LrlNXw+NKk1Pi5XJlQ4XNQNb7RIb8W3bRVIlVczSrEmNv3Psubz6527jDtdFnGyDv8
         SdApNXNwws6t5RdKakJXVqoXvzRXaMMfpAdxMMfRU1ip3dujeHDqXzU1vC8Y4IwC7RcV
         Pd42XO6aQRU2qs4rIhTKedRUmj22GBikgERwdJ3bk2pzU5vROxmGN0XL9u3kkfrCxJJS
         ojwCWJObQmW9dZa+545sVb0M1qBHWG3ev7LHjdWy4P7usKdiL9om/hPToTjnAPQskidV
         7hmD9lbEXP3zxuQszoHRB1aB6dbdlpBQQRcEDQ2yI2GtG7g395zAfcLVid/EzXBYAAmO
         Y+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3TXlOXvMutsu5xQq+ZZJ0pZ5YdbjIi+ZhSRah2RzjiI=;
        b=k0YoiB5GybMtzNQItxeFNMOKjtJ5IjpQoMe0O/KsEOhX2+MOGRmHAajp0wcW8EvPka
         /aZEGwWfdwsTbWddFOlSupjEI4/UMbSM8VdaNlLAAoHjFqE2hCZNQH5Zb2Nx8yYoOFu5
         DKWDTJB4VA8BiageQ9KxKYmkf+BccTtXw52071VZ1mjKX30cPIVESzD7tU23Halap6w+
         RymKBdzcVJYUBv/P2J2No6wC5rnbUOcFdKTi51rWdFCujspGkLToDHIuJjTszXCul80U
         hnkOQ9xjcCqOmjr9IbXxB6gT5PtxcyRBiVe5D9pKmULdPnXW3GxdikuIXoKSoUk1vooc
         1zhw==
X-Gm-Message-State: AOAM533LofPgnKFcnrKvohJ9hEYHhonvmCbAfelqi2acwdmrYxZ4Nz2/
        Bv7XZ9XGQsU7WMRpaR0TU15Loml3Khc=
X-Google-Smtp-Source: ABdhPJxrdKbgXZN5+njSpoEfBivCtaxnLovwK6tOYolvV0/DFH8hwFs4K3/OxO+BqSOoFJGCY/uMJQ==
X-Received: by 2002:a37:a0d3:: with SMTP id j202mr11369300qke.365.1596772168107;
        Thu, 06 Aug 2020 20:49:28 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.91.70])
        by smtp.gmail.com with ESMTPSA id h144sm5842437qke.83.2020.08.06.20.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 20:49:27 -0700 (PDT)
Message-ID: <5f2ccf47.1c69fb81.8adb.f0af@mx.google.com>
Date:   Thu, 06 Aug 2020 20:49:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1992372064314151277=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ,v5,05/10] mesh: Clean up handling of config net and app key messages
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200807013834.123263-6-inga.stotland@intel.com>
References: <20200807013834.123263-6-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1992372064314151277==
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
#130: FILE: mesh/cfgmod-server.c:936:
+		/* Fall Through */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#189: FILE: mesh/cfgmod-server.c:956:
+		/* Fall Through */

- total: 0 errors, 2 warnings, 191 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============1992372064314151277==--
