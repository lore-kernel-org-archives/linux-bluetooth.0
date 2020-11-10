Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273F8C388F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 08:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B9320829
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 08:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+4wbisC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgKJIPe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 03:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgKJIPd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 03:15:33 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90764C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 00:15:33 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id g15so11033106ilc.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 00:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=RXcpRCTutcvy1KA1EGINWzzE6z1tNEDidS22ylL6V7Y=;
        b=q+4wbisCh2TE9s0zPyZw1H7klLCTe/z81sVh2gPfhS5xY8x2KlYsPz3RDaQ4G0lbg7
         ln4vPHXt0Khci6cJtTpI6PRmM1CDzYb6xkD7cvREdAp1i9Y+WLHcEXjPLdq+NCbrjUkp
         iRZ+xoh12Bjqx8Kk1rpRr/aIEdmqW+hQHZWyO0DMASPfuUqvXOBtgq6O22hD8A43arlJ
         XALyj4DF+zt8H3FPMIwrCuOHP8HjHX/K3cIqxIj9F4Fjb72GhhCinggVWaWjaKpkfF71
         JCjj23VBX9zMAh4d27Fh2NG2X2PRX4Btu4I6JYHHw/fX5rntFOO6jNsTQExYo9V55xKX
         w+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=RXcpRCTutcvy1KA1EGINWzzE6z1tNEDidS22ylL6V7Y=;
        b=DcdslDkFPDFvxrGpX9ZBL8CvOuoKhQdvryKjcAegN4IaaJk+ifnyJ+pMPu7P8uB66F
         FTAJQ2aVKHerMppjX/r1+0xAt7OsiYvHMQ4pKZW4jz6xsQLN9u7i1oOdjbZuoijwFv20
         xAjeS4m/5D1kCLKxlXg5+MGWY0EmR1GXMyHp3yr1CX/F8ZJ86J42Oav5oQfKFVtxtt+/
         vH8x5QEDLO+anQutUhxO/yw4GJQQbeBmxSB26mYt+2lTZHijad6RrlvLDWUEF+XZ6j6C
         tC1VqQnx4EOLRxkVc+jz/zG9E3P3anlNNCUixkm1+9M+BP+k630tRoaqXQmoUayKt1FJ
         XxTw==
X-Gm-Message-State: AOAM530Nw1jCVArERpgG1aREBz6PfG0XjW8wh47SW7pn9lBBeMslshnw
        K1vCRZa/DXAjKneALSIk7UwZ4FEn7ek=
X-Google-Smtp-Source: ABdhPJzmg+4QpDbbHzt1gyUQQZHThwDpSr+UGrCMn69odCGP4cTl4lFIELHuh7vZ/J0VTzsD86kwVQ==
X-Received: by 2002:a92:9a04:: with SMTP id t4mr13998321ili.192.1604996132840;
        Tue, 10 Nov 2020 00:15:32 -0800 (PST)
Received: from [172.17.0.2] ([138.91.120.35])
        by smtp.gmail.com with ESMTPSA id m10sm8291581ilg.77.2020.11.10.00.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 00:15:32 -0800 (PST)
Message-ID: <5faa4c24.1c69fb81.85a43.f58c@mx.google.com>
Date:   Tue, 10 Nov 2020 00:15:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8733514487477014036=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, chiu@endlessos.org
Subject: RE: [v2] Bluetooth: btusb: Add support for 13d3:3560 MediaTek MT7615E device
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201110034010.11088-1-chiu@endlessos.org>
References: <20201110034010.11088-1-chiu@endlessos.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8733514487477014036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=380839

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
workflow: Add workflow files for ci
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#18: 
new file mode 100644

ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 1 warnings, 49 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] workflow: Add workflow files for ci" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============8733514487477014036==--
