Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7496C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 10:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC072225E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 10:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438633AbgLLKIx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Dec 2020 05:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407210AbgLLJyP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Dec 2020 04:54:15 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DBAC0611CE
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Dec 2020 01:17:50 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w6so8668674pfu.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Dec 2020 01:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=+P9XHyBCHZCw+oQGFSDMegF3R1IhzuWpM4+t1YeWvls=;
        b=J/zF0J3JJiGl6os3dQMeVIkZldsOy6izcviwUkoRQ9Kly6rA23JX8x4gLvghEl0ldL
         UIyWVYbAjb44K4PRBaa5sHaSJc+9x0EDMBMCfEVvI/LN4PdDhL32zCIwaqK57E6QWWix
         E/Tl/6RvC8v8KqC9OT1woKCX2wwcvapTwToZLYDpky1BESyynzv84/Jf/3lSE03tr7bq
         40wWZzMeZifM24kjJ7cUqGqIA8jGMl8yHQwS+KhTx8ZG6eq0xo3pDe8nkoD7AZXQ/XKY
         kqUDEwO8TfOkIfPwbfBIqN1FdNqRFzf9J8HrfAOLAtVYmWrYMehIKqahef9dJ4iqx35N
         JncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=+P9XHyBCHZCw+oQGFSDMegF3R1IhzuWpM4+t1YeWvls=;
        b=kwt/M9ZJpjTOKwDEYxU1zF7/nRJMESVWHlRwoUTbPXHbRWCJDKnZbHSNmjHOEqrXyE
         hWn1woq1Qf5NAH0RYf62bW4Pyso1ySUEp+4JFbDk3PCpuddVIb1C4TdZtSU96q/IIKiw
         CQyi3A/MbN7GWIEa2WR7UbPjbYHJx/zoRurEP3P0rlZA+rx5nrtc+iSTlPNNSVvnIpED
         4F1t3flSpHcv+Ch+dbe17RJcpwp52vbu1/IvmiciQBadLj/4RDsSb+tI8YIpnJlNiGHi
         WilTbmWXLEhT6mu/PRUaiCSKknL88q53JburzTTMnTM+lCr6iBEzF3nzb98uvp+iLpyS
         w2NA==
X-Gm-Message-State: AOAM5318WuzAivN8z3dVSjIeWtBJbhpTvT2wtipCaKFzITSbFIfc0ukO
        JAkHcxFrZBW+SeGK4bnQp9MIoIzmE6lL7A==
X-Google-Smtp-Source: ABdhPJw4adiP90aVnpU3w6MNhciwRkfQF2UF1dFJZdQSTUzcWH/J29AcokRpy/DIXLOklshN3mwZsQ==
X-Received: by 2002:a62:d142:0:b029:19e:6b61:7f80 with SMTP id t2-20020a62d1420000b029019e6b617f80mr6693022pfl.9.1607764669550;
        Sat, 12 Dec 2020 01:17:49 -0800 (PST)
Received: from a267d509f080 (d66-183-16-58.bchsia.telus.net. [66.183.16.58])
        by smtp.gmail.com with ESMTPSA id a20sm13544304pgg.89.2020.12.12.01.17.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 01:17:48 -0800 (PST)
Date:   Sat, 12 Dec 2020 09:17:47 +0000
From:   Abe Kohandel <abe.kohandel@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: BlueZ Header Files
Message-ID: <20201212091747.GA16@a267d509f080>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I would like to preface this question by saying that I am very new to both BlueZ and linux application development.

I have a question regarding the differences between the BlueZ header files and bluetooth subsystem header files in the linux kernel. I have been specifically looking at the case of establishing a L2CAP LE connection for the Object Transfer Service and I can see that the linux kernel bluetooth header files have the definitions for L2CAP_LE_CONN_REQ (0x14) and the associated l2cap_le_conn_req structure but the BlueZ header files do not. I have been able to establish my connection by manually introducing these definitions in my application but I would like to compile my application against the BlueZ library and I cannot do that without these definitions. I would be happy to submit a patch to add the definitions but first wanted to understand if there was a reason for their absence.

Thanks,
Abe
