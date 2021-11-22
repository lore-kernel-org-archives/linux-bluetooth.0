Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17A4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Nov 2021 21:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhKVVgn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Nov 2021 16:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbhKVVgn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Nov 2021 16:36:43 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFE1C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Nov 2021 13:33:36 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id p19so17889945qtw.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Nov 2021 13:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=YR7EsNp4xGCPMLBWQtvkTbbEs/TQTWjtat/fRpfPKsc=;
        b=HK/as7rBd5hMu/TA+kshznsiN+ezlBNvO1ckTjR1GS3p7WGpvqjq00iM2x+EtvVEZf
         AGlEOtIK1d3D4Q/imfM0mFuYHUhJ+lck1OguPeEqZwoY1mi3OPk0HcvpPNWgpQEnI4x7
         HHxLBtFZ1Bz1E8pJ3n5Nzsgzo+V3PkU9VWbQtAfXtZ82gS6fKep6gOLVG+Ud3fG36Lou
         pp1vS8CuhsITF5SHQTYnMgYKh6ZnSvguW6iGhz8WDkCTl71H+AQ3fUCSUPcd9PEK35Gn
         QbJLALfQPIQJXPmiSTGpJPL8Ma5SIwBX27AQpc1IHo5HJPsUJRZU+NrEG2rGxCFr2mWF
         k6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=YR7EsNp4xGCPMLBWQtvkTbbEs/TQTWjtat/fRpfPKsc=;
        b=toUUTX3UJFvF1S/BPYwcxY2PgLeUQUiSjB3a3xyGri7UR4OJ/uVNJC0C24XZQNXUKg
         hTR164lKAJuz6CQ5QzFbyW+xWxhEWiUKh/RlkDgPG2TAl0oJ7OLFpTojMNcMVttd/0qN
         2io+wTU0ILHTsyBdyl5Ry7BuL+KMsqGeab5ctUFkUrxeDqIfPzx1s2U2pGxe570iJ60S
         pZ1TNRHC2eCTLrDkxV9G0tEG1bdbgfpn5CPfMqKACt0ZlUjui2nWO422Ga0B1vokSQey
         v9ScJFSUg+i7Z9fWCnonFgppeMf8mmqMSUXlazNBS0eq6cvW9/XRPaWkxA/e3u/5+TB6
         OVNg==
X-Gm-Message-State: AOAM5308PVWoXs2/WMfSoMVvrTaCOdCkoUDSLp5mggSCO7xP2b4iUhNU
        AnWG1ZpORZ/ZAnSeAqI6uj94IcC0vbv/GhYe
X-Google-Smtp-Source: ABdhPJxQKNktzIdrLsMWuYOZyAWQj2StlukMlJgFVKG+36e0i6rc5/D7X7uB9FUcFpaO5zz7d+HFtQ==
X-Received: by 2002:a05:622a:1043:: with SMTP id f3mr347103qte.233.1637616815098;
        Mon, 22 Nov 2021 13:33:35 -0800 (PST)
Received: from [172.17.0.2] ([20.110.173.109])
        by smtp.gmail.com with ESMTPSA id l1sm5275650qkp.125.2021.11.22.13.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 13:33:34 -0800 (PST)
Message-ID: <619c0cae.1c69fb81.d6dba.be2c@mx.google.com>
Date:   Mon, 22 Nov 2021 13:33:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5388656259440779935=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] uhid: Remove local copy of uhid header
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211122211707.2219208-1-luiz.dentz@gmail.com>
References: <20211122211707.2219208-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5388656259440779935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=584157

---Test result---

Test Summary:
CheckPatch                    PASS      1.37 seconds
GitLint                       PASS      0.97 seconds
Prep - Setup ELL              PASS      42.74 seconds
Build - Prep                  PASS      0.50 seconds
Build - Configure             PASS      8.03 seconds
Build - Make                  PASS      182.26 seconds
Make Check                    PASS      9.75 seconds
Make Distcheck                PASS      218.98 seconds
Build w/ext ELL - Configure   PASS      8.10 seconds
Build w/ext ELL - Make        PASS      173.15 seconds



---
Regards,
Linux Bluetooth


--===============5388656259440779935==--
