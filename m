Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB18C77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 12:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjE3M4I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 08:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjE3M4E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 08:56:04 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0ED11F
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 05:55:32 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6af713338ccso1759895a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685451320; x=1688043320;
        h=reply-to:references:in-reply-to:subject:to:reply-to:references
         :in-reply-to:subject:to:reply-to:references:in-reply-to:subject:to
         :reply-to:references:in-reply-to:subject:to:mime-version:from:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jvFQlce94kvvI9lTjDNMf+5qJq5YBGy4B0LJxgZN5Zw=;
        b=oBFugAidJgfsBLwwqVYwKu9zhMzh0tnvxlMKNvusMNrkjMXdWZ/uQdYqRlGc+v8So3
         EudpoTjpzgCt3jLCEldBL+3Rr0ceqQR9jeFaSVJ6kDLoh0yKaGNGOqqswVUF2w35Vdlm
         aGWOM5PbyiBKe+nPQwWY7DUZhqUNI9fyIsG6lZmCXMkYgKW94m3113ho3s7f12CCOffU
         3utuDeK4Wf0hwRpLaUlW9B472d4QqATdaOF1Vy1hmYYoIbHgXnyiEVupiaCWMjaRo1SP
         aR+JlTPodAThd+RfLOlRRsFaEfPUrygIjA04s98HgzFPvNWIeyCREZsyirx9NhbdA1SX
         J17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685451320; x=1688043320;
        h=reply-to:references:in-reply-to:subject:to:reply-to:references
         :in-reply-to:subject:to:reply-to:references:in-reply-to:subject:to
         :reply-to:references:in-reply-to:subject:to:mime-version:from:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvFQlce94kvvI9lTjDNMf+5qJq5YBGy4B0LJxgZN5Zw=;
        b=aK7kLTZSe9qXst/WL0ZEj4/iAKQEEOIxdftQEgjuc3y5y7wEAmjpVk+GPwdzliBdrM
         GE7SyWnRnS3sOisgRGBpcMK/Wxq63eZO+L0aEdd4N8JvkY4jYQtzCqT2BtQYEVXdCmvb
         haoqL88em/xSl2RT2ANZDipz5ndaCi3HByuQs2FHYAVpxKU1hPhav4tc7fZHFTK42JPY
         wzXRER4rb7lVqEAa839ywbGSq3RApMmXXzeajiWPUCi69UfjnJK6nocV8VeZGt6vOVCL
         1d2U5kDBNkHm5+HIFiJEjkhui+kWzEaiwWc1OfV5wBLHiRxCsSZxDK0LHRD4513/0fo0
         prKQ==
X-Gm-Message-State: AC+VfDy99m5NHpkHLJy+qGjb16Ui2fBbVcsR56XR6gcer4RhL6nseQYW
        Oy9gxtKnW3bQme+JmSdcJtA1ztoaMUo=
X-Google-Smtp-Source: ACHHUZ6kXsgahMFzA2wHEU63EAjDEYlPkjCMNpR2ym7euSUAcVF8OtBucxhPPSTnwAT+uYw4USTD+w==
X-Received: by 2002:a05:6830:1616:b0:6a6:4430:9087 with SMTP id g22-20020a056830161600b006a644309087mr966100otr.35.1685451320161;
        Tue, 30 May 2023 05:55:20 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.174.231])
        by smtp.gmail.com with ESMTPSA id q18-20020a05683022d200b006af92bbffa8sm5543378otc.10.2023.05.30.05.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:55:19 -0700 (PDT)
Message-ID: <6475f237.050a0220.a0bb7.8d75@mx.google.com>
Date:   Tue, 30 May 2023 05:55:19 -0700 (PDT)
From:   bluez.test.bot@gmail.com
Content-Type: multipart/mixed; boundary="===============6988559729830396430=="
MIME-Version: 1.0
To:     linux-bluetooth@vger.kernel.org, dragos.panait@windriver.com
Subject: RE: Hardening against CVE-2023-2002
In-Reply-To: <20230530122629.231821-2-dragos.panait@windriver.com>
References: <20230530122629.231821-2-dragos.panait@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org
To:     linux-bluetooth@vger.kernel.org, dragos.panait@windriver.com
Subject: RE: Hardening against CVE-2023-2002
In-Reply-To: <20230530123944.241927-2-dragos.panait@windriver.com>
References: <20230530123944.241927-2-dragos.panait@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org
To:     linux-bluetooth@vger.kernel.org, dragos.panait@windriver.com
Subject: RE: Hardening against CVE-2023-2002
In-Reply-To: <20230530124208.242573-2-dragos.panait@windriver.com>
References: <20230530124208.242573-2-dragos.panait@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org
To:     linux-bluetooth@vger.kernel.org, dragos.panait@windriver.com
Subject: RE: Hardening against CVE-2023-2002
In-Reply-To: <20230530124715.248505-2-dragos.panait@windriver.com>
References: <20230530124715.248505-2-dragos.panait@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6988559729830396430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sock.c:987
error: net/bluetooth/hci_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6988559729830396430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sock.c:980
error: net/bluetooth/hci_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6988559729830396430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sock.c:980
error: net/bluetooth/hci_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6988559729830396430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sock.c:973
error: net/bluetooth/hci_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6988559729830396430==--
