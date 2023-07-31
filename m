Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459EBC001DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 06:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjGaGEq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 02:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjGaGEp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 02:04:45 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F194010CC
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Jul 2023 23:04:43 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5661eb57452so2350468eaf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Jul 2023 23:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690783483; x=1691388283;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IBsh2Dy+aBERuGxQEuWiw9amtOEP1Kjmby5S5c9gB/4=;
        b=SFW5rLH4isSrkzMy9Oig2VFe5mlvgaoVCKN9wrnS9kjdEnzqsU8paXEo7akRKOc9YB
         TWCI+pmguoOXqRPu8eEwYYbQHKzzMXMRrVRLUePXkdgg/9AlO9Vt141i02FngijM/GLQ
         m0ZgPvAZo1AENN2czIjTrcTA4kl4V7sJHc3bGZPZrray5DRFmKpmMXYwni/HSOhISZbI
         IDjKY1GJHLwk3TI0AcbGNsvOfbZhNZrVn+pUcQ8uJLc58Q28Zg/H9uFUpLkD3Ro2XRuO
         WK3kYUvLPQHy/3nNTvrEI7s9sC8ziuzOI+CamHnhTyvRpiiJWxXpKak4dtlzKof+2Ekb
         EgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690783483; x=1691388283;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBsh2Dy+aBERuGxQEuWiw9amtOEP1Kjmby5S5c9gB/4=;
        b=jRmiyYakK/VIokpB8aLoTuingBvHmZOMcYstY+drY8cxnvtlGVlQ0qx6+go8WbAyal
         HpQmOa09wTf8a5aSvNRhlU6s+W4Kp3OwRMR+zJflR4PshBNlbKTgPWdeimaBC5e6qMwg
         aUNc7JHBnwjZ3Eay4ZBwFAZH+sgvNZ5DBG9TRLzp0Ee/bMldGD1ygasc6b83A1jqbr6o
         rSYRC5Ss/JFUA2D/orcF2ToGtmhR5daWEqE6hd/MR5/6QtxBaTRpccU41VUiQJNuOpF5
         Oy1asjahL9NXRdpTddqZtcQvJ0PXhE+6gCvkLt43usKLQcn/U13HTRiaz0AGZfeVAmzi
         OtZw==
X-Gm-Message-State: ABy/qLZSWDdV+tIB9nbS0iUCNldfiybjx9cvng5HsyLdaUTN50dDQbtA
        E4GJnyaKZ9sTA1EQAWRYVhYT/hOzShA=
X-Google-Smtp-Source: APBJJlFpjUCGpCvpjXeMdT4m8NWrdi7RCzfP6HFMIe24D+3TEHTj2LOKiZV27QwxcVx00AXM7kvJQQ==
X-Received: by 2002:a4a:91cd:0:b0:566:f5bb:7d40 with SMTP id e13-20020a4a91cd000000b00566f5bb7d40mr8099494ooh.6.1690783483039;
        Sun, 30 Jul 2023 23:04:43 -0700 (PDT)
Received: from [172.17.0.2] ([157.55.189.33])
        by smtp.gmail.com with ESMTPSA id o1-20020a9d7641000000b006b9734b9fafsm3799168otl.13.2023.07.30.23.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 23:04:42 -0700 (PDT)
Message-ID: <64c74efa.9d0a0220.bd00b.58ff@mx.google.com>
Date:   Sun, 30 Jul 2023 23:04:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8649274483662058029=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,1/2] adapter: Be able to use ConnectDevice for discovered devices
In-Reply-To: <20230731041229.1429016-1-simon.mikuda@streamunlimited.com>
References: <20230731041229.1429016-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8649274483662058029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=771001

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
GitLint                       PASS      0.57 seconds
BuildEll                      PASS      28.69 seconds
BluezMake                     PASS      1057.60 seconds
MakeCheck                     PASS      11.91 seconds
MakeDistcheck                 PASS      164.87 seconds
CheckValgrind                 PASS      267.45 seconds
CheckSmatch                   PASS      397.75 seconds
bluezmakeextell               PASS      118.45 seconds
IncrementalBuild              PASS      1912.31 seconds
ScanBuild                     PASS      1276.43 seconds



---
Regards,
Linux Bluetooth


--===============8649274483662058029==--
