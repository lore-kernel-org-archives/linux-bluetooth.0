Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC493CA0ECA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 08:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjILILj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 04:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjILILi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 04:11:38 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A3FE78
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 01:11:34 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-792707f78b5so181332139f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 01:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694506293; x=1695111093; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MlXgdW+3vPqPVvU9LyZszNZEHsxEeH9ermUCAER+y5A=;
        b=StMXiU96/Vz7AF5U+O4odQyNA1X1Oa59GEYZvizCqeJQAddtHbrdxtdFS/EUtgt8nz
         q495rGNFEvfr266h6Vmz2TAVfMvv/KDTEMNRTWcc7Vmc+g+k9AtHHIbMzhD8bFuDcVUc
         4iBvEWgqUy6G+5Om8OJeGgM4qlj5IvJ1UfWkg53WSjNrguZpfqNS0YkjMSFrq8aQ1VGg
         3N9VSxMl02mZua+aB9mqjiJKzj4bpte4k3QFo58zGmj3MS7cnMX787U3gnVTeu7WJU7I
         5I5CqOKyWgK+ZoMCWmPEnjVESIR+RFtypRXyCjsuh+8SDe9etFyXXKWbcaTI1eJAcyYh
         ypPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694506293; x=1695111093;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlXgdW+3vPqPVvU9LyZszNZEHsxEeH9ermUCAER+y5A=;
        b=Nsw2nxDFZayGvOREpLtoKX2geeXEcP+Z+c30CY+6Y18fUDChK5uMwOrAEKp5vuDv8T
         o+xHbZzbrdg4IVirGGhnuPs8NQaaoFAYwApi5WiKu+lOolT63IBz8ClrcpOzXJm4O5oe
         UU4jmxixSkPQtLNXyecSUM6L5hWY3ka7TxopiEcmgjR1muFbLYAhiVWlPv9NKTHIEbdY
         v92/qXY0ow66PoIrDdcsc6nj9xwGbLEguKz6wc1UA3CCM63QuDDIWFRRdzQq3Sj59mOP
         2WRqY6k3sKhlUMUtfzKmVEk/D9zUNwmosFNT05cp6qBSGAeuBKaoJ1fYmAtCt55XhCdW
         c7Vg==
X-Gm-Message-State: AOJu0Yyv/Ze8W2VQDwkz+fkYm0E9HBMwEmu+x7aehd+OdxrsyQUy7Dsr
        pjGTrDuJsPbiXgOxhmRQj167DcfvA/I=
X-Google-Smtp-Source: AGHT+IFW/keBe0D8+uIOnKdz4OzIvbuWPoZedL4kCmkAvbpDFBJpjDY8pxebafjvsluHOsNTysK4SA==
X-Received: by 2002:a5e:aa10:0:b0:786:7389:51d7 with SMTP id s16-20020a5eaa10000000b00786738951d7mr14593745ioe.5.1694506293297;
        Tue, 12 Sep 2023 01:11:33 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.66.98])
        by smtp.gmail.com with ESMTPSA id t12-20020a5e990c000000b0079187c8524asm2729035ioj.3.2023.09.12.01.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:11:33 -0700 (PDT)
Message-ID: <65001d35.5e0a0220.8be47.395f@mx.google.com>
Date:   Tue, 12 Sep 2023 01:11:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1965639320946129183=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: bap: Use defer setup when syncing to a BIS source
In-Reply-To: <20230912065526.1217334-2-vlad.pruteanu@nxp.com>
References: <20230912065526.1217334-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1965639320946129183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=783280

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      29.06 seconds
BluezMake                     PASS      840.08 seconds
MakeCheck                     PASS      11.80 seconds
MakeDistcheck                 PASS      157.82 seconds
CheckValgrind                 PASS      257.94 seconds
CheckSmatch                   PASS      345.20 seconds
bluezmakeextell               PASS      104.53 seconds
IncrementalBuild              PASS      680.51 seconds
ScanBuild                     PASS      1071.01 seconds



---
Regards,
Linux Bluetooth


--===============1965639320946129183==--
