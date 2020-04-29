Return-Path: <SRS0=4cRj=6N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419E6C83000
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 21:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 199D42083B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 21:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vh3BLZhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgD2Vf1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726775AbgD2Vf1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Apr 2020 17:35:27 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6491BC03C1AE
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2020 14:35:27 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 20so3653816qkl.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2020 14:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:in-reply-to:references;
        bh=U2DsoS/6E9Q7A0DIVF6CO9Kk1e5xuHBU2zUhz+Yj3wQ=;
        b=vh3BLZhKpl2Y1N9KIfPRy8//jAZisZkNuV+NnCVbVxdunGUIMsfNscx05dn2oVKiEP
         2X22CJ7oxo2xKKbfgmG1CiUSrZNGJETUVeTZC4XBn9379rz2ehg3pVtQVPAmhTp778tz
         tlt0YZByUgGANv6frbqHadS67TyGBfNp2c878FSk34B6ZPeULSLc892g11nhvZSAVQST
         lKTxIQU7LlNl9ER195LSw7XCcl018W7aUtciTsuffX3oj7gPwqASw0W6YausIAP2tIFL
         r0kKvFU35K+Aq+A0ItSL/YlVm9nOGBTeiIQCHd/2ni9eo25c0JnvyQJLyd3YZS+Hz/8n
         5+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :in-reply-to:references;
        bh=U2DsoS/6E9Q7A0DIVF6CO9Kk1e5xuHBU2zUhz+Yj3wQ=;
        b=LiNVGb3tqZogJs8gVufILoXhXKGeDes0yDt9jwpMhjpXI2nR/c2uGIcYdHenfqaFCL
         BzJbnrwwdojZxgKhBHetzZIhO54v44+ofI+M7+EZGNWdxIZ4AQxFdPdXzh+LHXEK/cW9
         Weovmj10y3bLtosqeCbWWnoMQc63HKsn34AkU/ugZYyRKOE+E86DqLZ3bBVyxWjSxMlt
         g+YddP6K/m2bGzhHncgeFz7VWrNcwzgR6KxxjBT3PWxMf5vyzDztUhx2Z0Qy4wWbE8Km
         zzRExv76Yx2BxYbRSnI19bhxmmUpXC5p5ZY5X5hwKsNMZB0TYfwdanWnYDwz8kz7onKE
         yBPA==
X-Gm-Message-State: AGi0PuYMKHV2hmAKv/ScCk0V18LTgR0aH7MuAyNEXTOgMZVNnZi0cEdK
        SeEtUHOY7AydQeBGBCCnrKeHloHUcxE=
X-Google-Smtp-Source: APiQypJme5M4dt8QWg9o/V+LSVZbjnAHBbr84cM82G9ocr5Agfnb5r64dKiJqL1vTrjykijRS7QaKw==
X-Received: by 2002:a05:620a:2091:: with SMTP id e17mr562234qka.70.1588196126465;
        Wed, 29 Apr 2020 14:35:26 -0700 (PDT)
Received: from [172.17.0.2] ([52.149.180.133])
        by smtp.gmail.com with ESMTPSA id v2sm399847qth.66.2020.04.29.14.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 14:35:25 -0700 (PDT)
Message-ID: <5ea9f31d.1c69fb81.3f794.3102@mx.google.com>
Date:   Wed, 29 Apr 2020 14:35:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7726755867900548330=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] log: Make error and warn log file and function information
In-Reply-To: <20200429210419.1569840-1-luiz.dentz@gmail.com>
References: <20200429210419.1569840-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7726755867900548330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.


Test Result:
Checkpatch Failed

Patch Title:
[BlueZ] log: Make error and warn log file and function information

Output:
ERROR:SPACING: space prohibited before that ',' (ctx:WxW)
#65: FILE: src/log.h:73:
+	btd_error(0xffff, "%s:%s() " fmt, __FILE__, __func__ , ## arg)
 	                                                     ^

ERROR:SPACING: space prohibited before that ',' (ctx:WxW)
#67: FILE: src/log.h:75:
+	btd_warn(0xffff, "%s:%s() " fmt, __FILE__, __func__ , ## arg)
 	                                                    ^

- total: 2 errors, 0 warnings, 47 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



For more details about BlueZ coding style guide, please find it
in doc/coding-style.txt

---
Regards,
Linux Bluetooth

--===============7726755867900548330==--
