Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E42C76196
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Apr 2023 20:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDGU35 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Apr 2023 16:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjDGU3y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Apr 2023 16:29:54 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021C27A83
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Apr 2023 13:29:54 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id k14-20020a9d700e000000b0069faa923e7eso22540643otj.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Apr 2023 13:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680899393; x=1683491393;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gQDUh5rjkj0jkg3BR6sc0Ry74U8GGXE7vDPUelgterY=;
        b=JHedV9P+DQaROW6M0Kh84Yj+v6p0mQdGv+RrEfVw26nc6/ELshTCwxFlNPtSFJ317X
         s4mKJRBmqPsgmZqoT8xAwCqUERve2Va/VN5uVkOC4J7zqUxU45dH5o9Lpm/ki80E72hi
         lATqwNXdgw8+yAn3iD/LANcWjrwkR3A0JqJWUHrzpmKXISTeSohdP3n1+JUYBlJg9U98
         OYbT2fsGV3viAw6HH+foXU22evc/11rQ7g+l1Jy6OaSNpUx7FcAagcS27jMn0QQMqule
         gapev1QpEkHK/8wV5Sl2SJVc6D6Ex/8pnVdOKn5lSg+xaMMKHa8nsfokVhxi2l+KjV9r
         QSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680899393; x=1683491393;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQDUh5rjkj0jkg3BR6sc0Ry74U8GGXE7vDPUelgterY=;
        b=AebgzTp+LO+KZis5unmVH6er87tKy4uK/fgxlarHSviRiDxxJIOAKx5LTIJN55Gu1Z
         fZRcMKlLhi3spYQy+D5fJ1FK8hjWV2zBoR9yl3PIGRadkCqntUDGKMB9KG3U+Rvpi3qf
         MGEoIDpWXv/ZHFlcdYMeIc0Gn3IneeCD7R+Dc5h6q3VNADwjs4YBwX4HcGUZIEjawiQt
         25frIbOCtPF+ZvYKoZCuQAkdV/JLjP3f1PjdUsX9ge4e0VcDtB115Ifm+Ylgup09aq3K
         AEq2VHiGsNycVE3gAMdk9mdPyWTAz37TJbJh4hvgJ/ju9EnRujNGVOSn234KzYejHxGn
         TNng==
X-Gm-Message-State: AAQBX9eyPCcAGNzEtA3BPDwc7pZW2642ESDyBQECrYNJFraQhurZ5lu+
        xinwVTqZidMeUH8mQTigHi5dpceZ9h8=
X-Google-Smtp-Source: AKy350Z9TmMYY/USx8gbpXX4gCUKc1CytBkiAPJzKfzhqTje/Y3On/67fIMKACVB72auSz+unBwejQ==
X-Received: by 2002:a05:6830:d05:b0:6a3:df0f:91a with SMTP id bu5-20020a0568300d0500b006a3df0f091amr123561otb.15.1680899393133;
        Fri, 07 Apr 2023 13:29:53 -0700 (PDT)
Received: from [172.17.0.2] ([70.37.167.50])
        by smtp.gmail.com with ESMTPSA id g25-20020a9d6c59000000b0069f95707335sm1944071otq.69.2023.04.07.13.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 13:29:52 -0700 (PDT)
Message-ID: <64307d40.9d0a0220.99898.8b0c@mx.google.com>
Date:   Fri, 07 Apr 2023 13:29:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8814964781347769597=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RESEND,BlueZ] mgmt-tester: Fix Get/Set PHY tests
In-Reply-To: <20230407184440.3291592-1-luiz.dentz@gmail.com>
References: <20230407184440.3291592-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8814964781347769597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=738056

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      35.49 seconds
BluezMake                     PASS      1217.63 seconds
MakeCheck                     PASS      12.86 seconds
MakeDistcheck                 PASS      188.02 seconds
CheckValgrind                 PASS      308.34 seconds
CheckSmatch                   PASS      434.04 seconds
bluezmakeextell               PASS      129.97 seconds
IncrementalBuild              PASS      1005.50 seconds
ScanBuild                     PASS      1356.40 seconds



---
Regards,
Linux Bluetooth


--===============8814964781347769597==--
