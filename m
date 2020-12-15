Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F985C4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 08:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE8222225
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 08:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgLOI7P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 03:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgLOI7G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 03:59:06 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C732C06179C
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 00:58:26 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id r17so18440873ilo.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 00:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=d/do1r6DlxvTaOiQFQBdMjj7IiJN0oAp8B9vOzzqQCI=;
        b=K/tNvsfTXjaWXdU0EgndLKNLFKHeg0MdieziK9ii5V6ZOy+mBSuivoixq4rMTSIZdC
         5lRm344aAHiaUWix6dBWFgmzR+WpfwPazx6wg5uD9JW2rmJaVfsf71dDXTK2Euvv7J1F
         vtETxhl4lC0dPITEQG3ps2ScDaX4RacUBuwHeZWz5+8F6+y3dh0Aa8K+3lrl5j9EyDlr
         Z+Ha1bZnQ6oANMEIG0AwTQTH/pmb2ZvQQo48224V7ViZiLyRVM77q1E4ca5w/vvh0KXv
         LXmWKS9gkePsjRd8HTT3cKjNb8G4mYzkIN1SGEFSVYhdYBiNLD8F9EU52XDm6Pnpf/1l
         TN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=d/do1r6DlxvTaOiQFQBdMjj7IiJN0oAp8B9vOzzqQCI=;
        b=r7FbpgTjwnfORgg0z/Q9Eus30pME/ydpak0DdDcbPaIZDY7dnJ6LXbDFCaZCsJH1Dw
         bPcZEWV+Ayyc3Q27EfxWlKbg+bOKgp8P0PnfMExYlyJWEuPzg/BYkxTQidyLszlP4dH9
         O1wB2l5r8DUwGvRSmML3GpW50jEKj7aVgAqnYurwUp175T7q2uQtydzTnScA0cXk4Ljz
         cIRL5EjAxTpgG8mkXQQy+mJTa4j9EIouB6rsojycvowPO7JSBnhRfR2i4nm2kG0AZNiE
         Nn6HhqFDF9xx7LVH4DLx+Se2xxlXEzLWALA6FdhwP0otSneVHhbqlJgKxNFbuw9hnEGw
         F+eA==
X-Gm-Message-State: AOAM530FO2OVa986+5OL586nxSKhIBT96MPaGPoTjcdPbxZXvM//EZc8
        p0JtAfACEz5lgYgBj0/OBGmsSdlcQLc=
X-Google-Smtp-Source: ABdhPJx/L4tdoahZIHR8Fp4UlJf2JNEsHZmib6ajhJTZoyW+rzJQ1S7/g1vhYyJQTILipg2Pbh0ALg==
X-Received: by 2002:a92:a308:: with SMTP id a8mr41396074ili.13.1608022705552;
        Tue, 15 Dec 2020 00:58:25 -0800 (PST)
Received: from [172.17.0.2] ([52.177.8.158])
        by smtp.gmail.com with ESMTPSA id h16sm12755075ile.6.2020.12.15.00.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 00:58:25 -0800 (PST)
Message-ID: <5fd87ab1.1c69fb81.49fa7.50bc@mx.google.com>
Date:   Tue, 15 Dec 2020 00:58:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2623140490166980753=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v1,1/2] doc/mgmt-api: Add opcode for adding advertisement monitor with RSSI
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201215163328.Bluez.v1.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
References: <20201215163328.Bluez.v1.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2623140490166980753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=402091

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
lib/mgmt: Adding Add Adv Patterns Monitor RSSI opcode.
1: T3 Title has trailing punctuation (.): "lib/mgmt: Adding Add Adv Patterns Monitor RSSI opcode."


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============2623140490166980753==--
