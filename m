Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AECFC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Mar 2021 00:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E015A601FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Mar 2021 00:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhCIAAA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Mar 2021 19:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhCHX7y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Mar 2021 18:59:54 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D8FC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Mar 2021 15:59:53 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id l132so11317009qke.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Mar 2021 15:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Wp01VoEHfLmIYVAye4RbEkZ9Kc1JxjcG1dLOdaxQNs8=;
        b=J6Rx9uOVr1lgjG/6JNlp4OjAqiTW3s0o6qS75BTfl/jf5WzHkWFGfBxQ4yzfyQHs4n
         j7OkWBGUeOfZo7O2pNS26teVQzJfiamBBeayKJ+lirl91P5rHvIWEO1EqYn9hsx6MwvI
         UjZ6ZJf3FuSG5ZnHhiKRyxRsAzXI36ycOBWIRObd4yuwRmJs3dZSazEOfBcyEnyJrzDq
         7PJggH2wp4EI8LHOereXf0D2bDN0pI0M14KNBhD+jABbGkgPQFv/poXFniP4O0/AvZOP
         Spnkg8ngQZfrR+Nl9MADzSVDMpdnyLFivwePATNMgKIHNjaMI9h4cigtvQTzDiEMc3rl
         +OIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Wp01VoEHfLmIYVAye4RbEkZ9Kc1JxjcG1dLOdaxQNs8=;
        b=Gg5cSHKMzbUEkFuSQ734XjLn3tlwOki+OiHPph+MTdcRrvwK9BO29gMu35Qu3kg0Cg
         re2/rsEHaFbiyGcrwbdw7EjHbOkblnFkW/yapFnDrOKOW8kEDcqVln03NCJh87P3R2mr
         zV0cXFR2UzjvMvcJybT71WUFECfdsB3TuWoV2ZXUs5h/msOUVlTcnEKW6D4+0XW9+P0r
         K4+XNtbhGwl1ZjE62FfXfToNGdi3Lv7goAknIJWiu09Iy4RJdhvsB8E7uchCPRRrrWiD
         GwfLzJDhPqfUvlkjIkoKZPgZX9i//+XYUAORBUSSsKxrwsNlZvJ4r3aCxPPorbgmSpLS
         VexA==
X-Gm-Message-State: AOAM533Vtjdf+CZglqIr3EOwvrnGAIbCkMkKnfUHTLCafxYAneSdzJP+
        dQYt6aGvCccgnEQNAxlo8rd6Y2GzsNQ=
X-Google-Smtp-Source: ABdhPJzRpbfMSNXsDej7AltIPkzBrN53blAE7FvV+ifuCryP/ExDSSmFY/68iZVR1M+LygHXUzHHrw==
X-Received: by 2002:a37:d2c1:: with SMTP id f184mr15340145qkj.107.1615247992871;
        Mon, 08 Mar 2021 15:59:52 -0800 (PST)
Received: from [172.17.0.2] ([104.46.109.34])
        by smtp.gmail.com with ESMTPSA id x75sm2183367qka.124.2021.03.08.15.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 15:59:52 -0800 (PST)
Message-ID: <6046ba78.1c69fb81.25819.ed92@mx.google.com>
Date:   Mon, 08 Mar 2021 15:59:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2799662420348926376=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] mesh: Validate OTA provision security material
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210308233653.187406-1-brian.gix@intel.com>
References: <20210308233653.187406-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2799662420348926376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=444147

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


--===============2799662420348926376==--
