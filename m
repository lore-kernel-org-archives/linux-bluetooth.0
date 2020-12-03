Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEED8C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 21:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A19E207B0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 21:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgLCVIE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 16:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLCVID (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 16:08:03 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEC9C061A4F
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Dec 2020 13:07:17 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id es6so1721276qvb.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Dec 2020 13:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=f8nh0/ZPp/YY1b8aaidMe4jGi04j6Kbg/losOiSzACY=;
        b=hNrT4RdQcd5LLR0NvlYhG3oOS1L0SI/+eUFFzRjO/GL7ZLPyz8wf0dGK3B6leT+52b
         mp2bejWnziXii4uvk4A2xrE6l0ubgWlWhcAvpxaAE48WI9qeaSorp874mme9RoxcFUKa
         88o5yUcLZ+zvHAgR9kC8tDJICqYXUymdHnvGdAyNofBjK1rEsIWzxP5cwhjzTf4ZkcpC
         i64MwR5lFsutyBp/TOPVrRzHWNjt8hrkse20TCpf4CEtxxc8i5hk6piH0tWX3nQwiIAE
         XXtL5acWG9jJr6JsOwhQisR23Ug6gQxqDgB7JCog42Iukb7fnX2VaEyNooWUdylhBGy3
         3uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=f8nh0/ZPp/YY1b8aaidMe4jGi04j6Kbg/losOiSzACY=;
        b=G4al1fnY8GT+BlNy3h5wgQdcuUhfyP82UsNAOZ8FBnTQygr2b9UDZ0nFB0uHsTPrxq
         FXxKDS2GUU/0gqHA9afDrx9U4rwpfTGX74k1CBUmfViYMQ94ujkSyYdqYw3chzfd/cvw
         bhqJh1wKCkrt++8ltLtfrZe96H0Dni/V0JBsv9mBWLH4Bl8QCcYyB2gFH5ypgiPmA8zq
         xJAibcmNi1mn7EhJFC/nqM68q9Ovau0W/AJLmrkxYExkR2nOmEP+81wJthV0Fy2jAdZJ
         pSQKgu0YFDan+ysBHM0k2RW5thrtIq5Zg2qmd2rveOygeZ8O5cPE8hycQyHwSGOT5bCd
         QG4Q==
X-Gm-Message-State: AOAM531FAT937Hy3CvxB863/gntcs6cvivH4zG1VN2hTUkICPVRK/DXe
        CHhOkBql7PYt3JBuCkrH0WnOGKwSBuU=
X-Google-Smtp-Source: ABdhPJxy/vXMX+XBD6Z+9AyrknMfgq5uYJ3ccbopXRZt5bFhtwUl6p5HX7HfSoHlm53WeJ7daSipgA==
X-Received: by 2002:ad4:5850:: with SMTP id de16mr1205533qvb.46.1607029636661;
        Thu, 03 Dec 2020 13:07:16 -0800 (PST)
Received: from [172.17.0.2] ([52.254.64.148])
        by smtp.gmail.com with ESMTPSA id x22sm2432131qts.53.2020.12.03.13.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:07:16 -0800 (PST)
Message-ID: <5fc95384.1c69fb81.8a3ca.8d2c@mx.google.com>
Date:   Thu, 03 Dec 2020 13:07:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2912055730101084023=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, danielwinkler@google.com
Subject: RE: Bluetooth: Add new MGMT interface for advertising add
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201203121154.v7.1.I5f4fa6a76fe81f977f78f06b7e68ff1c76c6bddf@changeid>
References: <20201203121154.v7.1.I5f4fa6a76fe81f977f78f06b7e68ff1c76c6bddf@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2912055730101084023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=395707

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============2912055730101084023==--
