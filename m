Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A814C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 May 2023 00:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjE1A5P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 27 May 2023 20:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1A5O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 27 May 2023 20:57:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B1CD3
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 May 2023 17:57:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d2981e3abso1761311b3a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 May 2023 17:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685235432; x=1687827432;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oueXPhJL3rKIK1LXnWBTyVRc5Z2fv+ewuX3HOEcaVY0=;
        b=nuhCrjKYaDO5zaFCyP7ipxZofCT5reK7ld4iLoMMDhOqZk4DxsY2ugCzFqpau4+Ffc
         8WF60CWX70MvSQ0940CRHcex1TwVHxODsK9Gvxk4p6A3PcgkeYEq/wnTr1+wqgjK0XmG
         TGJI3JZeMM1zidFTOi/J+w9iH6+p45b0qa9FDTCAP5JWKheHpDG6IUNyLBqbYLcEJXdC
         1kMRnYmm2InuvEkqUGV+xDOfb8jC3kKL8vMELwm+9aV9cxEJe5+6hasRa0T6uzWUqR+U
         fOvJVyAd08MnSL3QGpec8338cyQe8iuD1dY3hj9T4Uw9NEdeqc/G72GvaZYAmTuAddvx
         ecEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685235432; x=1687827432;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oueXPhJL3rKIK1LXnWBTyVRc5Z2fv+ewuX3HOEcaVY0=;
        b=B6XGE5dssXBDLVyGQvx7z+mi3XEGI5IBiobmRXx4vNZRLnBv/zRfseh7TkIOcezUxn
         CYaerGLV23dMxpGGg3HhW7zWin/CfMZIvql+kfjzleYHABpTG+r2KhvO5lKDxT0PeH0O
         XAnhIj0K0YNei6YFzBNN7JWB04mLP2xNGeLVh3p7i1QxF0wp6L2K+MLcBWAYk+pZV63S
         +6P3u77g7brR4xvPSODqvXwC2dzawFnBdVHbHBs4mFPHwF9SnJ8c+TRWpbQmlMG8yaWg
         t0gKM4MESqh6k9rqC/buIoJKXIrg5YkhPKI3TBiRyKmehBBsz5ddYsv58FFZScX69XKr
         Wggw==
X-Gm-Message-State: AC+VfDyCvnY3atrY+I4HbKenc5L+Zpq+U3K4tht6hMsrjZ907SxdaJpq
        UTCpkvJ9XdIGtkvbOuqfohW6A6wGjts=
X-Google-Smtp-Source: ACHHUZ6tsxRfnDqp7or1+PQtKDNlTDUtMJORk50A6DSLl6p0YB3OHmF+Im3bY/RAGVPdpt/H5iX7Lg==
X-Received: by 2002:a05:6a20:1594:b0:10f:759d:c5b2 with SMTP id h20-20020a056a20159400b0010f759dc5b2mr5126032pzj.45.1685235432157;
        Sat, 27 May 2023 17:57:12 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.99.208])
        by smtp.gmail.com with ESMTPSA id c19-20020aa781d3000000b0064d27a28451sm2335061pfn.100.2023.05.27.17.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 17:57:11 -0700 (PDT)
Message-ID: <6472a6e7.a70a0220.e9236.496a@mx.google.com>
Date:   Sat, 27 May 2023 17:57:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5380044020651550942=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ] media: Register app objects in proxy_added_cb()
In-Reply-To: <20230527231458.673167-1-arkadiusz.bokowy@gmail.com>
References: <20230527231458.673167-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5380044020651550942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=751626

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      34.50 seconds
BluezMake                     PASS      1172.85 seconds
MakeCheck                     PASS      12.91 seconds
MakeDistcheck                 PASS      198.14 seconds
CheckValgrind                 PASS      322.43 seconds
CheckSmatch                   PASS      446.16 seconds
bluezmakeextell               PASS      132.82 seconds
IncrementalBuild              PASS      1016.34 seconds
ScanBuild                     PASS      1429.99 seconds



---
Regards,
Linux Bluetooth


--===============5380044020651550942==--
