Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED76C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 01:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97DBC2237B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 01:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+qxeXy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgKUBdO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 20:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKUBdO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 20:33:14 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45F1C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 17:33:13 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id u4so10870802qkk.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 17:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=cHqoKJi8dFklJiQSdeTGXqVXumjzxKcivhsw/pSimjY=;
        b=A+qxeXy5OFNuTLHE5b1Uo6OOVWPuTbyUJG3UHgqe5Nk6jAALLDUdBUvLG3+ipyw+SO
         Xg/U4R3ONj3CNJq8uJO+19nVitvyZxtgFm3a5iTHYOnvWuqplF4RhCCiRLfGlJe40a38
         Yx7mPe9oLv5gJV5vHpeu9GxC8VMKllL8z3WZ657gJGtxjx3FDA0MrQ2TvpanEay8jlX9
         tEwG36VKitH2x/pBAEyppPbqhHDv/8ke9lKy4pTRlpe8xs0P2kwmNrJ510xumjDf/sTK
         JXSSlI9n4YaiRH63XURuussUb3EYDeNq3HwyAfhxqaBBlqcqv3axrxHB5drQgXodsMsH
         Y5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=cHqoKJi8dFklJiQSdeTGXqVXumjzxKcivhsw/pSimjY=;
        b=rjIijtLaLAsU9MAnvUVYtwQhS+jjBmTaotA5UHVBWi3VLgp+ko0QXG8+U6AE6tVyLE
         fOXiPiRmfj7b+c+ZV/UCcKQvvGtfFxAuDO94jujx9gIwW/DNEAPiaNHcIA1W+4GMNhpt
         W1ShGegA/ip19XsudbATmHancK1q/CR65UMvCCSnHqs6B5a3wt824tN2r1FkW8o1ZG3Y
         xB1CfLI5qV7zJeufhQr1Fg4MzKZKLDVq7Npfc5wVpqNYxQDXNnPSTBoIU02Sl24wjbgR
         y4nZYcL3ykjOpzm/ddtoBlQPX8fwVqZkTxP4Zimr+lL91+7HH5QQcwvwjCfnCOaeM/Sn
         /hdQ==
X-Gm-Message-State: AOAM5307A1XgUJ/l0zZbrI4MGN0VXyQ53zEWe7OF9Mnro2kX4k1h+vnI
        dXg0mJtcyGNtMu+n8owl6cwU+eW+5+1sBA==
X-Google-Smtp-Source: ABdhPJxOiQG4L7Qv7FOQ37tRG1RxMKcp8JXrIuWT7V+nIMSaAw+6bP33yMdVzKdgPwvVXl5hyc8H4Q==
X-Received: by 2002:a05:620a:627:: with SMTP id 7mr19245489qkv.354.1605922392972;
        Fri, 20 Nov 2020 17:33:12 -0800 (PST)
Received: from [172.17.0.2] ([157.56.179.65])
        by smtp.gmail.com with ESMTPSA id z133sm3517951qka.20.2020.11.20.17.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 17:33:12 -0800 (PST)
Message-ID: <5fb86e58.1c69fb81.a4a19.7c5b@mx.google.com>
Date:   Fri, 20 Nov 2020 17:33:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8148955459157812836=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, gubbaven@codeaurora.org
Subject: RE: [v2] Bluetooth: Use NVM files based on SoC ID for WCN3991
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1605790449-7250-1-git-send-email-gubbaven@codeaurora.org>
References: <1605790449-7250-1-git-send-email-gubbaven@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8148955459157812836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=387527

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


--===============8148955459157812836==--
