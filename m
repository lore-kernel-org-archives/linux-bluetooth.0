Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF10C4167B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Dec 2022 01:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiLZBwr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Dec 2022 20:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLZBwp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Dec 2022 20:52:45 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E27425F9
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Dec 2022 17:52:45 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id d123so5186486iof.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Dec 2022 17:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/aXWyHEp6Bbro8NCpn6TDgPeugLlSrd6MdZshudUgTY=;
        b=gk/dg4ucYs9u1F4bJz+QD0wtpgjbL/UoKpiY7UxI38MDxFeN4JajBCqvwDr15bZNP4
         HD/mj8Hqa5bypwSUY0pbBeK6JyJmLQxNTkEBjG2rvOoiVANFHv7KjFdGMUQzGhDfIcAa
         1Uk04p0X7pU5YqeDO6eqMhDyRiJBaJEXsQHsTCPMMnqAW+ElE21duaND2w3HUwtxvJsF
         wot0LRC5G+ZMj8cbrYhVuiH4y7JPw5laES1w758J9XUeBf9sNdzyAY0xyfqrSWqAQJvX
         ZZ8bcsRs6pBNA3TcNWok8Qj5e6fppaNdKKF/SVBGbjSreapbHLnQzkC0jbSjHY5lhwom
         zUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aXWyHEp6Bbro8NCpn6TDgPeugLlSrd6MdZshudUgTY=;
        b=P83P3bPEGdOBSqd9jbueGtX2OfijLvxu44jZSd11Ksw+aUV4CPlDJQDf8j0VpJTOVG
         ckzpMLkYB7cBSma0IRnk5Zdnk3+u48tl6CrJzR1jQ3RiswhiA8pouaM0v4LYx3dIT3qF
         QII1F3NlnSmiZFeyZkEch4wjuHowYIpHiKh5Ugpuu4cvGVjdxU35OmNYcb36peE9VI23
         UQ+wArI84v7q38fLYX9ekoKE2NOziLljmxJtHD0RTln5SGCZYCDhUq9Y2BH5waTkDC2u
         oggj8WZXiH2CrwkFah1qI/P6NIlbq4NScdXcgekATCb/CQ1wBXwQR96hxLjeq5Vunzsx
         VbiQ==
X-Gm-Message-State: AFqh2kpY8unBaFocM7xRN7zvC7VHS5ycxPs1HAkJglKk/bNl4P/Tn0ol
        qLyBMQ7tlmmD8CI2VsDp4PWgU3XjelQ=
X-Google-Smtp-Source: AMrXdXsYOQBEL5ADgStytlyyKU7ijaDTLH38QnYpKu6nVSANXZ24dfeZWbZXGEQvZkWMUNicLUEJtA==
X-Received: by 2002:a6b:f002:0:b0:6e9:b3eb:d855 with SMTP id w2-20020a6bf002000000b006e9b3ebd855mr12943429ioc.17.1672019564363;
        Sun, 25 Dec 2022 17:52:44 -0800 (PST)
Received: from [172.17.0.2] ([40.122.244.97])
        by smtp.gmail.com with ESMTPSA id e21-20020a6bf115000000b006d8b7bcaa6esm3596610iog.4.2022.12.25.17.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 17:52:43 -0800 (PST)
Message-ID: <63a8fe6b.6b0a0220.8a74f.43f2@mx.google.com>
Date:   Sun, 25 Dec 2022 17:52:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5529880187885334073=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [DNM,BlueZ] doc: test patch - DO NOT MERGE
In-Reply-To: <20221226004804.107211-1-hj.tedd.an@gmail.com>
References: <20221226004804.107211-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5529880187885334073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=706939

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      26.72 seconds
BluezMake                     PASS      738.80 seconds
MakeCheck                     PASS      10.72 seconds
MakeDistcheck                 PASS      146.49 seconds
CheckValgrind                 PASS      237.62 seconds
bluezmakeextell               PASS      93.30 seconds
IncrementalBuild              PASS      598.96 seconds
ScanBuild                     PASS      941.74 seconds



---
Regards,
Linux Bluetooth


--===============5529880187885334073==--
