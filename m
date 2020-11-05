Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BC6C00A89
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 06:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3524620719
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 06:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3deJ1tC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgKEGr2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 01:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKEGr1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 01:47:27 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD75C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 22:47:27 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id j12so741055iow.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 22:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ex4z/0mGI6cWxcPVToOAqWzFPNs5sEGHbN4DTEu58s4=;
        b=D3deJ1tC8uWWS2S2AIJ/R9O2yENnzgKgVPsdvvJx2csoCx4TXjeOob17KVb/V3KSRY
         oeXaLsWvwZkwZ78b06F24lFZrKHDYcbbn7amWmuORCceLB7w9zFo8ixZqKmQV8KB5cc3
         YUNXtegOmFhGiJF/8muuPv7zEGLGfSmQU/JzwVaj866CgyxW9PYu3hkScAUUK2B989du
         n4gGspSb/Q9V+sbI9DgRKcmDXvNTmLS2RBiNAU2pIZ/nrotMhQY7HFPdd1QLkleV91GC
         L1bww4XX2uG2Dp6y/DQ5z/EbB+8zcYRU1AsA9lQbduPslThE3u6t+AJ+2P9KJr90VTjy
         41YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ex4z/0mGI6cWxcPVToOAqWzFPNs5sEGHbN4DTEu58s4=;
        b=IzUrpbVVcY+GL4uht1+BK8EZlyFixR2DnP+toqhayoof2Qa1HVnx7MAgufnsXkRPqC
         knDmwgRbMHrVWCr8/jxSAj16x5DvtD1voqcZxkOaXuo1PQPyl6YtQQdH3lAqPfhmQZ/6
         02dDpfQfkWS00nz5g8QIhKyr/tq/WxcI5T3RM5CAp2Rejd32Nv1xgXOIS92VxDeAPgxy
         +Gm7WDGdiGeo8yZs+P0yuVlbOITflpbbkDicrLI8Csp18VcTxyVd8Ict6qUVwZtYwqy5
         0K9K456d90ReexeSdBIqXkhilpRE4ulhcg/CGjKpJ8oq1W5uekjGqZIo3WFhBYp/01xB
         aglw==
X-Gm-Message-State: AOAM531lbH4I5cnMCDtmG+OsDLxQkv8bA/tx15kju1RvHU/DhEmbgW+k
        xmX6G8TzgOhabNrzT38l3MEWczFrtRj2ew==
X-Google-Smtp-Source: ABdhPJyriwwXVIlHEHMOzjpVKWGi1XRaO6xZujDMOpbD+j/0IRg2r6Sz9nX+McRJHlJwz20+0E/Vug==
X-Received: by 2002:a6b:f610:: with SMTP id n16mr798504ioh.103.1604558846456;
        Wed, 04 Nov 2020 22:47:26 -0800 (PST)
Received: from [172.17.0.2] ([52.247.106.72])
        by smtp.gmail.com with ESMTPSA id i201sm488016ild.12.2020.11.04.22.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 22:47:26 -0800 (PST)
Message-ID: <5fa39ffe.1c69fb81.1172a.1977@mx.google.com>
Date:   Wed, 04 Nov 2020 22:47:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1101070939287485851=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v2,1/3] policy: add checks before connecting
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201105142838.Bluez.v2.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
References: <20201105142838.Bluez.v2.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1101070939287485851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=377909

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


--===============1101070939287485851==--
