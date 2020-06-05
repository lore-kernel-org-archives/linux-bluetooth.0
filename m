Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4E6C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 00:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67762065C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 00:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrWC2BvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgFEAMs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jun 2020 20:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgFEAMs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jun 2020 20:12:48 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC446C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2020 17:12:46 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id n141so8183073qke.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2020 17:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=xVowTHGCvoECuNd+5F586Wj77rtkM2T8VHbhnc/jbW0=;
        b=hrWC2BvY0SXqqJc1u+E+nPvnxSZCu6RWtMVOk9zBCZeY8pXHX7HgAupDx5s/wzzFi0
         FZMHjIZzOVDvV6Px3tNT4V3Aj4ZN0V7oM5c5XOGimEqC0HPy72853d6/2jwg8ABNfMHf
         AKA2kPWqYmCFYkhoYdzmmF01H3MB50qGD1re2Tas8GBGNOndLJ33IHEsKAuErKwMMmsg
         6DjBDeb/iD8GyS2kaC4le3lT+HQDd/jMGwbJ89VVqXYbu0heavLFwrKDgi2PWj/5pWsl
         xq9QYvt0w/LV9IgRNG6COQaU1ye4EpO7Kuqm2craniT3/FoV/d+oi5FMNIJSY5fwAmaJ
         LNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=xVowTHGCvoECuNd+5F586Wj77rtkM2T8VHbhnc/jbW0=;
        b=lDX4oKZIOQ1yp6k0CSoNXWA11CmcskFhDwanpJu6WaCsToVf6FPf+MfF0Y8v0YOUrH
         wDm3H1dPsVmRUjJXNv2tpQRO6SY7qJnRLrQGCcrJjZ0gQGjRQ8RBtYkucwqrv4sxb8S8
         G2KMYfFcMMIBXgQ7WquiN8cTYTJuaDQuynkB5xS/K5XSBst9YN6U/AFYOkbYhiXdZ2Aw
         PiQwWPw9kp/rMCKhWxF1FcGRxbSWeyXKJDMxZLW+VYSrW96QUzhBkrkaVYEZ1Uu2RLC2
         8xAQc1GhhT1JMxHLUQvBAVh4vYtzhvyB4elCPIuVbIcdh66JW0a2xBuo6ALyDhu8yMdO
         z/Gg==
X-Gm-Message-State: AOAM532yzcxA+0XC2WdbU7k5FrBYPqhpH7pI3hY53ez2HxgcJcoXMF/8
        vDobyx95pQpkc3a9codt9nOaGDGuv78=
X-Google-Smtp-Source: ABdhPJzd4lLygW7bc/YwGWt8bE3gJ3XhpwB7hMIRT9bHhWcwp2iag3nxWyTkN77Jb5yoI84CQjhIVA==
X-Received: by 2002:a05:620a:c87:: with SMTP id q7mr7383446qki.31.1591315966111;
        Thu, 04 Jun 2020 17:12:46 -0700 (PDT)
Received: from [172.17.0.2] ([52.138.85.28])
        by smtp.gmail.com with ESMTPSA id r57sm6758012qtr.41.2020.06.04.17.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 17:12:45 -0700 (PDT)
Message-ID: <5ed98dfd.1c69fb81.aa9e5.6148@mx.google.com>
Date:   Thu, 04 Jun 2020 17:12:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0776810541008128068=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pali@kernel.org
Subject: RE: sap: Improve error messages
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200604232433.4951-1-pali@kernel.org>
References: <20200604232433.4951-1-pali@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0776810541008128068==
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
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#8: 
bluetoothd[19117]: profiles/sap/server.c:sap_server_register() Sap driver initialization failed.

- total: 0 errors, 1 warnings, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============0776810541008128068==--
