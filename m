Return-Path: <SRS0=BnFh=AL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111E3C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 18:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F2C20722
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 18:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtEljWmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbgF3SSL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgF3SSK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Jun 2020 14:18:10 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EE9C061755
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2020 11:18:10 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id j80so19572694qke.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2020 11:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=sn0glQxiqn/8NcrI67Txd/y31mvg+aG4rpK/LJ6p8ww=;
        b=QtEljWmTExkczWdEYqpl9k6XoVpCspRvPytEOSTZeEnvjz19Nt45B8Ah2xDIobpXyI
         1Bdh0TekD+sIzF/uPnTr6PkINMsUyN0C8G43sqZWxcPgnbMsciuOXOAoi+t+HGl2050B
         NNm1EFZP8yT/bTJKbZAZFbTihX60IsVeUYNqJMiQQLwFYxiRJIZ6i3Rfe8uxdmV7bSZ5
         iMYr1iSV4FtsCv+MU2qKzaAMeUHL1KpMs+yN/+2WxufLPK3eS+QyIhhG/pxEw78rZYnG
         VwQZfWlBKEOGKicBFzW8Xcj/PIzfk3A7NHn1482MAa3sHlAHkahXClQUtHeqBnFl50NT
         3TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=sn0glQxiqn/8NcrI67Txd/y31mvg+aG4rpK/LJ6p8ww=;
        b=FkswI4/jW1tJRRhPhMni0gGpkyj0pRnodRH1s/miK/igpqVHz2pDstX1oxYwke5FGm
         i/TxfqR1VSzE/QYSQihEY4V+fC9BXqqjMq4wsHhDKObwzUFp2w+Km1bUFEOmDCOBtX/s
         /6e8P7fzch/ksRgplJI+VdASyGvu6UbWSNUn9VRErYwVMOxw6cczCMvcuOP7nil7v4EM
         Jg99vnKYABC3AauwPCFlWanYbTKbARh2cXd5fM6K5anTIBQEp3+EywKp+THEor680DTV
         120a8Bi0s9q+M8JGezl0SpmsAXRTXPKguI5xO8bPKEbs/JvuQMq7W27nOF4K45Ny3lwc
         wDCQ==
X-Gm-Message-State: AOAM53229z/XM90doJ8vBaUdAfnQr6yVAVF2iNKpFPWfRAOwiTCzwI4l
        Hn6fpI5wlaRwMaMeIaHBACfFIE4EBqs=
X-Google-Smtp-Source: ABdhPJyUUDeZtw4lA6MV/mexVcm0jMDsL1Kf9TdcMoqL9OTK7ahSejnYkRDUmNb+YDlKl9Ph8MEAJw==
X-Received: by 2002:a37:65cc:: with SMTP id z195mr19812659qkb.89.1593541087743;
        Tue, 30 Jun 2020 11:18:07 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.132.39])
        by smtp.gmail.com with ESMTPSA id p25sm3576923qki.107.2020.06.30.11.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 11:18:06 -0700 (PDT)
Message-ID: <5efb81de.1c69fb81.1d653.158b@mx.google.com>
Date:   Tue, 30 Jun 2020 11:18:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1402526054168955741=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [1/1] client: Add battery command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200630174707.214317-1-sonnysasaka@chromium.org>
References: <20200630174707.214317-1-sonnysasaka@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1402526054168955741==
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
WARNING:LINE_SPACING: Missing a blank line after declarations
#79: FILE: client/main.c:789:
+		GDBusProxy *proxy = list->data;
+		if (strcmp(g_dbus_proxy_get_path(proxy), path) == 0)

- total: 0 errors, 1 warnings, 110 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============1402526054168955741==--
