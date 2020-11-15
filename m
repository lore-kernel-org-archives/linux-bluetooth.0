Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DDBC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Nov 2020 18:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EEA72225B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Nov 2020 18:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIXSN5ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgKOSv3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Nov 2020 13:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgKOSv2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Nov 2020 13:51:28 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEFEC0613D1
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2020 10:51:28 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id r7so14616539qkf.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2020 10:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=0rGol5Se/lJf4PclAaopXlJRVDCm45slvhd3ybgW2c0=;
        b=MIXSN5kudoUcN3gzPw4VBWoQs3OJ09kl8/kHOUcJG4i/wXCsFyebHSzo8mgJAHLlO/
         xeZg8LiafvdsihGtoiH6F2lRqUwxRj9hthTBjk8EmQP1YZrWEmqfq7ZdhBAeC7idLHVM
         /XPSM2px2mrbWrG9d3/cj4KVA39eWIZUNQB/1EOf5VbZXUjYmSJowdugRospNraYkwBf
         VDBoibm80GPJyBAsRBnMYCE4wB2ywgJODNpybbH4xc7KFx299GQhGasaVSXfseTssdXo
         iMx3ituHemB+w507ouRUuHjhPAeqhesaQqw/XzJZMFRgfTryLZ9hlzlPw2jXiSEP7Yz6
         RAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=0rGol5Se/lJf4PclAaopXlJRVDCm45slvhd3ybgW2c0=;
        b=B0C4C2iGsfDqaImq3DbVXjiJEn8wKn9zvBB9HbxCsfTLItg1QOef+pxEN2GV/1awWI
         mI7JNQAPDFh7xtse6zuw+FUIjBgi6kMlxAqsnrRhLDbPzy5qlAqQc/BhUdTLERcDvwbE
         pvaXphtnC63hTJIcsL9+zZYwqO7oP0Bj8c5YQ6HtpA/DTFWY0Upq/iaU6C0sPZUXMOyB
         b5WnWTvBXXsoqTsvQBw+CjC7Yk2gpqRri7jc9BAEQwaoYzADmzXBY722Jmfqnow8xSwB
         d6CzDTm6l0lNFCL8S5g1KtkUiq3Wv+xc/hZZzpCouRtDC6ReUUCpwPpgv9vHgOKOlU0R
         Ux1g==
X-Gm-Message-State: AOAM531Ls20v+Mt0XsktquuGLO9x7JAz8nFINknOywH0NSqmSDVrogxm
        ncLgELhL+esUNO9L9nnnnGqrc+C4RsTOWw==
X-Google-Smtp-Source: ABdhPJzN3U3e7jOKR+1UDtJGOwx7GVN6FEEkVgpnVkJOVRqRY6NJn5vX5j8wPkRmrEtjq2Xg17GCFg==
X-Received: by 2002:a37:9c83:: with SMTP id f125mr11455541qke.149.1605466287905;
        Sun, 15 Nov 2020 10:51:27 -0800 (PST)
Received: from [172.17.0.2] ([52.254.48.154])
        by smtp.gmail.com with ESMTPSA id g13sm10604159qth.27.2020.11.15.10.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 10:51:27 -0800 (PST)
Message-ID: <5fb178af.1c69fb81.26650.ae6e@mx.google.com>
Date:   Sun, 15 Nov 2020 10:51:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6958627770230664290=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/2] Bluetooth: Fix not sending Set Extended Scan Response
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201114004434.3852104-1-luiz.dentz@gmail.com>
References: <20201114004434.3852104-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6958627770230664290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=384043

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


--===============6958627770230664290==--
