Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3914BC54EED
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Jan 2023 22:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjA2WMr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Jan 2023 17:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjA2WMq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Jan 2023 17:12:46 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715C31C33D
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Jan 2023 14:12:45 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e6so1578021plg.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Jan 2023 14:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DDjKxSpfVz6Wg1n8ul67C+etQx+ZGNvgBuw1HehC65E=;
        b=i6jt48w35PmHamynGHsz1cn47uileyi/PYXVkvP9P2iWaZ5H3oTNZBt2/NOnjWaIG1
         wxNaBKP5ZhRlVuE7Ru2IKzC2C07H0cy4g6x+50K0MbMKU8zhOIYJyCNw1JkpKNPh4hfO
         sMCcOW1Z/iVE4HYgMiJ0QnwmyO7co1L4AGpn/2V2B2y4G6qZAMs7NmyRB+WWMBXmW64I
         1CTThBs6LTIDoRCca2nW4/j1Z7Q9ssauCdRNiDZP1ZrRE5bD7Xnd42opQdnbvgVxy2FR
         HEiNGs8aHItYlF1atZBOE9V+elMuwpq7voKUqo8bWl9ynRplEwuSr91zUHliWsASK4tZ
         Prkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDjKxSpfVz6Wg1n8ul67C+etQx+ZGNvgBuw1HehC65E=;
        b=eFoGlsmpXi6lkgBwul4L9SQe5wC/3ZvTulDyRxAp0HubTu1KDBLiNAgv6IKISnjQgT
         g6l4ejNm7bX6kdR3xOoLmihxXGbZ0U5IFTPsgEwqoMRazA+0oXA9qWherRZOBr8qKr4Q
         lAzGEG/rW34J5vnCNkzX0xQZt4sDwys3nlI/xI68Il8bzNkrLbNG4D9X2bcV/winufk+
         M9PFcec5AubHidGkl8dyHAB7RkKXgMlFamCjdXJIVLq91LjzzMSWVLbaniVzPham0lQe
         bNpfRYWuFediC0v47GldOgAk80ZpKLX2E9VM1xlnVjjtW7JsGwKYjj5FvAKFzE6Hfeeq
         1/fQ==
X-Gm-Message-State: AFqh2kplGD9hg9hzqQ1RbcbxnhcBuwbZXLVoq21BkUzAJqLYqUahvaAh
        wI6fW32EG5JrRysoQr9oXmnIhabf5mU=
X-Google-Smtp-Source: AMrXdXuDr2nQRxetITGaAU32kDXyvwsM+Hg8NUf5A3O/pYlbwwwjduAP2H+sC+MwcuWGngyjuKMk+g==
X-Received: by 2002:a17:902:b496:b0:193:11df:670 with SMTP id y22-20020a170902b49600b0019311df0670mr44912267plr.20.1675030364720;
        Sun, 29 Jan 2023 14:12:44 -0800 (PST)
Received: from [172.17.0.2] ([4.227.0.129])
        by smtp.gmail.com with ESMTPSA id g5-20020a1709026b4500b0019479636f84sm6339924plt.11.2023.01.29.14.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 14:12:44 -0800 (PST)
Message-ID: <63d6ef5c.170a0220.3515b.9c2a@mx.google.com>
Date:   Sun, 29 Jan 2023 14:12:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7931517096526200475=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, steev@kali.org
Subject: RE: Attempt at adding WCN6855 BT support
In-Reply-To: <20230129215136.5557-2-steev@kali.org>
References: <20230129215136.5557-2-steev@kali.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7931517096526200475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/sc8280xp.dtsi:1244
error: arch/arm64/boot/dts/qcom/sc8280xp.dtsi: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7931517096526200475==--
