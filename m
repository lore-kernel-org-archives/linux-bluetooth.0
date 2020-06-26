Return-Path: <SRS0=vuCz=AH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CC2C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jun 2020 21:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA0420FC3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jun 2020 21:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMhqcxEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgFZVSC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZVSB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jun 2020 17:18:01 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BEAC03E979
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2020 14:18:01 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id u17so8591195qtq.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2020 14:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=BB9Q6btV6lPMzSLv5y4CJNTtmtA0wDI8tponAfoWo2o=;
        b=DMhqcxExM0rT548QkZEP4g7J5YoSrXo1n8Wuu17IJdQxteRUt55TQcuSP7NRivoLYY
         wYo6Ma9/unxAMgcUYMMbgSu4ggq/xbga7vpB6QFkieWkmagBZRF2WQbdO/V4LQ2oPOqX
         tPuYwJuUAbVDqQcyf/ovY3Z4FcLzr4WiQD/TefTPNTodkCMmGoAsgJE9iUAnwhYsV7ay
         fLCCoULj6NlJVTNj2yEGE/Z2WrvTqsILsXnlpfCu4W0XQkhvBiH2gVGxZ7zIsT7VeHRA
         Qz4frUaPjDAdn4wLxHEovYTcrwYLulCJgwBs09intJzg5JQxEDMmZxuK2WrIpTbir4dv
         7OFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=BB9Q6btV6lPMzSLv5y4CJNTtmtA0wDI8tponAfoWo2o=;
        b=hUOgLNHe2QffNGkNtQf+90Ajy8pa1kgJ1UU7pOAFdBxCceWePGownM11g8PLvmpz8j
         9CPORpSJ3nfIZrq43R2hz3HL8sTn9+GJRXsItyegckKZYpAx6E9NDPHBCf/kFhwXw1Bt
         53nj/D8Xww+WLHGR21y6MfHQDvViNHcUn7VWnxsuzSVL/hs+5iVHW85V4bNiYc6U3NJE
         FlnpLGXfN6fPykJHe1M4Sa0FxzjzhDFsG5uc5XtSPybYCC05CAQSR5zZOn0ZuCr48DfY
         VsXMWdLLscBavHy5lr0jzXnqSy8lFsFKMP+HOagVqXTliyc5kCn7b6frlckqwsuiDiT4
         AAAA==
X-Gm-Message-State: AOAM532gu9f9d+2qFoE2Ue7nf1VZ8Y6FHxkARuvIrYdp0xvsXZGoRT/r
        vDQTXBZHEKbQW9jSXEONU9/hOSoHYcc=
X-Google-Smtp-Source: ABdhPJwKZizMtFmUdIrhgA4AVbM4T3NtN5EkLG7G4vWyEWCcg3qJczKZmx4dCkbWu5KRVGBh8CLTcQ==
X-Received: by 2002:ac8:3f4e:: with SMTP id w14mr4745033qtk.215.1593206280515;
        Fri, 26 Jun 2020 14:18:00 -0700 (PDT)
Received: from [172.17.0.2] ([40.70.42.37])
        by smtp.gmail.com with ESMTPSA id a82sm9725857qkb.29.2020.06.26.14.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:18:00 -0700 (PDT)
Message-ID: <5ef66608.1c69fb81.c7747.6c9d@mx.google.com>
Date:   Fri, 26 Jun 2020 14:18:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7560142383128223124=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, alainm@chromium.org
Subject: RE: [BlueZ,v1] profiles/scanparam: use configured scanparams when available
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200626205306.803784-1-alainm@chromium.org>
References: <20200626205306.803784-1-alainm@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7560142383128223124==
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
WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#34: FILE: profiles/scanparam/scan.c:78:
+	 * parameters */

- total: 0 errors, 1 warnings, 30 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============7560142383128223124==--
