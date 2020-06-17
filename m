Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80665C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 08:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593E920679
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 08:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSGJc9Cf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgFQIIa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFQII3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 04:08:29 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAE1C06174E
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 01:08:28 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id w90so824893qtd.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 01:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=wjmhI1f1Bja9bnCk6ClvWOz706+HMKljdbHKbGGjl+w=;
        b=bSGJc9CfbVA36F/6Bvd4E+QSLRdnQcxEbQRsm1Ug9fHf9w1Y0x8lmKsxyv2aLn81i0
         FrELTUa08UCT0jfkIySyDK/uSBDWmvFVaWQiN6eugwf5xK/lt+lCQj5pvRse1WyL3irW
         bKCzUTRhTzOyaxpieJ5IBaw+oNyzIo6iUcZESjC1ZvNZHWq6VWhAhJVoUepAB1/OWHat
         HFEmyIIpmuT90Q+XL5o8puJYo0vKGR9DtRuoP6r16J6SW4HeLWOoaGRELhb/JwPEb0vm
         0nY8Y4MJNVL2ccEeKe3N4++HOcH3apQQmaeVmNaC0dLUJCoAOf9vhvWKaTPO6sy1FqZz
         KrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=wjmhI1f1Bja9bnCk6ClvWOz706+HMKljdbHKbGGjl+w=;
        b=rQdE/OTLHq6152dMFnJnMa2mCbSIPg7PqvK6zUW6BTrxtbqzL5nSewvSoI7gX7Lg6l
         xWeWlQBdEMSLsfaK9XOmlNuGPmh7hO0JeHzB38clbkg86/VgxhczcHtTnAw0pXcO0kab
         Lzha/l3oz014o0k5/kTOC8cJuVsUqU7tY+pp1bM3iZ13kNqqYuznfdmzVgHA1uwGZRdx
         l7FiI8Hw4HzslX4hCZ20s89dpQYLGHZDE2uCTDQ8QJ6p4eNgdaMis8uT6iY9jJyFT3l1
         qCV0+ZG0TqACm1KpRsgEB6r2Mj6j2c6Uy25UFzPgtmh0qEXcp2VfXHC8kesOar5s3v8/
         HGHA==
X-Gm-Message-State: AOAM531/3gZUEyuzo+NYQ8K8IeV4rUhRIDvQ0rDIbltqiSVMcOpm7v+Q
        Mw00e0AVTlo62K1NrFL9gBW0vE7d9wA=
X-Google-Smtp-Source: ABdhPJyZKpywu7fpbWedhC/bj+LfJuEfOewwUE+jQEKkjPcjZBMsfsdzJuTpmQLIacOE0Qk0LD8XGQ==
X-Received: by 2002:aed:2a19:: with SMTP id c25mr25202960qtd.345.1592381307856;
        Wed, 17 Jun 2020 01:08:27 -0700 (PDT)
Received: from [172.17.0.2] ([52.188.175.166])
        by smtp.gmail.com with ESMTPSA id 69sm16510399qkh.15.2020.06.17.01.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 01:08:27 -0700 (PDT)
Message-ID: <5ee9cf7b.1c69fb81.c4ae0.aa1e@mx.google.com>
Date:   Wed, 17 Jun 2020 01:08:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1900447084002323670=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michaelfsun@google.com
Subject: RE: [bluez,v3,3/3] btmgmt: Add command "add" into "monitor" btmgmt submenu
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200617005531.bluez.v3.3.I55df963e4055bf1778db6f9e46f166b88472e051@changeid>
References: <20200617005531.bluez.v3.3.I55df963e4055bf1778db6f9e46f166b88472e051@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1900447084002323670==
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
#168: FILE: tools/btmgmt.c:4784:
+			/* fall through */

- total: 0 errors, 1 warnings, 191 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============1900447084002323670==--
