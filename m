Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A3AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 16:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF4764FF5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 16:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhCKQLy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Mar 2021 11:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbhCKQLX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Mar 2021 11:11:23 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546D9C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Mar 2021 08:11:23 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id g185so21139249qkf.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Mar 2021 08:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=VnAn1RMJ+YG37oo3otU5eNCPIvx3WbxosWPDG24JsS4=;
        b=His5Oes64qmf42oLCH/bxTY6ca6YrwJIynXlDMupY+JvKSzZU4DinwImSf9ohLvJ0p
         Kzt2nx8nE6u7pW0ZqiGT/21QmHLR1SccN9ALlpMekTR65W9Fy6BMBZ5X5FRE1WNWSAj3
         NiQNFzYc+hoNwo8z+TfYiXz36SDchvccfQm2gL5Ir+UfR5T8t6WURHYniTxRo253Yc9h
         8U6RlMegKgA53VdeNa2X672if1yP7Xk+dcVhg0bhoDvN8ldbOl3mq+r7wk4lYF6Gkqgc
         mCJqX8tLd56Ac2sRUvRdbUvZ+IWzOUn1prKrprLWBiPl1PTAstBlr0s4YJS2jj7DPoaI
         E3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=VnAn1RMJ+YG37oo3otU5eNCPIvx3WbxosWPDG24JsS4=;
        b=XjmYbLk4GrGR5xt4e0YVAET9nnJPfdmDFJUEZ6M2q4RA/WwiM4CYzKQOWcmOZALmJh
         ldFLS2+8BSTn3lKjzAlpTEvAsy9IlFJKmC7F7lQbqiFTMy/QNayWp/nIJv2t3iPULYTa
         jpA1noWUphOeqnEtEVRJ9XFmUEWjoYew5Q1dD+T/bGVoGFp7jqiZze9yKxGf9BIZ3e8o
         eTHFQ9C+9D1OP1/CAyiuin6Zkfqb0dPuvbZTwk/SoQvgkE4EzIZdwZzBUj4yz3v1vRRp
         jZfk5eFRVni4hf/WTDQ2PH/aov308aCQwJa6TjlkEIQLOQugn1sdT9YJ30RaucioE+oH
         7IvQ==
X-Gm-Message-State: AOAM531h5Xup80+v8WyORGZ+dROkWs6LeF/nT3KNDIXdXf4At1tC7DmC
        IQAm/8JmtMieqjSdrHfNkseLQHA/pmmsfA==
X-Google-Smtp-Source: ABdhPJyxRdUFRPZnBPWGUjCYAmkPvUMFguFZImmWeZ3arQ3NdOP97IqRdvmhK37dHQzJMgacVEviAA==
X-Received: by 2002:a05:620a:22ea:: with SMTP id p10mr8282915qki.27.1615479082059;
        Thu, 11 Mar 2021 08:11:22 -0800 (PST)
Received: from [172.17.0.2] ([40.75.101.178])
        by smtp.gmail.com with ESMTPSA id 84sm2325812qkg.8.2021.03.11.08.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 08:11:21 -0800 (PST)
Message-ID: <604a4129.1c69fb81.2323b.ecf7@mx.google.com>
Date:   Thu, 11 Mar 2021 08:11:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8997438753040799915=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] avdtp: Fix removing all remote SEPs when loading from cache
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210311154036.1008199-1-luiz.dentz@gmail.com>
References: <20210311154036.1008199-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8997438753040799915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=446379

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


--===============8997438753040799915==--
