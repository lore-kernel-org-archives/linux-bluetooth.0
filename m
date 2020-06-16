Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359A0C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 04:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0575C20734
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 04:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piGKLqY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgFPEg5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 00:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgFPEg5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 00:36:57 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0E0C05BD43
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 21:36:57 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c12so17965656qkk.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 21:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=HiYY8aoaFuDmkoDQ4qF6V+6MwLTMZJqYh36zQijBQwU=;
        b=piGKLqY4l7oR3GC4xaRYUvKuMgwvRVbeppz1W7xi7gqhyyNVXVS4O65h9WJlODtyIy
         ZRdtWoh42Vw58ya1EeqnS7wC5U8xrfLpFmhRP8whExp0TOn0G+wUcLKdLWQGHMOV36no
         mF0FlIwBXU/On0BzU6gCKgbu0Zw+x+WuUZwakaKi884egM5p10w9+GkSYQInMPlV49Zi
         5ljqmAKpYjhtZ8SmkBgXeaxyIB6jTNdRVgkPl1eqwjocTktjwU68YqW5dm1+7SAxGlpf
         JFbEcRk1rVLS9gthu1OLkBFNmueBoxbb64y7C3MfXiUtOT/5Aj2Xk1G7QKVcWpmvhL9y
         f9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=HiYY8aoaFuDmkoDQ4qF6V+6MwLTMZJqYh36zQijBQwU=;
        b=XcuGjzsyGgMSrLnxv2yP8HbiO9PFONUs65lv3hs45b7fUHLT/Yj009w8P7pReaw0yB
         +rmSrn8nXgcvMBly2xN3RwJnWjyM867j2MxljW5j5DjQYHvM3BIrFcpmQPwoaBbSHlMd
         +RCnH82w0UQh1Tyi0YC0heBTbuJbSxANR+SZzTrLwYebhQHhmMPoBjfXkzLM3BMlxQb+
         z28hLk6Vnhqtxn1y2AqhcfMB+P7TOJOxeUFkp468y74Q3vLrnna4imwAEHCMdzlrfdQF
         VtljF8HsDgNQPIiGKy/j93s5WrSGCeJEeHKErugA7wf110sgAj2Sqpsuriew72y+j8Gd
         Q9Rg==
X-Gm-Message-State: AOAM5320DxldBIJ1Vmrsng+ohyf2WgkZkrP7PSRE5M1Z/CQ4RrCXDb23
        +O1XVhizvlvpxySKOXr/eBW7zd1BiGU=
X-Google-Smtp-Source: ABdhPJz4cxo87H184lA1IuNDxlTaBbsX2gjejCvTDCrIU+jIa41QIeFTWfgFCnk8D6AqveuYwDN2lA==
X-Received: by 2002:a05:620a:15d3:: with SMTP id o19mr15940949qkm.484.1592282215537;
        Mon, 15 Jun 2020 21:36:55 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.60.55])
        by smtp.gmail.com with ESMTPSA id w10sm14670700qtc.15.2020.06.15.21.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 21:36:55 -0700 (PDT)
Message-ID: <5ee84c67.1c69fb81.1c3d2.3031@mx.google.com>
Date:   Mon, 15 Jun 2020 21:36:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1736408920652291264=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v1] lib: Correct the name of Add Advertisement Patterns Monitor Command opcode
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200615212806.BlueZ.v1.1.I8328c620402620c9aadc149614bb279e42a9db4f@changeid>
References: <20200615212806.BlueZ.v1.1.I8328c620402620c9aadc149614bb279e42a9db4f@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1736408920652291264==
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
1: T1 Title exceeds max length (74>72): "lib: Correct the name of Add Advertisement Patterns Monitor Command opcode"



---
Regards,
Linux Bluetooth

--===============1736408920652291264==--
