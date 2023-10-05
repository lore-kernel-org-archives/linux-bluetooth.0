Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABAEE9271E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Oct 2023 17:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjJERtm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjJERtB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Oct 2023 13:49:01 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44147F2
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 10:49:00 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6907e44665bso1100736b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Oct 2023 10:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696528139; x=1697132939; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VvniN9i9zW8MoISnVWmdBisO4vEaMpWrQs7qzq2qTkw=;
        b=Jd7gJAUhZvASC0uRRnjjVCxTRXdtT6OD2vUbj+3GBma22mu/dF9sx+8AEZFC+CtDA7
         fyW295AzyvV5N2N7o0Chect67hsB/O1uJytHCu+VdncKLzL9uv47FX90ENFFsWjdBAaX
         1IiZDPac0YVXsq6YZsGTmf9vVfP16h3lScdBa1NTgLrygRenLiR5rQUy//ltUBB5n8nV
         6eLYrLjL0VDJlK2Aa71DqKpLviIG7ObBMHMqoYz+NHKZrBhHE6DoHpKbuhlcGYof+3MA
         U6WkSJPZj1hrEHucUR+XYOAk6+4wFr69dL4Xro3sONdztXOx0zmgChPW6wAza93X4U56
         HTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696528139; x=1697132939;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VvniN9i9zW8MoISnVWmdBisO4vEaMpWrQs7qzq2qTkw=;
        b=FgYLJi3wMJxIjSkGl/uIwLSgj7TVMt+ApBoKNuOdpWn9PhazgqNIxDLyn5aytm9hGi
         b419GU/r08dhllp9SrSdcoKp/f9RkEYjrhrtVrgR0ob+4kVvjgttN9cSbwN0hahTkM0x
         ZayWC6Sa3eI9E3fGZEr9c+flxddzso955kZKxsdjVXHCpiIkaXXJzA1NUpzEiITb93sV
         oxBjkd+LwnGpBHVlvN9HgCpXiRaS3gT2AVtToW4kS/3omwNkp17oly8PezU+Di1MSujz
         SyfAyVbSL9H/TBj9d0ujfJ5H+h1LmkTMqdJqQ1arPpwkAA6Ov0NmHsshI0c9F/HDEjoz
         CxGQ==
X-Gm-Message-State: AOJu0YwwmqrD1FfgYo7TegLR0ztU/yH6pEFzJRggGbUs2nhMEgX7sqsH
        XbmwBPmplcD3z23r4VmbZxpHP6k/dYM=
X-Google-Smtp-Source: AGHT+IGd+2My3rpAjZvGUOYKfhGsPT/QKuHew85mlPiZVrcpopNwwIGitroz/is8upjQQ2sGuRWcZg==
X-Received: by 2002:aa7:8884:0:b0:68a:5773:6319 with SMTP id z4-20020aa78884000000b0068a57736319mr7142092pfe.11.1696528139509;
        Thu, 05 Oct 2023 10:48:59 -0700 (PDT)
Received: from [172.17.0.2] ([13.64.11.208])
        by smtp.gmail.com with ESMTPSA id w22-20020aa78596000000b006889348ba6esm1662114pfn.127.2023.10.05.10.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 10:48:59 -0700 (PDT)
Message-ID: <651ef70b.a70a0220.e1bfe.5293@mx.google.com>
Date:   Thu, 05 Oct 2023 10:48:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7406016382910235369=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mahesh.talewad@nxp.com
Subject: RE: MICP-MICS implementation's memory fix and Unit Test case's fix
In-Reply-To: <20231005121544.306495-3-mahesh.talewad@nxp.com>
References: <20231005121544.306495-3-mahesh.talewad@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7406016382910235369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=790316

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      41.42 seconds
BluezMake                     PASS      1330.05 seconds
MakeCheck                     PASS      14.39 seconds
MakeDistcheck                 PASS      237.20 seconds
CheckValgrind                 PASS      361.75 seconds
CheckSmatch                   PASS      507.23 seconds
bluezmakeextell               PASS      156.71 seconds
IncrementalBuild              PASS      1149.09 seconds
ScanBuild                     PASS      1605.37 seconds



---
Regards,
Linux Bluetooth


--===============7406016382910235369==--
