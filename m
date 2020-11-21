Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A28C56202
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 01:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61ABE2237B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 01:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCUI91me"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgKUBcK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 20:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKUBcJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 20:32:09 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF425C061A04
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 17:32:07 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id n132so10933510qke.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 17:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=DncRpalLmfQ/uB9cu0SovFuFObJcu8/yEbCOigbodos=;
        b=lCUI91meTmx8AN8ZBowXTOff6Dh2ROcbkfczJhhDRp5sLo7o7c+4/dHRhasVio10Wz
         RiKEPXadBVwYawjIKzVyVoB8whJxOdw3Ndhv203+bXIhymI7lzNjIiwcp1YX8Mc/Lwl1
         WVCQeMPTV9EVJLMyHn9rQ9O86jqD5IiuGTxPsEsJVdi3MXIETguAzzIRwikp3ijb/YsH
         veB3FKOmQ/cwjnJFRsKCA1XyG10hTHXAhp5o9DRsW4FBoORwoPYrOSwAEN99KWGMtrPM
         rN1NJxzi2idFHW5yKbBHz07rERdnpx3Odqq/8YkIi6W6Jw9QdT0NdxUfhyr+tuP7EWZv
         Pefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=DncRpalLmfQ/uB9cu0SovFuFObJcu8/yEbCOigbodos=;
        b=Tr4LFksM7gTT9kKqi1iBeGskNkk3q4Re9j+qBaqWb44iQTd86yqkj4Mxvdo2BPVwRp
         Rb+OjFjhqautmbRPtyK8PF9ZsJBKmRoVjekc0JhUcE1meoSTkjxiBpsMqbvgVcZoOwlL
         5JKPVzNSZ1Nf/RBMHGYT/qyakNcVQ2WvcAbml0Q1VpNKgGSO7NFVdBsBFWaj1G2gZPIZ
         fnzfui50dqtjjdADf/EHMBnXMSkX7Y2ETZZRKdEsZ9vKRawFN7AZsJz4s4fknECWD650
         F1Me5h1+OoTmwEi/AlFQGxKa6YeI7itGU29kc6lrNl+8YDGOTbGDFRhiqap8entFhToh
         UDjA==
X-Gm-Message-State: AOAM5303A6fUsmaCy+LxTqUjOYB35+W0ohuXL6fwkDJdkQye6JTu9RUP
        H+kHTpWZq89RRm6snEh1Zt86I+8gQ7Lu4A==
X-Google-Smtp-Source: ABdhPJx0N03rQkBwtrsdW5acOOBNWIB/LoezgerMPFW2y4xTVnBh67i3Aj3oJoyL5UU6/JTImU7uGA==
X-Received: by 2002:ae9:dc81:: with SMTP id q123mr20007867qkf.426.1605922326988;
        Fri, 20 Nov 2020 17:32:06 -0800 (PST)
Received: from [172.17.0.2] ([104.209.136.33])
        by smtp.gmail.com with ESMTPSA id j17sm3124620qtn.2.2020.11.20.17.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 17:32:06 -0800 (PST)
Message-ID: <5fb86e16.1c69fb81.ffd26.4f12@mx.google.com>
Date:   Fri, 20 Nov 2020 17:32:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0158295877519543502=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, cadel@cadelwatson.com
Subject: RE: Bluetooth: btusb: Support 0bda:c123 Realtek 8822CE device
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201119051625.2622105-1-cadel@cadelwatson.com>
References: <20201119051625.2622105-1-cadel@cadelwatson.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0158295877519543502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=387239

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


--===============0158295877519543502==--
