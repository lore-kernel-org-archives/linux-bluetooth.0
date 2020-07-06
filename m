Return-Path: <SRS0=7cy9=AR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C885C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 20:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFAAB20775
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 20:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebETRFGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgGFUVy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFUVy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jul 2020 16:21:54 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80B7C061755
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2020 13:21:53 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g13so30035895qtv.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2020 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=u9ytgxLq6uH2Yn515WsUdQOmhh5WiqorZ9YxqrEuwYg=;
        b=ebETRFGOXZe09mm0LHh09/laYZYmDLu8u5oSh/tS1xRJuR1jAgvXVdyTuUbd1Cj4fW
         /iZmmNrIHS1wVhnyZREfaQGkRAolKQI0JLpQT5SqZX2s2X8XTABVxyQ7hj2H3aVd7hRO
         7ooFk+BJQDTJn7LaHIHUNPU+Hx9TiVS2mLvZrXHCEJOW/BjyzMf1ht/pwdpSAElyFXO1
         chn6BbIeWN1EoGOFXsGOjE7IH/4dgGki4rFPyMleL10bwj/zUjzWzhk2oOwbWNc5AR46
         LRGM/yhvaXZs30i/UV5okAdP1vkm9QhS/dAkfbj/C/Hl9d2MrhG7DaZv9ihXErswbtrv
         fUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=u9ytgxLq6uH2Yn515WsUdQOmhh5WiqorZ9YxqrEuwYg=;
        b=TRE31YUAyZUZlJqkAeHFRESd6EiPTlc3C3FauzES2Ppy/+jLiInLp2IS+X1bVsbpq8
         k9sOnVuPPhUXzFc9XJZQRRh8gABkhJfXS0kc2EkoZsuydnKtamrEHiVj+obm7fHYuEiH
         6N4OTlAa/Vf1/hD03PkXq6mexsFscK2DuI/0YY0mowCFKDISyKIEakGpvL9tF9iFpCNB
         scT4+oB8lxoPReGllOf03zNeo1ROZTGlAPRVhnVENy6MLG7G9z8PnMWDbAesX/pg7ClZ
         CvMiv/YWO0Yr+ydLFia3Q0oVyNZcxNTVQ9ORZHvA9wNzDwb83B5IXkD8R0nmFqzZhEg8
         21Bg==
X-Gm-Message-State: AOAM533vbhpFjwhAK8sEulAHZXGbbOQ4Ght8Nl+NtAdnpMUsAaDwONjr
        xZpsWuZidEs2JOoNtLZq9L6RqYbl/qw=
X-Google-Smtp-Source: ABdhPJz8jv/kSeevLB9WYam0U+Y3A6OMEESit5hq49it7qU1xjxbIIkfe1rXO95bf4ohWz/pPK5tUA==
X-Received: by 2002:ac8:4649:: with SMTP id f9mr3086484qto.313.1594066912337;
        Mon, 06 Jul 2020 13:21:52 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.37.163])
        by smtp.gmail.com with ESMTPSA id q29sm20446067qtc.10.2020.07.06.13.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:21:51 -0700 (PDT)
Message-ID: <5f0387df.1c69fb81.521c.e331@mx.google.com>
Date:   Mon, 06 Jul 2020 13:21:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6048096995076221070=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] mesh: Add Composition page storage to node.json
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200706194915.189849-1-brian.gix@intel.com>
References: <20200706194915.189849-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6048096995076221070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
3: B6 Body message is missing



---
Regards,
Linux Bluetooth

--===============6048096995076221070==--
