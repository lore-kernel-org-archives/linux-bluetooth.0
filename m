Return-Path: <SRS0=2aAe=6K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DD4C55199
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Apr 2020 21:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2471A20700
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Apr 2020 21:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyWJ0kKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgDZVGI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Apr 2020 17:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725996AbgDZVGI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Apr 2020 17:06:08 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C94DC061A0F
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Apr 2020 14:06:08 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id o10so12740618qtr.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Apr 2020 14:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:in-reply-to:references;
        bh=ZPfdBUNz/+sGr8uIYJ2oSOFTj5w+EaUpiKEVg3o+JJ8=;
        b=IyWJ0kKDesh1AhPt5XuvBxoNWXaUcDlDW4l9O/CyLgb+6Xh1/rxjAoo5vY9qefAh3Q
         5CtlsPRGS3P+Sy9Zdqp1tqEvvwDTON38DUGo3tviikx4CFf2PiawH3iODV6FVUPNsU8c
         UXpvWELleSnbwAxOzwzwMTNGQ+slRB11XaNZC+QTwdq3SyGAlfSRLKrbgcVn9yxJKa4A
         /rtzBx+mFCWkjlKCaJJ77XzGnvu0D91IABurDs8sdtzQHHZ4j7luS2UYUbyDL5evNRNl
         Ol4oZ8rUOWg9y2h1dASQE88JBu/TSHzpgGK6AH0b0xfY9NWXIJwbb50SQ0DoVm+rOGc+
         hl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :in-reply-to:references;
        bh=ZPfdBUNz/+sGr8uIYJ2oSOFTj5w+EaUpiKEVg3o+JJ8=;
        b=DavVIpbOximHjKzML5Wz0o1Pk8lnHaqVamZAPrW4rbmdTbCzQ0nSFdujOMBKqrO00S
         ZKCPkcxfYI4EHSpnidswouhSxclom0WOm9yxMjV1eKap3nn5AQBV4GCGcJPeGmlHmT6t
         fWkblvBGun52ac6VqkE1pM+jqiLOn3e+xN5xEewUnssgemN+C6Utfxn4qk7NYr4UNZkP
         Qt8oE7HXTuVO2kGuVvCPnHxW4WpMGkNyE2VWIve1bG/tXrpgeMlMpxguk2d/Avw6VhZb
         hDoIf/Ri0wcv8ebES0J5JMvTEFQP3+Sm8h9kDFSRQk3B8wrySPIOR13T9OK5AHXGHwWb
         XXEw==
X-Gm-Message-State: AGi0PuZr1+C2Nv0pHP+MHNClac/bdOO6ZjVudBxig44mq4fCjw0rKKTa
        KI2+CmRch0AsZWv7RXXHAwsrA25216c=
X-Google-Smtp-Source: APiQypLzPDN3NvVBp9/7FxV40Lvy0mFCYRllI+Su3Hzu5/todPtQ4qTvfaGHOeF97qod/QJMCZKh4g==
X-Received: by 2002:aed:221c:: with SMTP id n28mr19670097qtc.235.1587935167177;
        Sun, 26 Apr 2020 14:06:07 -0700 (PDT)
Received: from [172.17.0.2] ([13.82.5.17])
        by smtp.gmail.com with ESMTPSA id y10sm8288890qki.63.2020.04.26.14.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 14:06:06 -0700 (PDT)
Message-ID: <5ea5f7be.1c69fb81.f7b27.315a@mx.google.com>
Date:   Sun, 26 Apr 2020 14:06:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1066880243574196353=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pali@kernel.org
Subject: RE: device: Return error when ConnectProfile DBus method fails (second fix)
In-Reply-To: <20200426210247.757-1-pali@kernel.org>
References: <20200426210247.757-1-pali@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1066880243574196353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not replay to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.


Test Result:
Checkpatch Failed

Patch Title:
device: Return error when ConnectProfile DBus method fails (second fix)

Output:
ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 3aa815a31017 ("device: Return error when ConnectProfile DBus method fails")'
#7: 
This is fixup of commit 3aa815a31017e8793b030b04ef704ce85455b9aa. There is

- total: 1 errors, 0 warnings, 10 lines checked

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

--===============1066880243574196353==--
