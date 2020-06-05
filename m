Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65297C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 05:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44200207D3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 05:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzNmibZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgFEFgM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 01:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEFgM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 01:36:12 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAF6C08C5C2
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2020 22:36:12 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id k22so7539443qtm.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2020 22:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Xklljt+uTCbdt78RrAhzL1j/VpUe76PmYMpl/7j2Oek=;
        b=mzNmibZF6sfUfAaDMIVGuOB2W6x/izXL9tUfS7MWfrZxNgHw1DVnhGnbcl4bL4zQjQ
         sdeho2ZGaIKFlQCgJlcEV6ilVXpgv3wnRuLT4s/G0/F9XifA4IL8vyrzfxGlyrcrJJYK
         iMdI80MMHXuAtCRto0JfgDsqn+pSYj4VJN0QkB9/niXTXIOxJIRE759HcKc9F8e+cVr/
         BAKmIhqCQKvNtVI2KEoijHx0Z2azd9QF7J25rwG6+U1PzreJi5IQo95VY+GWTo8GvsOt
         lNOBQ9hG+sf9975fWIJHayy9ZlSUipa4Dmkm8fa4c8zut8+2PO9s059RKtAdV/J9GD4y
         UgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Xklljt+uTCbdt78RrAhzL1j/VpUe76PmYMpl/7j2Oek=;
        b=JLMcI/94rua2DZDkU/OH8qJ1i0C4f68HGAcQvvmIEbwlrBJJiBSeHTUcGCZUApkvmL
         J/3niRilO7xz/8CNI+hm899JT1HqTwn7vwdJ3GHWpm+pr3Vsu5UXRR/BAok6ms1miW32
         G3i/mBhekHNZKjG0OG5skuyLbzKfhB1jwIpJe5yCKVHsYl3zHZsPH3iaqJpMTdwEBCZ1
         WxUA+CPvRM+P0JG8ynR3rkec5RifPLCaEwTg3N4PAii1dJzE3/vh2xFIdpN8tpP9JvzX
         6JcZMA7BWXbd4DEpY+8kNj5fFhrkyeWRID3k9hPpsByPmfV811a1FY1KYGoN9f6a5yYZ
         Ur5g==
X-Gm-Message-State: AOAM533pSf47BRYPdTk4VG6nYhSQ+tzUW/dX5bMjZkgs67SL3tyzA7FI
        nF/RJJm25kbjStb42xziXU8gdL9k4BI=
X-Google-Smtp-Source: ABdhPJySNa5W7yPLZQc0AFJt2wi/hQnN+hVOWqqtC9YfX/U5bgR+Vzdzc4Aj0CsTfMZPtINVoPK2Nw==
X-Received: by 2002:aed:38e4:: with SMTP id k91mr8341210qte.376.1591335371568;
        Thu, 04 Jun 2020 22:36:11 -0700 (PDT)
Received: from [172.17.0.2] ([52.252.59.137])
        by smtp.gmail.com with ESMTPSA id z194sm6028584qkb.73.2020.06.04.22.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 22:36:11 -0700 (PDT)
Message-ID: <5ed9d9cb.1c69fb81.ce56a.2292@mx.google.com>
Date:   Thu, 04 Jun 2020 22:36:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1887523403528274616=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tedd.an@linux.intel.com
Subject: RE: [1/2] btp: Update connect event structure
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200605051509.10766-1-tedd.an@linux.intel.com>
References: <20200605051509.10766-1-tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1887523403528274616==
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
6: B3 Line contains hard tab characters (\t): "    Controller Index:	<controller id>"
7: B3 Line contains hard tab characters (\t): "    Event parameters:	Address_Type (1 octet)"
8: B3 Line contains hard tab characters (\t): "			Address (6 octets)"
9: B3 Line contains hard tab characters (\t): "			Connection Interval (2 octets)"
10: B3 Line contains hard tab characters (\t): "			Connection Latency (2 octets)"
11: B3 Line contains hard tab characters (\t): "			Supervision Timeout (2 octets)"



---
Regards,
Linux Bluetooth

--===============1887523403528274616==--
