Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D293EE4993
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 16:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbjHVQBu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 12:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbjHVQBu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 12:01:50 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B734910F
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 09:01:48 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4039f7e1d3aso30502421cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 09:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692720107; x=1693324907;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hRjFPRJy42B91HA/jaSnb3cX/rpqqKUXBYQ7uI5lVYM=;
        b=egaHDF+97jn8OqHzmsYccZNJlRAFP07dVs9OkM8B9nVEU2X5WQkS24sF5TM4Phh54J
         dgZfUTnfAn8X7uzO0x7H6v7F5ttVk/9GjlgrALKLX/p4L39DtsSDdM4HqNQrRBkJ+chd
         iqxdpWWxoTyEnfljznkNcFmotpXXR/P9dLl5y396tNg/G9IvuPJcFPHSvYVzs5PbdzPU
         UiStJ9eB3D2sNt1/0qVf3VevANFcXq3X2G5PVgZmi1vS308ojcUcFUzpGLNpGGdAwatq
         TJ3l0EDgnaw2CDOZzEjmGaY94+qBCM4hNQTleqcrsHzRhKJr82NlnXDle3AUcvM/BvXM
         2/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692720107; x=1693324907;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRjFPRJy42B91HA/jaSnb3cX/rpqqKUXBYQ7uI5lVYM=;
        b=OXwb69uoVzA/MbyMAl8/Y/i4WDnqo9/rlYuRqFAkrX8ArE8vnSbjheDcVdJyK8pLiC
         E5TY8eVoIxdv3WsIeT4esE59/nlzv1zP18xuKgsXFZbQ9jt5v+dP5LMgx965Bucc462f
         Cse0/Bz9ySScVgR/bzvpMMZ8nCBqtF727KFuV0OyQeR1MPErkRzWbK7DJT2gakgTt5Dm
         S6ISZIZWRFg3tpMn22RWoTg7ZrLEpIce1d73Bvj2zpfkTzvDo6ycfUvneLNwveFeIe9d
         p+MO4WP70xjGYCfuo0ZTF+JjArByopqLFYeiTmvydA0cl3v6f3HcI31dTzICtnfNofbK
         630g==
X-Gm-Message-State: AOJu0Yzw+ZhAkmO9Ee/8Z1XdUIWBa9Yq1SuNehQYZiU0VA6A5TK2yTX4
        d9f2tKTJQze7b/ERJEaoS9y5tXefF4Y=
X-Google-Smtp-Source: AGHT+IEqziwG4r7OtrCdcBaZNxzcC9I/oe3xm+vT9DTwATw70AO8rGbJ9aq6Yb23n1IPELidiHe0Bw==
X-Received: by 2002:a05:622a:309:b0:403:b12b:908d with SMTP id q9-20020a05622a030900b00403b12b908dmr12337770qtw.8.1692720107578;
        Tue, 22 Aug 2023 09:01:47 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.119])
        by smtp.gmail.com with ESMTPSA id b5-20020ac86bc5000000b0040eaaaebf6fsm731226qtt.19.2023.08.22.09.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 09:01:47 -0700 (PDT)
Message-ID: <64e4dbeb.c80a0220.a1438.3e36@mx.google.com>
Date:   Tue, 22 Aug 2023 09:01:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4701925102838865728=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Add support for BAP broadcast sink
In-Reply-To: <20230822142935.6016-2-claudia.rosu@nxp.com>
References: <20230822142935.6016-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4701925102838865728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=778253

---Test result---

Test Summary:
CheckPatch                    PASS      2.14 seconds
GitLint                       PASS      1.07 seconds
BuildEll                      PASS      27.40 seconds
BluezMake                     PASS      855.03 seconds
MakeCheck                     PASS      11.67 seconds
MakeDistcheck                 PASS      154.84 seconds
CheckValgrind                 PASS      255.06 seconds
CheckSmatch                   PASS      340.66 seconds
bluezmakeextell               PASS      103.36 seconds
IncrementalBuild              PASS      2169.03 seconds
ScanBuild                     PASS      1126.66 seconds



---
Regards,
Linux Bluetooth


--===============4701925102838865728==--
