Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8D8C4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 02:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A2A1230FC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 02:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgLPCGp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 21:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPCGp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 21:06:45 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43233C061793
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 18:06:05 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id n142so21231905qkn.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 18:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=kIxEcm4e4zEmTorJNbDtRiQWuU4ZO4CNwhTtEv/lijc=;
        b=Cwj7HwgGIKaMv5cbNEPE/XAUoZnpPeIkLD+/4mXNBGJi9Mvk8qyW9CGZ+GFYBVKl5D
         8CY6n/CULZ9qKty7CFo8jqkd3MfYHsOO/X3gu1S68LcuhQK1tlQhuTyLSbcGbn0J/cia
         fWWUQKAJOPzRsZzIxPkGLuTnKP8iBK/9D4aZ7W6W7QWI4fD5HvzkYmjyDzVPHEIsAFPM
         6YV59O7sBmROjHcCPScmE57vOVphhfu43YTD4Sj+E4Tcbvk/xMIk3VRrCMpIpnnS9fGZ
         oRy3kimoA08Zv4eWTQ1UC3Ip8RwmaJINAcs+HW1aG/k271xeDiQmC/GhGwGrg7YQuXRq
         mvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=kIxEcm4e4zEmTorJNbDtRiQWuU4ZO4CNwhTtEv/lijc=;
        b=O0JMvBObQ3ttzNHDGAOe+L+gHnElpCcICpocwdVaz2ORKPj+9VpnCqgbLgQXbPRVnu
         7s0kSH0WgK+rkldTARZ/6AJBFOuR+QluEDt6rBCNVc1nUCf4+fn4LwK6S2vEMFvq16ii
         hIrP+MmShGF62LqPPrOMxN/9A8ZPVnWK6n49VoDg/XSS+372Rb9Y2H7cjWRgLZcscgOo
         /Aj6HfmdTbL6aZBZpWcN6XVWfdpCIAQt9xd46vGsRZN9y9ueMmIMvc5WLvQORFfKOGy8
         Bl16JmyJZ7y/AX7ZQHlDmiisNwK9Gaq7bpzkHa9WVyT0reS4g41Rl20gFU2+euTM7xC0
         Lq9w==
X-Gm-Message-State: AOAM530M3suoCt55j/ky4yQvV49Ykl3b9BaOvjiyt5M7AeO7eGz7N05g
        zaBRy3uTm43QpLhgCLlhw9VQSlJQQ60iJQ==
X-Google-Smtp-Source: ABdhPJzqBXWI9fXbdNsE4/kKSSBnJU5h7ygQaHybr3c8CNwdGXbF93YJgBZGwph1Ic71T5XK0gBNzw==
X-Received: by 2002:a37:27ce:: with SMTP id n197mr24940017qkn.220.1608084364439;
        Tue, 15 Dec 2020 18:06:04 -0800 (PST)
Received: from [172.17.0.2] ([20.62.106.85])
        by smtp.gmail.com with ESMTPSA id z20sm263531qto.40.2020.12.15.18.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 18:06:04 -0800 (PST)
Message-ID: <5fd96b8c.1c69fb81.9bf95.1cc2@mx.google.com>
Date:   Tue, 15 Dec 2020 18:06:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3851377012373446827=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: tools/test-runner: Add user channel tester
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201216010728.989447-1-tedd.an@intel.com>
References: <20201216010728.989447-1-tedd.an@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3851377012373446827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=402607

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============3851377012373446827==--
