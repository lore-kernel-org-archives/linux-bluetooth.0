Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BFEC433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 23:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2C9F207F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 23:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD/VdKZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbgFVXrf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731118AbgFVXre (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 19:47:34 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A77C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 16:47:34 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q8so17217997qkm.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 16:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=XFqfDuqWLBCJnSj+31hrojCIboEiASUO5+iceR7FLJQ=;
        b=hD/VdKZtiJx8Kr5TE4Bs1y17JbrkZXrIHcmBFXSz75z5HYLMimSZ2DuLIP6U/8ZuaT
         akhDYMJ5u7wEQwsxy/PWriha1tOVwIeBXkR82wlp7K/mNerfsMmn3HdXXfvBSgXm23o9
         za8G0hBHuNLRhSsTn2H/Ree6uaePdxB9HLy14f7qvO5vEk8UajSKReiPmmg2C5dmdue2
         2OrahWGp6kE9uwWQ9MdJWxQ6StrDmFxEVXIGrJRW6rS63MmsryOClLVMcQ8M2WbM+/dw
         WTG8BeRaPczGOyvdkhWOIKjSALZxF3FxIKRKD1R/NO+UPRayyyr2Sqk/LAh5wx09PA1+
         6xeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=XFqfDuqWLBCJnSj+31hrojCIboEiASUO5+iceR7FLJQ=;
        b=Lp/IH3Su04wof3KTCmXShm+ugnJFn4ZENHFjEEqTUbrtYwRRq/BcqCfX7cRRiWVkyc
         vnR0jhIsfwiTHEkJLRGUjmaUcjqygnEHYhui381cb4JdvHY26eUH6SCx0N+1m8iR8ywk
         +ZGCGFTQnEazY3RH088+bGqDZCUdc+m1oGFJJmFpDtv5w52+Q3j8jkAPtMXonX+z9tT2
         vfzyCcsYytfNyD0Qhy6hwN4HKPPL1aY4P5tmRHyeXjjQWiao+nN1aG2NkpGIrBTkmCU9
         BJQ3IBALk294S6hHabUY3wOWeFnOVGwsbSGCFuvE2Nvl3izdoZz8ZtGqs1IglpAQEHxU
         Mj3A==
X-Gm-Message-State: AOAM533TQGQnqXe6z15SIgFCRyR1Rx4c6X3Wtvj2ZApQmTVnsfJyCVwx
        bvIKX7Ldsw8FAu9tffu+aGF7cVPXmvE=
X-Google-Smtp-Source: ABdhPJwDmd2WBI35zLbm8U+ecqVmec5Wvr3YrnLTJpy1x3CIOIJ3v0B4Qy/tQeCZWyio/m0IPsMDPw==
X-Received: by 2002:a37:5d45:: with SMTP id r66mr8558826qkb.2.1592869653718;
        Mon, 22 Jun 2020 16:47:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.9.213])
        by smtp.gmail.com with ESMTPSA id g4sm14169193qka.97.2020.06.22.16.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 16:47:33 -0700 (PDT)
Message-ID: <5ef14315.1c69fb81.384d0.5dd8@mx.google.com>
Date:   Mon, 22 Jun 2020 16:47:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0568652269456332332=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhishekpandit@chromium.org
Subject: RE: [BlueZ,v5,2/6] monitor: Decode device flags mgmt ops and event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200622164003.BlueZ.v5.2.Ieac700ddea68a19e8c3dc53528f686482076a77a@changeid>
References: <20200622164003.BlueZ.v5.2.Ieac700ddea68a19e8c3dc53528f686482076a77a@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0568652269456332332==
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
WARNING:LINE_SPACING: Missing a blank line after declarations
#68: FILE: monitor/packet.c:13122:
+	uint8_t type = get_u8(data + 6);
+	mgmt_print_address(data, type);

WARNING:LINE_SPACING: Missing a blank line after declarations
#94: FILE: monitor/packet.c:13148:
+	uint8_t type = get_u8(data + 6);
+	mgmt_print_address(data, type);

- total: 0 errors, 2 warnings, 98 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============0568652269456332332==--
