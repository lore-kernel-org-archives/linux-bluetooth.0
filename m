Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD53EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 08:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C8FA207E8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 08:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joOuCQhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgFQIIa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFQII3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 04:08:29 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0128BC061573
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 01:08:28 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id g62so838508qtd.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 01:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=fEfzFMvsYui2feZa4prGUD5jvzjBg5K377rvOPqleng=;
        b=joOuCQhYEx4AWlP0G/32/rLdW1+mTV8SRM4dl0kjjCuOvo084SLK4sucWinEQyPlbV
         1mGwNsjOII+PDpc4x0Rs0XagUnYjyQgA3yoEgU1RgdNqlQLQTOgxdJxdM6XbpJhszPkd
         Td8cFHAizqO1hfdk74kbhQGY6ozqgmfVyDe9a59X6TEWS4TmaDjhryhK38u3jM4ZmmQK
         agAmsdeCMkQiOMpHKQZ+Koa5E64LFXH061t1penMylz9pz+JCBjyfc+BMqR0/+3RcF5U
         hX13rE7vy4GyBAG58IOvcX6Decj6+Hm4mw/aaAq9XQIcD4JzmSy57r4ukpQ4YPq7/Hsw
         FmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=fEfzFMvsYui2feZa4prGUD5jvzjBg5K377rvOPqleng=;
        b=BZ3xU3OccWwF+TUfvTbA3oHvimR/Es0XRQTE+GaGFr7xhPzqGBAhvqBrr9jqXxn1kx
         drLoUjyFuiNei0ZeCMGw0apDQMqCJq1StY3o4wFMyA5KHL95jluj+XTwPvt1lVfbgkh9
         cgmyrIHNZunNGtTaA+WEGwbzBXanEWpBFTF48cxwRnRgQD//NA9bijXtrFby/rHm4EEp
         3hq6/lb5T3QRXYJ5nHA7JmumWD0zN+BpXub7tMx/vCXvD3xq6ZgxLYJ51Hf9xi1ReyZa
         1XqDIvu2IgormhH7dN4umhC04PwFtaqokFDAu4T6LZzBx8kcIXQ1ov+Gar9OHTPe334G
         wySQ==
X-Gm-Message-State: AOAM533QdqIIt7wX42mKUsBuzTchxFtFAlGkYD8G7oUjyeBZTzyIaOf+
        CILJhf5R+ZXD6QNy6JbwI84yI2xx584=
X-Google-Smtp-Source: ABdhPJyjM2uzxqn9dSHmUMTwSjnEiBYcHC8nyrXzLVNOpkzjcjqwHVkP2VF0fIA2A/POXwiCEPd8VQ==
X-Received: by 2002:ac8:6edb:: with SMTP id f27mr24520397qtv.325.1592381306996;
        Wed, 17 Jun 2020 01:08:26 -0700 (PDT)
Received: from [172.17.0.2] ([52.188.175.166])
        by smtp.gmail.com with ESMTPSA id q13sm16002761qkc.72.2020.06.17.01.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 01:08:26 -0700 (PDT)
Message-ID: <5ee9cf7a.1c69fb81.5a382.8b0d@mx.google.com>
Date:   Wed, 17 Jun 2020 01:08:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1538331306535673456=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michaelfsun@google.com
Subject: RE: [bluez,v3,2/3] btmgmt: Add command "remove" into "monitor" btmgmt submenu
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200617005531.bluez.v3.2.Ib8ae2d78936aa9f16a318aca14cf8c7198449bac@changeid>
References: <20200617005531.bluez.v3.2.Ib8ae2d78936aa9f16a318aca14cf8c7198449bac@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1538331306535673456==
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
WARNING:SSCANF_TO_KSTRTO: Prefer kstrto<type> to single variable sscanf
#72: FILE: tools/btmgmt.c:4685:
+	if (sscanf(argv[1], "%hx", &monitor_handle) != 1) {
+		error("Wrong formatted handle argument");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}

- total: 0 errors, 1 warnings, 79 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============1538331306535673456==--
