Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD28EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 06:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6ED20853
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 06:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1RwIptV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgFQGhd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgFQGhc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 02:37:32 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F262DC061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 23:37:30 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id er17so510220qvb.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 23:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8dlLCtvWsrFChYgRx6iRr5vaZrSmdOv4nZcEgYE2vcc=;
        b=m1RwIptVkcYk2q7MR2bdQKJyGw1iteGAqF3Im/BE/JIxUkiwVXVKhq4n1IDYMsAih5
         lf2d48WNDKMVSrkH3v5pwBub7IVW9BC5z74oQSJ9/F+7niu5bu9Xi0vOAl3nPiv8pxb4
         g1MZPSKYbgTHmVf5Kdjn/DqVQfTEiwa9/6qPp/W5YwhBhgh1IsTH+oMnvCQVjD8XWOvk
         its+jOBSxCUfMpUhkx3j571uGy5Gm9pJt0GL0vKk/cS5kQjvo8pKfprk3Ox/Q7B+2Cku
         PF7q33x5NYuKjqqKaUVTb5jBVzm4lk+HhhRVsTibkY4xlOD4HNuTar4Aw4sgHEY6zxee
         UFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8dlLCtvWsrFChYgRx6iRr5vaZrSmdOv4nZcEgYE2vcc=;
        b=IJ0Fiiu91UCQ80LdSVzrT7OC7v9S045LMgHBqq+frx/qg7NXnGHTssTwcc3MBiHHWA
         kZ1i+4EhliLym1MqTMoEII0Rf/UZpi926ilpK0qzxzhlDhd/FsS+cA9csDKb01Mf6Eby
         fdADXryoyvWrCxMJH4JOyx54E/VSXaob/9BGQx9+3jbr9cXg0ugtIjC2mm6cDKvalRQG
         HKXUD8qiX2ju9+V7t4jJreyf6lQGSI0qajDiVYcie/nGAAQ5388e40Cn1Fp+9v3titoo
         +u00OWIDvaTtpsYgvpi2oj+JE7qpZJpM2HQrPxJcdzWFhj1ON/mEaYGENKYLDDNCIDeR
         qD7w==
X-Gm-Message-State: AOAM531Q1WBoJrLvl3IlIIZ+NKpZBnvy9DZSQEA27Vo4MQF6VAdDNQez
        zTVT1xYK3dMKuABlMjWp6jWLKtmvzNQ=
X-Google-Smtp-Source: ABdhPJyOJtM0/HqoMp4mQIWCDyU489O6OdSpRTvhy/mKCuGXv3zA3YHFfBAAPPSRdl8SkBZ3na9/Ew==
X-Received: by 2002:a05:6214:1333:: with SMTP id c19mr6075837qvv.72.1592375849836;
        Tue, 16 Jun 2020 23:37:29 -0700 (PDT)
Received: from [172.17.0.2] ([13.68.98.178])
        by smtp.gmail.com with ESMTPSA id m13sm18130988qta.90.2020.06.16.23.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 23:37:29 -0700 (PDT)
Message-ID: <5ee9ba29.1c69fb81.0f4a.2d63@mx.google.com>
Date:   Tue, 16 Jun 2020 23:37:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0737617278581065273=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michaelfsun@google.com
Subject: RE: [bluez,v2,3/3] btmgmt: Add command "add" into "monitor" btmgmt submenu
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200616232642.bluez.v2.3.I29854cfe9ccae25c34666856326c07cd680151b1@changeid>
References: <20200616232642.bluez.v2.3.I29854cfe9ccae25c34666856326c07cd680151b1@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0737617278581065273==
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
#159: FILE: tools/btmgmt.c:4784:
+			/* fall through */

- total: 0 errors, 1 warnings, 183 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============0737617278581065273==--
