Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5E1C0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 10:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjG1K0q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 06:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbjG1K0P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 06:26:15 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B6C4C08
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 03:25:36 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b9defb366eso1672229a34.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 03:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690539935; x=1691144735;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSJuDkW2bX3XuG5xMgt8wmSdFOa4VtfSTamHBbEURvQ=;
        b=rON7RUXzgB2ILFNEIJH3ACgyFHD7RojUTeQ19NcJAS0eVKRCXCOauua3iqkSjvGoCq
         HZYPXxuqTc4hjMQP++0lc7P97hw1bPuoAtu0jARSdg8rXqHXyyYYWiWVSnhbNO7+bPeX
         5ZWdtMwRbVPmUfX0OuSzXtPRzmbXS1yLR80XlHIwQtKUzk516BCzzcgLbe2jRBKv3yJf
         vAz6EIoLcD+/85JLSZgNQKLZo6ZtzcbwB9Z/v0CKwPTum4DdZZ+ygpe3VvIALtrWgNe0
         lVcvYzEyzzRK0ujM7dJndx+XmWpLP7O+V/LSs5Do2FelZ3m6XTtZscIehKq3OvYYpBo8
         OgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690539935; x=1691144735;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSJuDkW2bX3XuG5xMgt8wmSdFOa4VtfSTamHBbEURvQ=;
        b=kuaHYBs1eeB+mBXlZ/OnnLhmbLJDZc8FeTyzQunpMIcHtrg2sTHZIYNRSNYfg0ygIp
         wpBsLsrnenMitSzclUD8Vxnwudy3OcwouelxdU64QFz7VMv5wDCWPm1FiZ9LBiZYlL9/
         lOtBw+k6nZONmpFdl8ONcpJakDvZLtHJ/6Dno70Zt+OR23dMtCh74Yo2RyuiWbD2Y6iO
         K7bHmylddY4bgr8T85v7RBMrIJfYC1+PRXZx4qrMPIs/Uc1dwrpegeIIrl+pR+6YBrVl
         jGhFTHfvLgP8wU29Xd8448kn5xZFI77VR4d3gSy+UgAY3khHBqn2i08mF8jMhmPxnSGZ
         EATA==
X-Gm-Message-State: ABy/qLbMeN2EGMbPM0AusN1+JJV3yRMIGmPAQGsXq1jGDuTgihn6mn4B
        jZA5/9NIZr5CX+JMDpj5xqK8xAS6saI=
X-Google-Smtp-Source: APBJJlFov7CARE7gtwoA7rV4zAOXYvXwbn0fuDwO90W0UW04fDmhImpGQBhxdtpmwSBgzIDvtHh9dg==
X-Received: by 2002:a9d:5e90:0:b0:6b5:920c:649c with SMTP id f16-20020a9d5e90000000b006b5920c649cmr2206900otl.29.1690539935383;
        Fri, 28 Jul 2023 03:25:35 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.138.133])
        by smtp.gmail.com with ESMTPSA id l6-20020a0568301d6600b006b87f593877sm234446oti.37.2023.07.28.03.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 03:25:34 -0700 (PDT)
Message-ID: <64c3979e.050a0220.f2965.0cb3@mx.google.com>
Date:   Fri, 28 Jul 2023 03:25:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7138538921940473583=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] advertising: Fix peripheral adverts when Discoverable = false
In-Reply-To: <20230728085713.683655-1-simon.mikuda@streamunlimited.com>
References: <20230728085713.683655-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7138538921940473583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=770478

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      35.46 seconds
BluezMake                     PASS      1077.40 seconds
MakeCheck                     PASS      12.44 seconds
MakeDistcheck                 PASS      183.39 seconds
CheckValgrind                 PASS      296.96 seconds
CheckSmatch                   PASS      407.05 seconds
bluezmakeextell               PASS      121.52 seconds
IncrementalBuild              PASS      958.51 seconds
ScanBuild                     PASS      1241.02 seconds



---
Regards,
Linux Bluetooth


--===============7138538921940473583==--
