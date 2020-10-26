Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CE0C4363A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 21:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C092084C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 21:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eloRF7zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388322AbgJZVcP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:32:15 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:44325 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388283AbgJZVcP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 17:32:15 -0400
Received: by mail-qk1-f174.google.com with SMTP id s14so9855210qkg.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2020 14:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=DOl4ywpnzCyqyiBohicO6aIeUmrhOxId163dBcaRqaI=;
        b=eloRF7zpkLUmZ9brPXtft5mDSatoxtjd+TCUxn4yPy8O9U48x+A4PPRLHGZ78gXXNm
         0z313jK9JC650Pc0619s5CXLx5dBmOHGjORYljuRtQ+7zu3SK/jVlO9azBZboCRpu3/L
         iWmD4txjzsyjXk1yArcPnQJninaAemmeOSj2J0dic3w8jijDKFZ2hLZaSg1UG8sbENpc
         oP2SyOoWr+1sSYgEW0ao8gwqmnDbU4Wb33rfEfMAZgtvJm7epCZKISBMl45xcVtO6DwC
         /zJ8QhuSb3R5rVifmZvZCBHtZMap2RGLCwjC2mNCn15Qw+GOckx79jajp+DWO5pGxLxV
         2D5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=DOl4ywpnzCyqyiBohicO6aIeUmrhOxId163dBcaRqaI=;
        b=qQgDjz1K9NUYZl4JPK1DSNmHtp/3g8BeVxBdXXHqqMjVIQNA5ant3mixFH0GNIp0GP
         u+IaVH1mKYnBGAmyxYdIM58CMVJxRAfO1qdN2V0X1umStATClx/CIv5Ecn8o2zo+si8J
         Qe87kxU5h6WvftBgS4i6hs1bMTL0S9SddCMpsnRtbWwh8hTp9mONADagIu1bfiboPdYy
         3AZ72gfEiHK/fB56ZHA/ko6ChmXGrFom605xMJfK2/rYmViTnCqy5shkpMVKCejmnkKK
         Bip+fNqfytiC4ONQ9/wNpD7YqnVxE9yDA1vh7zAknYz+BtIk5aod4yycA0ao7HsjBt3v
         C7ww==
X-Gm-Message-State: AOAM530SG0Ehv4fDGXI9/SET2PmqNxIX5jAagBZdeyxyMkBbgXuFWg7l
        OlNqarZcDxHHMai0sxQqQNB+1t2DnpJYhQ==
X-Google-Smtp-Source: ABdhPJzOPhxUcwoRwh11agklDW2gVWUaf5+VZCjhlmwMIvkDYUBWRN/hoa3476N9yRSKj5swn+6VBA==
X-Received: by 2002:a05:620a:152:: with SMTP id e18mr3218222qkn.365.1603747933798;
        Mon, 26 Oct 2020 14:32:13 -0700 (PDT)
Received: from [172.17.0.2] ([40.123.32.112])
        by smtp.gmail.com with ESMTPSA id k15sm7849951qtk.64.2020.10.26.14.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 14:32:13 -0700 (PDT)
Message-ID: <5f97405d.1c69fb81.4c7cb.dc18@mx.google.com>
Date:   Mon, 26 Oct 2020 14:32:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5333621503699269892=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] tools/mesh-cfgclient: Fix errors found by static analysis
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201026210817.50167-1-inga.stotland@intel.com>
References: <20201026210817.50167-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5333621503699269892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=370939

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


--===============5333621503699269892==--
