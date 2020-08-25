Return-Path: <SRS0=aWoj=CD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E6EC433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Aug 2020 01:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E552072D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Aug 2020 01:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPUkWddc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgHYB2Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Aug 2020 21:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgHYB2V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Aug 2020 21:28:21 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E366C061795
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2020 18:28:21 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id p4so9604793qkf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2020 18:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=DAuNBpBgH3PMFZ1XPPlSiM7ZIOFoLNImY+P7f/YdMSU=;
        b=aPUkWddcb3QT2PdKxUVq7lODNuTjc5vGDurV+QTinJxggzK0OIzmRdHr5+Sn5JhIWQ
         GSWE2bp8JTHHE4WFg4mSV5dyx8c6DsrDgKjnIV63uRAM4nli2IDfyt2F1wyHZ8FJc2NS
         +Dvx4AqlGVAAKgGF71kRF6xKOWAas3rWM+emy7L+HGSe9OVvI+kfgSdiGjqRWclaxbyc
         JgJKInViNff59eKoC+QMgeK2yCtsrUvVg4atgn1tmIfsZea+ODYQLH2kzZDw/ErfblD6
         iDCgQJPefGmjQ8ycXtAtgmSDNcwFexfeAIYyV2xbqrQ7U2JMBm7HN1EhRdGZLoeWRy8e
         j0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=DAuNBpBgH3PMFZ1XPPlSiM7ZIOFoLNImY+P7f/YdMSU=;
        b=EG98GKUt4wKRI3UYELiwnyEkqAwrKN3WrkjXHWSAL8ClOoAEIygCN8kn1Fw3wBYm27
         L4s6P2bHy+RX7aKRmnT3tODITD11Ak4i69SF1XEYKTA5JGcPIeLz1Nw+xinuwdUgECZM
         f/0CASZ60aLKIjm3+00jmEJfwZA7QclY/UvI9Mo0O38xGvg2E6ADGfvLajQXTbUrYRA/
         mlbRoWjvRBEyVNM6mQFHXy2tPhhHINAFrYT9Rn+fAWBm742Icri02Hlm2FUawBibN6zB
         ndGjDJRiecQlE2j5nv/RkzfHmEuPGJAfGWQ/5/vRLYziBUgHiAEzWf4XVqid+uBjAVh/
         tnFQ==
X-Gm-Message-State: AOAM532U1wGmfPnsQHrmNm6fkv3eBehWVf5um24ShgOYlhDtnNUSoaPr
        NrBxY/mOYANBmtRlRjSZCophRgAh8OfxNQ==
X-Google-Smtp-Source: ABdhPJzq8eVEZYJdANzd6YEVxqUxJax/CG63rIsSE8lE812Bjyl2c3d+5Ir6o0kNUt0pMPmUuXEqlA==
X-Received: by 2002:a37:b184:: with SMTP id a126mr6738244qkf.23.1598318899857;
        Mon, 24 Aug 2020 18:28:19 -0700 (PDT)
Received: from [172.17.0.2] ([52.242.91.111])
        by smtp.gmail.com with ESMTPSA id m30sm13072329qtm.46.2020.08.24.18.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 18:28:19 -0700 (PDT)
Message-ID: <5f446933.1c69fb81.e66c0.9644@mx.google.com>
Date:   Mon, 24 Aug 2020 18:28:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0106636418685870792=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ,v2,1/4] doc/mesh-api: Add "options" dictionary to Send/Publish
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200825005435.26566-2-inga.stotland@intel.com>
References: <20200825005435.26566-2-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0106636418685870792==
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
8: B3 Line contains hard tab characters (\t): "    		      one-segment messages"



---
Regards,
Linux Bluetooth

--===============0106636418685870792==--
