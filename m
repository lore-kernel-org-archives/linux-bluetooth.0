Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62AAC2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 19:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61249206FA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 19:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtqeCsly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbgKDTWs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgKDTWr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 14:22:47 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B5FC0613D3
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 11:22:47 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id g125so3106725qke.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 11:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ObmFdftwbllLgQc7E/luMpdWYXso/PiSXnObdJ1tEWo=;
        b=EtqeCslyW0Xop1T2aUQT8gjPL7iiskJBaH8ymff0eLv9IkCrHDLCv2Dm+uZx+BIcko
         eOo6AponoXBGo2vw1/YGOR3XBJZSwsbcBqUR6UM3vFQinxyLlhtKX2A3PZ1Q03ayM9br
         kjCszWpFHPy54YC5k4MAQx5SfW+RyAxsJ0qi8CPOq9Q2HEvQ08C6HAQaBImQMQ7h8oFx
         oxLukyAfjNPvAVcYLcKwIMxoLNZgCVULiQ309FxDoNxFPdlg/uYDsoqldcaWfH8pWm7V
         IbOwSy1e71yoTxk3kiz/dUpwQIHVvviC+DOFK6hd1bTu7kS3TtsuSt7EGhOFcls854KL
         wohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ObmFdftwbllLgQc7E/luMpdWYXso/PiSXnObdJ1tEWo=;
        b=h6STwSQIkRaxxkLkbUY8e19ji2FSvCo35IWgXYdkGCG4ktyDJnOjZZbLyCPdvw/uPf
         +X7HaGldOzKCEJyan6nUul5uL+jq8EK0GGIP+vW0oeNKm/QjS3Ux3OoWytv2KjRma6St
         +Lh9M/b/mUtdiI25+HHaXHZN1ugpUXPJ+5bIbKWDn2mmfdEFacWIvYTPHR382ugso6yM
         ci/oAVdyCqbASvdjMVbW+YpdeVzQUuom0BQxW35inrAkwcFQso4QxWI0vYXKcLVSnu9s
         Ni4YRMLR3srSjI50jbUFZMas4+P6pPaA2+4vVOUhGueWb2abV4GQK2ppHyo9T/AvImqy
         6qgA==
X-Gm-Message-State: AOAM530jEi3HmvwtCU/gH0O2rd5z76mBX4eKegiAE7EAYxllY0DQ09Ag
        oO0MzpujYS9d5majWjANzgTOWYXx/yrVNw==
X-Google-Smtp-Source: ABdhPJw84TLkoqXela9uuQHDLDoEhO2ukeextkbZvGmx9whvYvwmwJEWb+6j4qBUqrLsg7Te1HFoCA==
X-Received: by 2002:ae9:dc45:: with SMTP id q66mr26340074qkf.407.1604517766882;
        Wed, 04 Nov 2020 11:22:46 -0800 (PST)
Received: from [172.17.0.2] ([40.84.62.8])
        by smtp.gmail.com with ESMTPSA id m2sm896407qtu.62.2020.11.04.11.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:22:46 -0800 (PST)
Message-ID: <5fa2ff86.1c69fb81.a03e0.59c4@mx.google.com>
Date:   Wed, 04 Nov 2020 11:22:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1539921034133036372=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] doc: Add tester.config
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201103231947.2053274-1-luiz.dentz@gmail.com>
References: <20201103231947.2053274-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1539921034133036372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=376931

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


--===============1539921034133036372==--
