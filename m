Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF31BC77B75
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 May 2023 02:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjEJCdz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 May 2023 22:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEJCdx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 May 2023 22:33:53 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146A3273C
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 May 2023 19:33:48 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7576564359bso418818185a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 May 2023 19:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683686026; x=1686278026;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Em0s9Iskump09g+jXx3XnSgI6CIe0iWbplkmI1TJOFk=;
        b=YcVXNyTrlj3ZsHP2anFUwquJx8RJtBq6E+rt9idmyo3lYyLmAtDRpvbuaEThcpsrwF
         gcdXJKEpQnYDCh/2tFmFuriwViIqyNTaInIVGhHCHqgQAERVR4uN3wyDDZk0lZfhH2fV
         0ADMfZdQ2I+Y253UCOR8jkRlP/UEk6nwcuUw5GCnCyFYGDNuo7Mrv4L+cKIR+VUofszI
         2SqKFvMlxW14IpD8eP3qK0O90S+Im9GY7+6vX+7dIU4ZYLsKcDwMv7Tf+7UgOdSQQg5P
         jAz/s6MCwHhaXv3woCr/uOrZBX96pXJFuNbRHMShHsv3XmlB6ERr1bUj7SKeUDPqNd+e
         FF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683686026; x=1686278026;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Em0s9Iskump09g+jXx3XnSgI6CIe0iWbplkmI1TJOFk=;
        b=dWJqEyaLjJl4GJ1resB9telJigb/ukbNQEwgFNIeQLVZxBFGhNtAk8WG3F7Njr10Yn
         oA+bP6bO05NLiucWhVeab7PL1tY1hZFcN0Fgu9hWUXhEDJqQqxr2fAKKzobEY07cc+oW
         zVgU6YvJb9g9Ajl3BMvROCIErUuwqQIC1AzEWeV6ztXpVMhubK5cYxD2EmnkZPTr0k0f
         X/H4Iu83iIQCTJu+XHRcLQRFBZYilvWYUVH4r3SyM6vDhWHBCa/ghosjwXV2QRBdR3xe
         e6WJvPxCttcP6W5Y8YlTmGirykHOf0DgxeiVpeRL9Onr26o1/nGa0td4erQ1ct7jpoGt
         fI/w==
X-Gm-Message-State: AC+VfDw1fDsI2Vy1vvm5bQX0eCu39jx58FsszFxpZo3jGeCoAAK7jrTD
        PM2/NsGgr9VJkNDtZksUapS5WqTssnY=
X-Google-Smtp-Source: ACHHUZ4NiWerXtmW1WCX/VBbf/ZIqKXsi9/r58FnuQQdijb54wfemEl/qT0bxLjpUqtmS9q6t23IpA==
X-Received: by 2002:a05:6214:627:b0:621:441e:4151 with SMTP id a7-20020a056214062700b00621441e4151mr3689647qvx.43.1683686026024;
        Tue, 09 May 2023 19:33:46 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.200.49])
        by smtp.gmail.com with ESMTPSA id p14-20020a0ccb8e000000b0062120b054ebsm1228605qvk.19.2023.05.09.19.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 19:33:45 -0700 (PDT)
Message-ID: <645b0289.0c0a0220.692c8.8875@mx.google.com>
Date:   Tue, 09 May 2023 19:33:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6606492478721866468=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] monitor/intel: Fix not skipping unknown TLV types
In-Reply-To: <20230509235507.3424068-1-luiz.dentz@gmail.com>
References: <20230509235507.3424068-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6606492478721866468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=746268

---Test result---

Test Summary:
CheckPatch                    PASS      1.24 seconds
GitLint                       PASS      0.75 seconds
BuildEll                      PASS      33.36 seconds
BluezMake                     PASS      1118.49 seconds
MakeCheck                     PASS      13.77 seconds
MakeDistcheck                 PASS      188.73 seconds
CheckValgrind                 PASS      304.34 seconds
CheckSmatch                   PASS      415.68 seconds
bluezmakeextell               PASS      127.00 seconds
IncrementalBuild              PASS      1932.54 seconds
ScanBuild                     PASS      1303.51 seconds



---
Regards,
Linux Bluetooth


--===============6606492478721866468==--
