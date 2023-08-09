Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A04C001B0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 08:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjHIIYh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 04:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjHIIYg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 04:24:36 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6571703
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 01:24:36 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1bbaa549bcbso5173833fac.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Aug 2023 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691569475; x=1692174275;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+YVLnyXNjIGjK/vyhAVOSjsfssG9kpOsOnBMVvYm29o=;
        b=HA7FWftXJg19ueqzCIAlyZpDixeqtkPNx/l1g+3cnEZvcctKBJlO8VuGnHlwO07bMo
         gEJ/mIrrQieYkBeZjOCpZgKfRgY13HOB893YTs5Gz+x+prK4CKQKDf//PAq60bMMPdZE
         BKEUlbThJ/P2tXvOZdFF48N8sF+3C+gudDhGoCSxiTuBVfkKIvsfcfZZ0tssltDxmvXV
         OmdzRO9yh2ihw6E+6+Yl/QL0CkYKLn7qxHZPI+m1LW7nnNnusS8k3HmbgsaB+7XqPRW1
         /H6rp+d1h3QSDTUxuFZ9YDqikOF6iq1lLjD7h1b24rsXyspagukaYm+rED9ZT5SD1fis
         +AxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691569475; x=1692174275;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YVLnyXNjIGjK/vyhAVOSjsfssG9kpOsOnBMVvYm29o=;
        b=YFXm8pJ5VesPNbkV8BGl5Z2LCzdQkEx4P2XQT6XahjG3MGLFsHEq+chQjHKf4G2d2Y
         wws9+qOssMSHD8y8BTNmLIt12N2f1VV6rYw/irfZt0uNzFotyNoLC2LF8zOxFe7d65X2
         sp2YWeD78sisbCyCdmshVpZ4qhjU/wSYLpBqTn/9KJ9GV45ytJ1q9j+zcpK+Sduzc6rr
         vcg7UdhY3HGxsB7vDt9NI6w9qkICDztvKnZKdMb9VxCJ0ZkHUbCN85nSM9oJ+hFqkd2E
         nsVsXniVlCzJ3r86Uuvqo1FLJ9BF6f3adM0jtgzSiLn5L2wV7joQdZwiS4cim62eszbf
         svew==
X-Gm-Message-State: AOJu0Yx31goh2BxLzcWhYOoUTWZBmDvAB54ajLaHm10PaboyQ26lZHje
        7YbdrF3U4kIWLjbO2sQsmdVo+kZBC94=
X-Google-Smtp-Source: AGHT+IHlwsQH+FVsxfEemzSDlO9AL1gnJ2O+x2Kks6YIY+eCxMSBKxl4JHTlxKaqgSQSDYVhkwTv1Q==
X-Received: by 2002:a05:6870:32ca:b0:1bb:5676:a62c with SMTP id r10-20020a05687032ca00b001bb5676a62cmr2641319oac.33.1691569475226;
        Wed, 09 Aug 2023 01:24:35 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.50.160])
        by smtp.gmail.com with ESMTPSA id gj21-20020a0566386a1500b0042b6a760c31sm3773432jab.28.2023.08.09.01.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 01:24:34 -0700 (PDT)
Message-ID: <64d34d42.050a0220.52023.4dad@mx.google.com>
Date:   Wed, 09 Aug 2023 01:24:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5513451988273770102=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, gioele@svario.it
Subject: RE: configure.ac: Install D-Bus policy in /usr/share, not /etc
In-Reply-To: <20230809064441.2002194-2-gioele@svario.it>
References: <20230809064441.2002194-2-gioele@svario.it>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5513451988273770102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=774386

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.55 seconds
BuildEll                      PASS      27.73 seconds
BluezMake                     PASS      872.97 seconds
MakeCheck                     PASS      12.16 seconds
MakeDistcheck                 PASS      156.44 seconds
CheckValgrind                 PASS      257.54 seconds
CheckSmatch                   PASS      345.07 seconds
bluezmakeextell               PASS      104.25 seconds
IncrementalBuild              PASS      1428.82 seconds
ScanBuild                     PASS      1060.13 seconds



---
Regards,
Linux Bluetooth


--===============5513451988273770102==--
