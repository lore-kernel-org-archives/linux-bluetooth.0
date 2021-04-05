Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC547C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 15:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC376127A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 15:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbhDEPmJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Apr 2021 11:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237254AbhDEPmI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Apr 2021 11:42:08 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7721DC061756
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Apr 2021 08:42:02 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id v70so11866619qkb.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Apr 2021 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=C4sm064RYnbtIJJdcMxxGAchH0WWQEXqtOFSDFA3vVA=;
        b=gdyai6GqnHCFemLNwOoJh+BEzbNO4prbDarlm4NvfTcMajyiJtVBLm7DhsJp9X4OvB
         dkpmGqBnvsrlrmxApF0B5ry8eaWAPsJ5Q3BrTgQit2E7wAJUbLEb+gSgsLysctNRetV+
         GT4XId2LOD3xXcY+LNEYHPdJ8c03zonKYaJHzIXDW5bfs/yW5EBcUq9lAbePF4KF0J7Q
         GjumyzSF2Zs03oAGNlcrxuhxz/Mg1LDXWkHseRlFia9cJnZwAk/S5aOO+AMas262Ezh9
         zCpnHP00hvhyGvezV+QxVPvaOkktkuyfVPGI6F3IJOPJRU8b1rsiSF7B4WVR4IvwGhqF
         /sTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=C4sm064RYnbtIJJdcMxxGAchH0WWQEXqtOFSDFA3vVA=;
        b=X/5iYQFurX5YV0nYSjrrUyU5p9ws88h38DcPMCgKAEBzu4gC/CihUuKeFEkJ/CZ8sg
         hSfUMtkL/OZcxRedMBGRSXe8xcownELAOoQqm6Hf7mTUcfs+jHvrp9B31UwTm3HfUCkY
         +xfFCpUEA0CkSzEt5FWXe11shrvQJxc1TAEFn1h6JPQ2VRO8LpjOO3/PkPOUECCi03ev
         k/X0z28Vk+OX56gkBiTL5CAeSrtM9LFEoINW/0av/pp+bjVTmvYx7uv/5/1BD7eX4d2x
         63XJhqsh+iwilJSW9jgBkJp4PcnUXS38JFa/ngSRmljyDEvH6tSvFANdijIgzD1/qz/F
         XQAQ==
X-Gm-Message-State: AOAM5315VOWT+gQgkzVGuTqDiKauqyw60eZgoKQRRdRfqIitEqc5+MmC
        x75O/hhq+4/FxdBEQ3ecV2c+7KVP24UIYg==
X-Google-Smtp-Source: ABdhPJzabmtStbRjTJySEhVyqzbh6VDEFERArEjkKnpTh3yNYHi81c9iVfN3rWxG/Hkup9eGz5+Muw==
X-Received: by 2002:a05:620a:15d4:: with SMTP id o20mr24861593qkm.81.1617637321517;
        Mon, 05 Apr 2021 08:42:01 -0700 (PDT)
Received: from [172.17.0.2] ([13.82.2.6])
        by smtp.gmail.com with ESMTPSA id 84sm14173130qkg.8.2021.04.05.08.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 08:42:01 -0700 (PDT)
Message-ID: <606b2fc9.1c69fb81.b57e0.e109@mx.google.com>
Date:   Mon, 05 Apr 2021 08:42:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2801673656207479993=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Subject: RE: [Bluez] btmgmt: Add support to enable LL privacy
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210405145802.27317-1-sathish.narasimman@intel.com>
References: <20210405145802.27317-1-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2801673656207479993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=460883

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild: Setup ELL - PASS

##############################
Test: CheckBuild: Setup - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS

##############################
Test: CheckBuild w/external ell - PASS



---
Regards,
Linux Bluetooth


--===============2801673656207479993==--
