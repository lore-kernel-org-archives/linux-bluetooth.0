Return-Path: <SRS0=BM5K=DF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF78C2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 18:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE09520809
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 18:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzWMoQFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgI1Swm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Sep 2020 14:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgI1Swm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Sep 2020 14:52:42 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14724C061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 11:52:42 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id cr8so997042qvb.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=YHEsef9Errd3Sr1fVcmcPuRWiulewEJjGO3lezfFZSs=;
        b=kzWMoQFSaefG4wA+Kfh72f05QPwKT74J61M3mcqMRjMbzsAbPLnkqimXpuFg6dyDg6
         splPMO/5sD9duaAfdS4P4s9HHJuUNoTpx4I7WhPjEBbbRU1HYEIOgYCdtGjeDTIwIl25
         0ZMQ8TP+LHRwHqz64COc/SmZ8/BJC33yE8ciai3AFnP2ihEHWBNp+vmGFpqao3wwIfcg
         TDn3ndHdfHG+KtTrS+/EW7tuzLjPcrUm9BCZKKkKIAVpXV9cudZ5cwblcMuKEPefpDYj
         wTfwKSLW+sWaI5Bp8eCaP7olp32gqk/OJ5uTpgKYW0UqKhbkExk16+bmDguDnG6/77UN
         5EJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=YHEsef9Errd3Sr1fVcmcPuRWiulewEJjGO3lezfFZSs=;
        b=egxV7l01UEJgbTqlgVs/Ki2XvGbTsJ+2tcfVry3y2z5ejpIgyh0YFo22Z5Ar3sWT9s
         dJ0OBwncIxklvkaHYorucLEZgKNVRv8hyUfOToslT5hdJSWp9eIBhsb0ROvSbrSo8Ek3
         6VCJRQQTgFxA8Inst0GIf6R4i5/eagUjdWjGxvi4b35rH2H3icIi9pGpkyzsAZZX2Lx6
         g2LjH5zexVZ5YI3mqFt62BSB5lla5sRCoFk9oXoRBLx175+oiOIuYiR/aLR7eBWgkQWW
         k+PBYRfXj+jLkJGAL8tmja8/q6sNPdrs0KIQ1Kt8WYznY9509RqqGqABUHh4JUI/5SwW
         TIjw==
X-Gm-Message-State: AOAM531dG1+9lK+Fsfxb3xCA3nakj00rmNVkGbcA0Wwp62DVcpabfobW
        skHGcPPZ1edMky9ZaQM203N+2bis05AyDA==
X-Google-Smtp-Source: ABdhPJyKLYmtvLGacyKFL0hC+mOvLiVMFNfbBjPKxzEGGMJXpTruiW0XI8Hnz5I6M2iXlB7JYjaDrg==
X-Received: by 2002:ad4:5146:: with SMTP id g6mr863031qvq.22.1601319161164;
        Mon, 28 Sep 2020 11:52:41 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.41.78])
        by smtp.gmail.com with ESMTPSA id w2sm1870404qki.115.2020.09.28.11.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:52:40 -0700 (PDT)
Message-ID: <5f7230f8.1c69fb81.5c68a.7d9b@mx.google.com>
Date:   Mon, 28 Sep 2020 11:52:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3723063339149185150=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michaelfsun@google.com
Subject: RE: [Bluez] hog: null-check attrib channel at report_map_read_cb
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200928113550.Bluez.1.I229012141d7dab6013840265bc871a2c0712bec9@changeid>
References: <20200928113550.Bluez.1.I229012141d7dab6013840265bc871a2c0712bec9@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3723063339149185150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=356703

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
hog: null-check attrib channel at report_map_read_cb
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#12: 
frame #0: 0x00007ac089e199f7 libglib-2.0.so.0`g_io_channel_unix_get_fd at giounix.c:655

- total: 0 errors, 1 warnings, 21 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - FAIL
Output:
hog: null-check attrib channel at report_map_read_cb
9: B1 Line exceeds max length (87>80): "frame #0: 0x00007ac089e199f7 libglib-2.0.so.0`g_io_channel_unix_get_fd at giounix.c:655"
17: B1 Line exceeds max length (85>80): "frame #8: 0x00007ac089dda73b libglib-2.0.so.0`g_main_context_dispatch at gmain.c:3182"
18: B1 Line exceeds max length (84>80): "frame #9: 0x00007ac089ddaa5a libglib-2.0.so.0`g_main_context_iterate at gmain.c:3920"
21: B1 Line exceeds max length (90>80): "frame #12: 0x00005cdb607ca9fe bluetoothd`mainloop_run_with_signal at mainloop-notify.c:201"


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============3723063339149185150==--
