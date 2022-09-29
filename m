Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B3EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 22:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiI2WwP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 18:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiI2WwN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 18:52:13 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6216120BC2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 15:52:12 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id y2so1711853qtv.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 15:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=T1n5BoObD6ESwTpOYUuUzyscDP/DEiHHYnoKeoAVPEU=;
        b=WJ57Q9yVZ+87fG6ApxRTzhfhzlYsbZE3cD/dzBkpq/5CGKswT0YFfYe5dbxI3Z7yFe
         whHLdOe3r7t1W8nF8ijVsTHI6i8GNvB+hTA05WC5pbgTdjWpo6nnFy8hiEqbh8oamYL1
         1hSqniqo+Opl2ZxLyFl1oKTZGAYCdcZjHpK0NkubopJI2MuTy6Epg7yayr5kgiY4ZOqQ
         jg7Q81mCofgViJ3WSyV2YAAp/lEYmaJqtR72Urjkt3d7qhg7CZyxBRviQ6sJT5Bsl4C8
         1yHEgNeGj1u+fThYRrnzRNXZeusH5q4K0s6LW88Idg23Uugo0fd9eCvBcsuQefPC3C6M
         m93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=T1n5BoObD6ESwTpOYUuUzyscDP/DEiHHYnoKeoAVPEU=;
        b=OYPwv63s57WD0SXg4VGapbZE3IIqbpNiu3y1s0TxxFZAQU9nxCmhOZLUhUe5oLGc2q
         aqMQH1eRd3KXtkw7Qz/6oY9vh0HAQ+BfHVQcDyMIZJ5HEwyroPoh1iM5pxZWRcaZ+m59
         JvnKzcEg89zthRpJjgeBINlOyoEzQaVdUYG/+crbt2/Zou8a/7E6j6GQCHU2EDLGWlE/
         KFDsvzk9KNQK8oOM2nt8tCATyi6+gpJH4x7M9/XW1Dtp4SCPdEiwKH7NESP5W/bw6Ztq
         +Mc70hRpAuQefgy02DYMTOtZcTkaebB5vs2WPI9bgG5j+806mrbTJ0xnlYxwBe0BllHn
         kOjA==
X-Gm-Message-State: ACrzQf3c3B/pA6AzI7WLD1r7C/CSan2emjLS5sAqHR1bOdCv5l3fUDyt
        aeCqPlbZ+is/TawRxxGEqhgm/9Yf5oQoEA==
X-Google-Smtp-Source: AMsMyM4iONUNtTcVXE6zrt3tAYVG4Y9UQWQYIdCj/R5ywHgWMqdmsxM5AyfW8wU2WnMAI4C/7pHmEg==
X-Received: by 2002:a05:622a:115:b0:35d:5825:79a7 with SMTP id u21-20020a05622a011500b0035d582579a7mr4514186qtw.668.1664491931857;
        Thu, 29 Sep 2022 15:52:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.250.166])
        by smtp.gmail.com with ESMTPSA id 132-20020a37038a000000b006ceb933a9fesm650904qkd.81.2022.09.29.15.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 15:52:11 -0700 (PDT)
Message-ID: <6336219b.370a0220.7f3b4.2372@mx.google.com>
Date:   Thu, 29 Sep 2022 15:52:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4305705378520133419=="
MIME-Version: 1.0
Subject: RE: plugins: Do not try to autopair with Nissan Connect devices
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, florian@ubports.com
In-Reply-To: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
References: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4305705378520133419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: plugins/autopair.c:66
error: plugins/autopair.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4305705378520133419==--
