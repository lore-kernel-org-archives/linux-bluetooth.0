Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADC0C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbiKRFNu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbiKRFNm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:13:42 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC1051323
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:13:38 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id c7so3053581iof.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1WmisIUz0otaMBmQ/u92zGuONVTZDyFtn6pk4zMZ/Uw=;
        b=CQrQY2UiJG0n4B0Uuh5XgIWNPFxvE29peNEnqkNcOYHKqG+ptBzf/LK7B+KQxJxM/D
         Q1x4476Z/IfSwBc6+7lMg5cWBbMyEm18eoDgsctIyZDGGq+3KQluOZvB88PSQO/1ZufN
         YtkHOXLY+ubx587aZFsh1Ycna8wR63+Q3/E2C7Plq6nA/Rj/niNyKl2GzuMf/u2ma9Sv
         iPF+xaQtUxCH71JW6ZQAZ5fNmQfQDvHTImhI5+n1Ryf+oqn9T15adZuLKNXlwp+nFX6M
         TDnAi0tX1NCRlo15//lEQMdnYYI+7jtoUWQ3sqGMigAokLzJPTrRQx+d3fqPhBOLin4u
         jRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WmisIUz0otaMBmQ/u92zGuONVTZDyFtn6pk4zMZ/Uw=;
        b=kIJqolpVCrC9UPc15iPWaMw6eVbyPxKVG20hpmQg/gAc6k2Xue6zp11McVTRqW+IbZ
         2jznbTYwyjQAgk2xe1eTY6WjcIOlU0Ip/QGiyvtIk8UShR9oIiLFkR7IkTfiic9hou3/
         1uWorM1C2TRBijbUegGjfLz7tmmdMPBDHMJbN+fTJArNlKdKFOdY8HtdzgxRbaFpo5qw
         MqCnTaFSdjFZtyA81UxkPrzFGk7tMsJp4twMOII2XhQtyAL1rQj9EJQNV4Tm7+Rlmy57
         ZtAkoHzxDmFAkyEgXu8oXHS1he6RmPxgLOH453NcX0SZ125vHJVSAfv/EKdtG8MgNVqC
         FpvQ==
X-Gm-Message-State: ANoB5pmflHzeIiBDyH/vm1OvJUDH7BQWIcWuUSncgFDOZgTNoPsxIP+w
        YGNcU8NDUcBzv0nxE90/XrDIwDUfarA=
X-Google-Smtp-Source: AA0mqf7YcwlP+Zz1VVPbCgfT4phsiprnJhv4wA9PLNp2ub1Y9YVm4iXgE/1EJ2FSjTuGg2bbBo61Gw==
X-Received: by 2002:a6b:dc02:0:b0:6a3:2119:e929 with SMTP id s2-20020a6bdc02000000b006a32119e929mr2874435ioc.39.1668748417957;
        Thu, 17 Nov 2022 21:13:37 -0800 (PST)
Received: from [172.17.0.2] ([52.165.62.57])
        by smtp.gmail.com with ESMTPSA id b2-20020a92c142000000b0030005ae9241sm953620ilh.43.2022.11.17.21.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:13:37 -0800 (PST)
Message-ID: <63771481.920a0220.c7e37.2205@mx.google.com>
Date:   Thu, 17 Nov 2022 21:13:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3721765543916415791=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] main.conf: Add comment about LA Audio BAP UUIDs
In-Reply-To: <20221102101224.1463549-1-hadess@hadess.net>
References: <20221102101224.1463549-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3721765543916415791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691153

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      27.21 seconds
BluezMake                     PASS      879.98 seconds
MakeCheck                     PASS      12.04 seconds
MakeDistcheck                 PASS      147.11 seconds
CheckValgrind                 PASS      243.62 seconds
bluezmakeextell               PASS      94.96 seconds
IncrementalBuild              PASS      715.70 seconds
ScanBuild                     PASS      1021.44 seconds



---
Regards,
Linux Bluetooth


--===============3721765543916415791==--
