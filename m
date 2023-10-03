Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FB7E8FDA1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 19:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjJCTaY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 15:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjJCTaX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 15:30:23 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D8893
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 12:30:20 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-65afba4cfadso8739856d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Oct 2023 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696361420; x=1696966220; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CjWunXf8fwiAkC3xylox/Pkl+Usii5kmU5DuN7Io72M=;
        b=WdSQ1w3e6JtDwYRrS6zP5OQzpFVquFhDv+JzqzhHlqt8pz0QMWm0106esxwhDBU6G6
         nopha7bHUZpOnoTBumoIGssF/eofo7l00O1hAYS5k4r8J+edvXdrXxK+bQR/LKzB4V6F
         Meazux3wn2yr+ajyFyCyUsYumzmPdKwj125XGgfXDJTUWvBdCOWk8Y43zJ0hHSAwAFyz
         5wr4LpOusUN8H9yUea0L48nTjBsu1R+PFJwUs89T28FbnKrF0CLZwRcBaMY70jLRnu+K
         thQpA4GXSMNl4ZNO+FS5Bf0R4E/r/16jxKMBgclKmKZGxCXea9gnWG6mCdLHk2cfea6k
         TVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361420; x=1696966220;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjWunXf8fwiAkC3xylox/Pkl+Usii5kmU5DuN7Io72M=;
        b=WyGcNSCRQoMfQK+iSOj+v23ZUn/TkJQGfeYnxYGzyN0ay3NsIyGKHePGNBBAXjwWJN
         XlFaeeO2N9kjiOIzhWNaQPa9Kb/q2d85Y740Z25PBoCZpfXdi2qHPYLPizVpXCIzuV2Z
         niBYIxgkD/nidssRUprxyk5NGPPUCMeyZ14r7fr7GQEfqV0YjVr4mtr/k9hJGm/Bz+MC
         jZm2+c+xiH0QSwaFqCCzf3j8LGcKa6ZiRW9yA9EVHVwMW5G2FnSozeIvQwKoED5F5aDM
         PErP23D4qwjmq1TXZyDUbJydn1cNKTZeJWnr8DO8ELyGmj1VPcVt15unhkaS2D5NMlii
         yFgQ==
X-Gm-Message-State: AOJu0YzWopCG5DvKgmjLkfiR2O4JXjJFFS1ZZhR4/TQv4NrhldciFL2x
        GnedaJT/fPLUHfBUfK7SUuQUCXuS55Q=
X-Google-Smtp-Source: AGHT+IG88tHdW3LLMd8hlTreTvOmn9wzU19UePe7r13LWRwVS/o1HfTDMTfhWpYCvFd6p+2GBqGNQQ==
X-Received: by 2002:a0c:e342:0:b0:660:9a8d:8d23 with SMTP id a2-20020a0ce342000000b006609a8d8d23mr299957qvm.25.1696361419786;
        Tue, 03 Oct 2023 12:30:19 -0700 (PDT)
Received: from [172.17.0.2] ([52.184.138.35])
        by smtp.gmail.com with ESMTPSA id h4-20020a0cab04000000b0065af657ddf7sm720703qvb.144.2023.10.03.12.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:30:19 -0700 (PDT)
Message-ID: <651c6bcb.0c0a0220.97ade.3f84@mx.google.com>
Date:   Tue, 03 Oct 2023 12:30:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8627738126053944691=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2,1/2] bap: use MediaEndpoint related properties consistently
In-Reply-To: <112613bc64e4d17573b75a9d245b5fe5e51b5fa1.1696354690.git.pav@iki.fi>
References: <112613bc64e4d17573b75a9d245b5fe5e51b5fa1.1696354690.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8627738126053944691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789673

---Test result---

Test Summary:
CheckPatch                    PASS      1.96 seconds
GitLint                       PASS      0.71 seconds
BuildEll                      PASS      28.57 seconds
BluezMake                     PASS      880.09 seconds
MakeCheck                     PASS      12.43 seconds
MakeDistcheck                 PASS      161.87 seconds
CheckValgrind                 PASS      263.48 seconds
CheckSmatch                   PASS      357.03 seconds
bluezmakeextell               PASS      109.02 seconds
IncrementalBuild              PASS      1436.59 seconds
ScanBuild                     PASS      1090.66 seconds



---
Regards,
Linux Bluetooth


--===============8627738126053944691==--
