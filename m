Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57106CE79A9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Sep 2023 01:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjITBzU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Sep 2023 21:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITBzT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Sep 2023 21:55:19 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A82BE
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 18:55:12 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76f18e09716so399245685a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 18:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695174911; x=1695779711; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3BwIqMKAVLeWHwrTp2oQRJ/K4logqodhdFHXMKfFg58=;
        b=Dunlu7WXbezwCmX0ZpMn5z6DG7FU40WTDVTC/t61L3s3YI+TrjUeOocF8rVGL8LutS
         Ydl+0P6WI4ACUviXdF9nKr7WsXiokdhqGIawLlY+GOETjM0XRt5LA78oLbLGmZu0Vq7A
         seCHqymXo+YtWCiDbjO46btiwlBVach2uuhwQY+/0YRcTTDNrMRBq6uAmnwzwYUVlmFA
         58hEYX2QiwdPSNgYpHbW+WAdoLbL9SHuGg2WfbNEZrHRuMUmufMj8EUouwT2cAkv5HWp
         3nq8qYmcjQtRFoBHaUFYUiY2cyoQLi54ktmPPkSLdtDPcpG3/WAgscFE5E3urmNYGTS9
         rCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695174911; x=1695779711;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BwIqMKAVLeWHwrTp2oQRJ/K4logqodhdFHXMKfFg58=;
        b=CNtbwsvFlenXGCoEHyg31jLNrJDMp6QrXeYWD0tjuF7VbqWeUgFQy0Sz0MEYvgaRlM
         vqUe5q1Xe1Bucdbg3sbpXK5H7/sKyejP7ykmfaEbWRGr0UIXGV++ZwRt2ZB618x1teBo
         9CYTO81YmpAOIAwFbXohc5ftS2Z4rLa1+fTg5tElICg4rVS3xv5tiqBbRG0n+cQxq1AI
         uWFzFpZHqsIQSwy9pZO7m/ROrN9J9rSyVJOrg25tTjG1pXD4Cfl42fLt9bGLy8T9BFqV
         3BjZ++1ntsS/Xcf6HwitAsaYWrzMUqFZrptwttvSc1xva10kGICrAQ8kj33UuODPTlSQ
         oOTQ==
X-Gm-Message-State: AOJu0Yx88+RDAKgBSweDYQdB6jD6ub/T+u6jnAWputoICyZDVeU0PaBe
        J2CjNXDv+sZEX5MVMyGKVS/Cufe5GXc=
X-Google-Smtp-Source: AGHT+IELLuOp3V13sNuuWGPlQD292s0j7rBieUnvrCVGViSmL8zsPH7HB8c1gSWgO8elJ5zKJsKvsw==
X-Received: by 2002:a05:620a:46a4:b0:770:f29f:d1d9 with SMTP id bq36-20020a05620a46a400b00770f29fd1d9mr1671503qkb.2.1695174911178;
        Tue, 19 Sep 2023 18:55:11 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.153])
        by smtp.gmail.com with ESMTPSA id y9-20020a37e309000000b0076d1e149701sm4426239qki.115.2023.09.19.18.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 18:55:10 -0700 (PDT)
Message-ID: <650a50fe.370a0220.fbf1c.0ee5@mx.google.com>
Date:   Tue, 19 Sep 2023 18:55:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5836743390147136777=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] media-api: Convert to ReStructuredText format
In-Reply-To: <20230920001004.355664-1-luiz.dentz@gmail.com>
References: <20230920001004.355664-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5836743390147136777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=785772

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
GitLint                       PASS      0.45 seconds
BuildEll                      PASS      28.57 seconds
BluezMake                     PASS      867.03 seconds
MakeCheck                     PASS      13.69 seconds
MakeDistcheck                 PASS      160.97 seconds
CheckValgrind                 PASS      260.56 seconds
CheckSmatch                   PASS      351.36 seconds
bluezmakeextell               PASS      106.75 seconds
IncrementalBuild              PASS      715.30 seconds
ScanBuild                     PASS      1078.27 seconds



---
Regards,
Linux Bluetooth


--===============5836743390147136777==--
