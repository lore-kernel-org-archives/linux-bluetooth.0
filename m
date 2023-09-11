Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB367EE7FF4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Sep 2023 07:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjIKHk4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Sep 2023 03:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjIKHkz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Sep 2023 03:40:55 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68877118
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 00:40:51 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6516a8e2167so26528576d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 00:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694418050; x=1695022850; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q+Ye259iqLmMdMJw5P+IigcuTzJqJbzTEENJq5v3Ub8=;
        b=DJgA8zIJ0f2gdjdj3fE8psqoh7OLgf7Y4dk7UTylLxsQsEfzwXHxRw7NUZP2GOz8IZ
         +/dhyyAIsCfo7Rwv9eH4wKId4ROPRW3iUYpiW2v2x7bI1joXVTjY1gmDacbCS34JzHYq
         5RPJveDeT69JooMMTi6kFNB4ZV/UHL6UV5B8YJ/nR3+bx/MvgRQfiNvzyTFJ+ObavM3n
         Pc1v1gXBuFV2ZBD55g7arzioyOmxdA+8a8WtkkRSaMAW4T+c9l7Yxg5j59M2UGgTAXHc
         zvfJkxYFHfMbmwhAgnCD505fi0upeNnbpVSKYsRWxQIhXlva+zZH2jIsqXM8fS5A6pHF
         kwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694418050; x=1695022850;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+Ye259iqLmMdMJw5P+IigcuTzJqJbzTEENJq5v3Ub8=;
        b=QDr4AqSGGH71qq/exlPwCIAvkC+rSF18u68TJsMlv7bJ5JIOHyUCvF/wgM3RkXV3bV
         fQmamrrh73zUSWMc7hc3oMwAu3bhOkiE8D1oJqcBomL+eJISENeYznbGpaHcNehtKu5D
         n6bDWnvFD7H/gbO85CIrJ53gS660GXYl1oYuD+xnEIcqsrnXpehpVoPyqVgzcI7mv5mM
         eBiXFyzXfr7yF0/Lq7iEEAUnhbwlWRuceowVr31gtE2gjRwr6e3jidS61yMwuRwDfmpZ
         dalS6Qwyx1x+LnJGSGiHznBm4zurWpYZqdw3BEUmspHlkJaI7S45oHHYmtY8reHMalTw
         kaRg==
X-Gm-Message-State: AOJu0YziQrkfKCkU8vfEmZ3pz3k1wi/sRYzYaTQ8nGDSUEIW0ZN1iW1F
        p0oSQ46Y8685PlsE9F7XXEj/CviLbqA=
X-Google-Smtp-Source: AGHT+IGe5y+fc7DFXhzMs5loFyEjaxGkgXwmnXmdKIvwGU0J9jeKik+auttpwiKF8f0OxFkX3vRNzg==
X-Received: by 2002:a0c:e381:0:b0:64f:5ad7:f57b with SMTP id a1-20020a0ce381000000b0064f5ad7f57bmr7299704qvl.6.1694418050124;
        Mon, 11 Sep 2023 00:40:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.158.56])
        by smtp.gmail.com with ESMTPSA id c18-20020a0cca12000000b0064723b94a23sm2722348qvk.27.2023.09.11.00.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 00:40:49 -0700 (PDT)
Message-ID: <64fec481.0c0a0220.fc9e2.9de5@mx.google.com>
Date:   Mon, 11 Sep 2023 00:40:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2076085610835003962=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: bap: Use defer setup when syncing to a BIS source
In-Reply-To: <20230911061624.30600-2-vlad.pruteanu@nxp.com>
References: <20230911061624.30600-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2076085610835003962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=782813

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.36 seconds
BuildEll                      PASS      28.20 seconds
BluezMake                     PASS      934.65 seconds
MakeCheck                     PASS      12.39 seconds
MakeDistcheck                 PASS      162.65 seconds
CheckValgrind                 PASS      264.44 seconds
CheckSmatch                   PASS      356.71 seconds
bluezmakeextell               PASS      108.14 seconds
IncrementalBuild              PASS      765.23 seconds
ScanBuild                     PASS      1121.72 seconds



---
Regards,
Linux Bluetooth


--===============2076085610835003962==--
