Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A72DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 May 2022 02:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbiEYCVW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 22:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiEYCVR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 22:21:17 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0161DA52
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 19:21:14 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-d39f741ba0so24453115fac.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 19:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=CyqttyNqkUUTC2PjuhJb83xGX3m/E8TFH8dh3P7DO4o=;
        b=QIDK4zQS8bsUFI2vCb852/vJQkK2p6SZ5PiAnJoyuwokwZBlytEFvGC0ipTnZ8f/uf
         W6619IGknFCTnAwKALRRd2YoSewPF//8uHNm4vi9F3E5yLspODHRCEvsirZRbKfax+Af
         543x7AF8ojuExfMOze/6ln2wWdm9aLP46jHg9ibw86Z7V9oHomFsExEquJPHklNmAT0b
         oyETwRcvjejtwQyCKdTjIddljnHpyIvxJMHd+19kOzEXzzzPJ69hUqx+PqF36VVh6WPW
         UPhOuGaeE8ri1suPRkKA++oKjcC4A4aHYigYTDreNvBYBV1wf+Hay7+1tgvKDwvrgRsH
         CO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=CyqttyNqkUUTC2PjuhJb83xGX3m/E8TFH8dh3P7DO4o=;
        b=JwfEbCzHAnIWKvKmBMgpxANuesH6/s8w4KOOR9CHR9jJV0lV5bSnvd8Sl6L3hF9jB1
         /ZHR9FSK6oRCkGIjeNWufTQYhPe49C7K/FE0dfWvq8rjpkKqdH6TCYFx+wf5Lj0vBN84
         Bupoj2DgIr9RkZOuGQ754uf7HrRJmieFZCLuvRAiBitd0ySz+GQedCFPor/3G44WwhrF
         jcRnv+GnVinE7xGbb+Fvc3d7ukuB+Zuv8BB1JWxkMvBwrFHFMfA/pz7dP4+7OFH9B7bb
         DMxUsVsKgR5S/Go5sJVdMNfgQPeVO7FcJ+cNC/Y33LqDR0pQG/7tYh8ce9OMfL9kx93r
         XE+Q==
X-Gm-Message-State: AOAM533gAbyaEIo1Us8SdYe/ZoiAyWXKgehNX/xWxmk2i6olNUQiMCyt
        1wFnd2nDAAx7EH+vOqHVBPq/MLvUAPEsGQ==
X-Google-Smtp-Source: ABdhPJwnPD/o6wHKhAUzcXf7GyqYek3r75sdQEuvjB4TZrZ3ZpulD+Ppx8+MTIkGRNZgNuUMAhwr+Q==
X-Received: by 2002:a05:6870:73c8:b0:f2:5b63:5b9d with SMTP id a8-20020a05687073c800b000f25b635b9dmr4579485oan.26.1653445273562;
        Tue, 24 May 2022 19:21:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.134.51])
        by smtp.gmail.com with ESMTPSA id lg13-20020a0568700b8d00b000f2b4d23824sm637104oab.24.2022.05.24.19.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 19:21:13 -0700 (PDT)
Message-ID: <628d9299.1c69fb81.4ddbf.580a@mx.google.com>
Date:   Tue, 24 May 2022 19:21:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8692959046512015293=="
MIME-Version: 1.0
Subject: RE: [BlueZ,1/2] monitor/att: Attempt to reload if database is empty
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
In-Reply-To: <20220525010615.3670970-1-luiz.dentz@gmail.com>
References: <20220525010615.3670970-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8692959046512015293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: monitor/l2cap.h:31
error: monitor/l2cap.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8692959046512015293==--
